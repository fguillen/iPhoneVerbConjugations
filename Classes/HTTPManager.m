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

	NSString *url = [NSString stringWithFormat:@"http://vc.fernandoguillen.info/%@.json", verbName];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
	
	HTTPManager *delegate = [[HTTPManager alloc] init];
	
	delegate.verbName = verbName;
	delegate.receivedData = [[NSMutableData alloc] initWithLength:0];
	delegate.appDelegate = newAppDelegate;
	
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:delegate startImmediately:YES];
	
	if (connection == nil) {
		NSLog( @"[HTTPManager getVerbByName] ERROR opening connection" );
		[(VerbConjugationsAppDelegate *)[[UIApplication sharedApplication] delegate] showConnectionError:@"Error opening connection"];
	}
	
	[delegate release];
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
	NSLog( @"[HTTPManager connectionDidFinishLoading:] - responseString:%@", responseString );
	
	if( [responseString hasPrefix:@"ERROR"] ){
		NSLog( @"[HTTPManager connectionDidFinishLoading:] - error request" );
		[appDelegate searchFinishedWithError];
	} else {
		Verb *verb = [Verb initWithJson:responseString];  
		NSLog( @"[HTTPManager connectionDidFinishLoading] Verb.name:%@", verb.name );
		[appDelegate searchFinished:verb];
	}
	   
	[responseString release];

	[connection release];
}


@end
