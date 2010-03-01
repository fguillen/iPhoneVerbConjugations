//
//  VerbConjugationsAppDelegate.m
//  VerbConjugations
//
//  Created by Fernando Guillen on 18/01/10.
//  Copyright FernandoGuillen.info 2010. All rights reserved.
//

#import "VerbConjugationsAppDelegate.h"
#import "ConfigurationController.h"
#import "InfoController.h"
#import "ConjugationsController.h"
#import "TensesController.h"
#import "SearchsController.h"
#import "HistoryController.h"
#import "LoadingController.h"
#import "Verb.h"
#import "DBManager.h"
#import "HTTPManager.h"
#import "Constants.h"

@implementation VerbConjugationsAppDelegate

@synthesize window;
@synthesize verb;

- (void)defaultConfiguration {
	NSLog( @"[VerbConjugationsAppDelegate defaultConfiguration]" );
	[DBManager copyDatabaseIfNeeded];
	if( [[NSUserDefaults standardUserDefaults] stringForKey:HISTORY_ORDER_KEY] == NULL ){
		NSLog( @"[VerbConjugationsAppDelegate defaultConfiguration] setting default HistoryOrderBy" );
		[[NSUserDefaults standardUserDefaults] setObject:HISTORY_ORDER_BY_DATE forKey:HISTORY_ORDER_KEY];
	}
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
	NSLog( @"tabBarController:%d, didSelectViewController:%d", @"a", @"b" );
}


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    NSLog( @"applicationDidFinishLaunching" );

	[self defaultConfiguration];

	verbsNavController.viewControllers = [NSArray arrayWithObject:searchsController];
	
    [window addSubview:tabController.view];
    [window makeKeyAndVisible];
}

- (void)deleteHistory{
	NSLog( @"[VerbConjugationsAppDelegate deleteHistory]" );
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"Are you sure you want to delete the already cached history?" delegate:self cancelButtonTitle:@"Don't do it" otherButtonTitles:@"Go ahead", nil];
	[alert show];
	[alert release];
}

- (void)search:(NSString *)verbName {
	NSLog(@"VerbConjugationsAppDelegate.search: %@", verbName);

	NSLog( @"[VerbConjugationsAppDelegate.search:] - asking to DBManager" );
	self.verb = [DBManager getVerbByName:verbName];
	NSLog( @"[VerbConjugationsAppDelegate.search:] - continuing" );
	
	if( self.verb == nil ){
		[tabController presentModalViewController:loadingController animated:YES];
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];		
		[HTTPManager getVerbByName:verbName appDelegate:self];
	} else {
		tensesController.values = [self.verb tensesNames];
		verbsNavController.viewControllers = [NSArray arrayWithObject:searchsController];
		[verbsNavController pushViewController:tensesController animated:YES];
		tabController.selectedIndex = 0;
	}
}

- (void)searchFinished:(Verb *)newVerb {
	NSLog( @"VerbConjugationsAppDelegate searchFinished]" );
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[tabController dismissModalViewControllerAnimated:YES];
	
	[self.verb release];
	self.verb = newVerb;
	
	[DBManager saveVerb:self.verb];
	[historyController reloadData];
	tensesController.values = [self.verb tensesNames];
	verbsNavController.viewControllers = [NSArray arrayWithObject:searchsController];
	[verbsNavController pushViewController:tensesController animated:YES];
	tabController.selectedIndex = 0;
}

- (void) searchFinishedWithError{
	NSLog( @"VerbConjugationsAppDelegate searchFinishedWithError]" );
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[tabController dismissModalViewControllerAnimated:YES];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Verb Not Found" message:@"Please, check the verb you have entered, it has to be an infinitive Spanish Verb" delegate:self cancelButtonTitle:@"Ok!" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (void)tenseClicked:(NSString *)tenseName {
	NSLog( @"VerbConjugationsAppDelegate.tenseClicked: %d", tenseName );
	[conjugationsController setValues:[self.verb conjugationForTenseName:tenseName]];
	[verbsNavController pushViewController:conjugationsController animated:YES];
}

- (void)selectHistoryOrderBy:(NSString *)orderByKey{
	NSLog( @"[VerbConjugationsAppDelegate selectHistoryOrderBy:%@]", orderByKey );
	[[NSUserDefaults standardUserDefaults] setObject:orderByKey forKey:HISTORY_ORDER_KEY];
	[historyController reloadData];
}


- (void)cancelLoading{
	NSLog( @"[VerbConjugationsAppDelegate cancelLoading]" );
	[HTTPManager cancelLoading];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[tabController dismissModalViewControllerAnimated:YES];
}

- (void)showConnectionError:(NSString *)error{
	NSLog( @"[VerbConjugationsAppDelegate showConnectionError:%@]", error );
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:error delegate:self cancelButtonTitle:@"Ok!" otherButtonTitles:nil];
	[alert show];
	[alert release];

	NSLog( @"[VerbConjugationsAppDelegate showConnectionError:END]" );
}



#pragma mark UIAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	NSLog( @"[VerbConjugationsAppDelegate alertView:%@ clickedButtonAtIndex:%d]", alertView, buttonIndex );
	NSLog( @"[VerbConjugationsAppDelegate alertView: clickedButtonAtIndex:] - alert.title:%@", alertView.title );
	
	if( [alertView.title isEqualToString:@"Connection Error"] ){
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		[tabController dismissModalViewControllerAnimated:YES];
	} else if( buttonIndex == 1 ){
		[DBManager deleteHistory];
		NSLog( @"[VerbConjugationsAppDelegate deleteHistory], history deleted" );
		historyController.reloadData;
	}
}

#pragma mark dealloc

- (void)dealloc {
	NSLog( @"dealloc" );
    [conjugationsController release];
	[verb release];
    [window release];
    [super dealloc];
}


@end
