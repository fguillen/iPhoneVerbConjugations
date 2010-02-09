//
//  DBManager.h
//  VerbConjugations
//
//  Created by Fernando Guillen on 19/01/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Verb.h"
#import <sqlite3.h>


@interface DBManager : NSObject {
}

+ (void) copyDatabaseIfNeeded;
+ (NSString *) getDBPath;
+ (Verb *) getVerbByName:(NSString *)verbName;
+ (void) saveVerb:(Verb *)verb;
+ (NSInteger) countVerbs;
+ (NSString *) verbNameAtIndex:(NSInteger)index orderBy:(NSString *) orderBy;
+ (void) deleteHistory;

@end
