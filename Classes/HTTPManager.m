//
//  HTTPManager.m
//  VerbConjugations
//
//  Created by Fernando Guillen on 21/01/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "HTTPManager.h"
#import "VerbConjugationsAppDelegate.h"
#import "JSON/JSON.h"


static NSURLConnection *connection = nil;

@implementation HTTPManager

@synthesize receivedData;
@synthesize verbName;
@synthesize appDelegate;

+ (BOOL)networkAvailable{
	NSLog( @"[HTTPManager networkAvailable]" );
	SCNetworkReachabilityRef netreach;
	SCNetworkConnectionFlags flags;
	netreach = SCNetworkReachabilityCreateWithName( kCFAllocatorSystemDefault, "vc.fernandoguillen.info" ); 
	SCNetworkReachabilityGetFlags( netreach, &flags );
	
	BOOL reachable = (kSCNetworkFlagsReachable & flags);
	NSLog( @"[HTTPManager networkAvailable] - result:%d", reachable );
	
	return reachable;
}

+ (void)getVerbByName:(NSString *)verbName appDelegate:(VerbConjugationsAppDelegate *)newAppDelegate {
	NSLog( @"[HTTPManager getVerbByName:%@]", verbName );
	
	// Checking for connection
	if( [HTTPManager networkAvailable] ){
		NSLog( @"[HTTPManager getVerbByName] - connection available" );
	} else {
		NSLog( @"[HTTPManager getVerbByName] - connection NOT available" );
		[(VerbConjugationsAppDelegate *)[[UIApplication sharedApplication] delegate] showConnectionError:@"You must be connected to Internet to access to the server"];
		return;
	}
	
	
//	NSLog( @"[HTTPManager getVerbByName] - connection retainCount:%d", [connection retainCount] );
//	if( [connection retainCount] != 0 ){
//		NSLog( @"[HTTPManager getVerbByName] - connection releasing" );
//		[connection release];
//		NSLog( @"[HTTPManager getVerbByName] - connection released" );
//	}
	
	NSString *url = [NSString stringWithFormat:@"http://vc.fernandoguillen.info/%@.json", verbName];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
	
	NSLog( @"[HTTPManager getVerbByName] - [request timeoutInterval]:%@", [request timeoutInterval] );
	
//	NSURLResponse *response;
//	NSError *error;
	
//	NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	HTTPManager *delegate = [HTTPManager alloc];
	
	delegate.verbName = verbName;
	delegate.receivedData = [[NSMutableData alloc] initWithLength:0];
	delegate.appDelegate = newAppDelegate;
	
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:delegate startImmediately:YES];
	
	NSLog( @"[HTTPManager getVerbByName] - [request timeoutInterval]:%@", [request timeoutInterval] );
	
	NSLog( @"[HTTPManager getVerbByName] - connection:%@", connection );
	
	if (connection == nil) {
		NSLog( @"[HTTPManager getVerbByName] ERROR opening connection" );
		[(VerbConjugationsAppDelegate *)[[UIApplication sharedApplication] delegate] showConnectionError:@"Error opening connection"];
	}
}

+ (void)cancelLoading{
	NSLog( @"[HTTPManager cancelLoading]" );
	[connection cancel];
	[connection release];
}


#pragma mark NSURLConnection delegate methods

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"[HTTPManager getVerbByName] didReceiveResponse:");
	
    /* This method is called when the server has determined that it has
	 enough information to create the NSURLResponse. It can be called
	 multiple times, for example in the case of a redirect, so each time
	 we reset the data. */
	
    [self.receivedData setLength:0];
}


- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	NSLog(@"[HTTPManager getVerbByName] didReceiveData:");
	
    /* Append the new data to the received data. */
    [self.receivedData appendData:data];
}


- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"[HTTPManager connection:%@ didFailWithError:%@]", connection, error);
	[appDelegate showConnectionError:@"Error on connection"];
	[connection release];
}




- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
	NSLog(@"[HTTPManager getVerbByName] connectionDidFinishLoading:"); 
	
	NSString *responseString = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
	
	Verb *verb = [[Verb alloc] retain];
	verb.name = self.verbName;
	verb.tenses = [[NSMutableDictionary dictionary] retain];
	NSArray *tenseStrutures = [responseString componentsSeparatedByString:@"|"];
	for(int n=0; n<[tenseStrutures count]; n++){
		NSString *tenseName = [[[tenseStrutures objectAtIndex:n] componentsSeparatedByString:@":"] objectAtIndex:0];
		NSString *conjugationStructure = [[[tenseStrutures objectAtIndex:n] componentsSeparatedByString:@":"] objectAtIndex:1];
		[verb.tenses setValue:[conjugationStructure componentsSeparatedByString:@","] forKey:tenseName];
	}
	
	
	NSLog( @"[HTTPManager connectionDidFinishLoading] Verb.name:%@", verb.name );

	[appDelegate searchFinished:verb];
	
	[connection release];
}


@end
