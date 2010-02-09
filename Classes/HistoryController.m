//
//  HistoryController.m
//  VerbConjugations
//
//  Created by Fernando Guillen on 21/01/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "HistoryController.h"
#import "VerbConjugationsAppDelegate.h"
#import "DBManager.h"
#import "Constants.h"

@implementation HistoryController

@synthesize values;

- (void)setValues:(NSArray *)newValues {
	NSLog(@"setValues");
	[values release];
	values = [newValues retain];
	[tView reloadData];
}




/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


- (void)viewDidLoad {
	NSLog( @"[HistoryController viewDidLoad]" );
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
	NSLog(@"[HistoryController viewDidAppear:%d]", animated);
	[super viewDidAppear:animated];
}


- (void)reloadData {
	NSLog(@"[HistoryController reloadData]");
	[tView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@"tableView: numberOfRowsInSection:");
	return [DBManager countVerbs];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"tableView: cellForRowAtIndexPath:");
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	
	if( cell == nil ){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"cell"] autorelease];
	}
	
	cell.textLabel.text = [DBManager verbNameAtIndex:indexPath.row orderBy:[[NSUserDefaults standardUserDefaults] stringForKey:HISTORY_ORDER_KEY]];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog( @"aqui" );
	NSLog( @"[HistoryController didSelectRowAtIndexPath:{%d, %d}]", indexPath.section, indexPath.row );
	[appDelegate search:[[[tView cellForRowAtIndexPath:indexPath] textLabel] text]];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	NSLog(@"[HistoryController didReceiveMemoryWarning]");
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
