//
//  HTTPManager.h
//  VerbConjugations
//
//  Created by Fernando Guillen on 21/01/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Verb.h"
#import <SystemConfiguration/SystemConfiguration.h>

@class VerbConjugationsAppDelegate;

@interface HTTPManager : NSObject {
	NSMutableData *receivedData;
	NSString *verbName;
	VerbConjugationsAppDelegate *appDelegate;
	
}

@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSString *verbName;
@property (nonatomic, retain) VerbConjugationsAppDelegate *appDelegate;

+ (void)getVerbByName:(NSString *)verbName appDelegate:(VerbConjugationsAppDelegate *)newAppDelegate;
+ (void)cancelLoading;
+ (BOOL)networkAvailable;

@end
	

