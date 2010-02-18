//
//  DBManager.m
//  VerbConjugations
//
//  Created by Fernando Guillen on 19/01/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "DBManager.h"
#import "Verb.h"
#import "Constants.h"
#import "JSON.h"

@implementation DBManager

+ (void) copyDatabaseIfNeeded {
	NSLog( @"[DBManager copyDatabaseIfNeeded]" );
	
	//Using NSFileManager we can perform many file system operations.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath = [self getDBPath];
	BOOL success = [fileManager fileExistsAtPath:dbPath];
	
	if(!success) {
		NSLog( @"[DBManager copyDatabaseIfNeeded] -> database doesn't exists, coping" );
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"verbs.sqlite3.db"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success)
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
}

+ (NSString *) getDBPath {	
	//Search for standard documents using NSSearchPathForDirectoriesInDomains
	//First Param = Searching the documents directory
	//Second Param = Searching the Users directory and not the System
	//Expand any tildes and identify home directories.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"verbs.sqlite3.db"];
}

+ (Verb *) getVerbByName:(NSString *)verbName {
	NSLog( @"[DBManager getVerbByName:%@]", verbName );
	
	sqlite3 *db;
	
	Verb *newVerb = [[Verb alloc] init];
	BOOL found = NO;
	
	if (sqlite3_open([[DBManager getDBPath] UTF8String], &db) == SQLITE_OK) {
		NSString *sql = [NSString stringWithFormat:@"select verb_structure from verbs where verb_name = '%@'", verbName];
		NSLog( @"[DBManager getVerbByName] -> executing sql: %@", sql );

		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(db, [sql cStringUsingEncoding:NSUTF8StringEncoding], -1, &selectstmt, NULL) == SQLITE_OK) {			
			if(sqlite3_step(selectstmt) == SQLITE_ROW) {
				found = YES;
				
				newVerb.name = verbName;
				
				NSString *tensesJson = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 0)];
				SBJSON *json = [SBJSON new];
				newVerb.tenses = [json objectWithString:tensesJson error:NULL];
				[json release];
			}
		}
		sqlite3_finalize(selectstmt);
	} else {
		NSLog( @"[DBManager getVerbByName] -> ERROR" );
	}
	
	if( sqlite3_close(db) != SQLITE_OK ) {
		NSLog( @"[DBManager getVerbByName] -> ERROR: closing db" );
	}
	
	
	NSLog( @"[DBManager getVerbByName:%@] - going out", verbName );

	[newVerb autorelease];
	
	if( found ) {
		return newVerb;
	} else {
		return nil;
	}	
}

+ (void) saveVerb:(Verb *) verb{
	NSLog( @"[DBManager saveVerb:%@]", verb.name );
	
	int rc;
	char *zErrMsg = 0;
	sqlite3 *db;
	
	if (sqlite3_open([[DBManager getDBPath] UTF8String], &db) == SQLITE_OK) {
		NSString *sql = [NSString stringWithFormat:@"insert into verbs (verb_name, verb_structure) values ('%@', '%@');", verb.name, [verb verbStructureToJson]];
		NSLog(@"sql:%@", sql);
		rc = sqlite3_exec(db, [sql cStringUsingEncoding:NSUTF8StringEncoding], 0, 0, &zErrMsg);
		if(  rc != SQLITE_OK ){
			NSLog( @"[DBManager saveVerb] -> ERROR: insert into: %s", zErrMsg );
			sqlite3_free(zErrMsg);
		}
	} else {
		NSLog( @"[DBManager saveVerb] -> ERROR: opening DB" );
	}
	
	if( sqlite3_close(db) != SQLITE_OK ) {
		NSLog( @"[DBManager saveVerb] -> ERROR: closing db" );
	}
}

+ (NSInteger) countVerbs{
	NSLog( @"[DBManager countVerbs]" );
	sqlite3 *db;
	
	NSInteger result;
	
	if (sqlite3_open([[DBManager getDBPath] UTF8String], &db) == SQLITE_OK) {
		NSString *sql = [NSString stringWithFormat:@"select count(*) from verbs"];
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(db, [sql cStringUsingEncoding:NSUTF8StringEncoding], -1, &selectstmt, NULL) == SQLITE_OK) {			
			if(sqlite3_step(selectstmt) == SQLITE_ROW) {
				result = (NSInteger)sqlite3_column_int(selectstmt, 0);
			}
		}
		sqlite3_finalize(selectstmt);
	} else {
		NSLog( @"[DBManager countVerbs] -> ERROR" );
	}
	
	if( sqlite3_close(db) != SQLITE_OK ) {
		NSLog( @"[DBManager countVerbs] -> ERROR: closing db" );
	}
	
	NSLog( @"[DBManager countVerbs] result:%d", result );
	
	return result;				
}

+ (NSString *) verbNameAtIndex:(NSInteger)index orderBy:(NSString *) orderBy{
	NSLog( @"[DBManager verbNameAtIndex:%d orderBy:%@]", index, orderBy );
	
	NSString *sqlOrderBy = [orderBy isEqualToString:HISTORY_ORDER_BY_ALPHABETICALLY] ? @"verb_name asc" : @"verb_id desc";
	
	sqlite3 *db;
	
	NSString *result;
	
	if (sqlite3_open([[DBManager getDBPath] UTF8String], &db) == SQLITE_OK) {
		NSString *sql = [NSString stringWithFormat:@"select verb_name from verbs order by %@ limit %d,1", sqlOrderBy, index];
		
		NSLog( @"[DBManager verbNameAtIndex] - sql:%@", sql );
		
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(db, [sql cStringUsingEncoding:NSUTF8StringEncoding], -1, &selectstmt, NULL) == SQLITE_OK) {			
			if(sqlite3_step(selectstmt) == SQLITE_ROW) {
				result = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 0)];
			}
		}
		sqlite3_finalize(selectstmt);
	} else {
		NSLog( @"[DBManager verbNameAtIndex] -> ERROR" );
	}

	if( sqlite3_close(db) != SQLITE_OK ) {
		NSLog( @"[DBManager verbNameAtIndex] -> ERROR: closing db" );
	}
	
	NSLog( @"[DBManager verbNameAtIndex] result:%@", result );
	
	return result;	
}

+ (void) deleteHistory{
	NSLog( @"[DBManager deleteHistory]" );
	
	int rc;
	char *zErrMsg = 0;
	sqlite3 *db;
	
	if (sqlite3_open([[DBManager getDBPath] UTF8String], &db) == SQLITE_OK) {
		NSString *sql = [NSString stringWithFormat:@"delete from verbs;"];
		NSLog(@"sql:%@", sql);
		
		rc = sqlite3_exec(db, [sql cStringUsingEncoding:NSUTF8StringEncoding], 0, 0, &zErrMsg);
		if(  rc != SQLITE_OK ){
			NSLog( @"[DBManager saveVerb] -> ERROR: deleteHistory" );
			sqlite3_free(zErrMsg);
		}
	} else {
		NSLog( @"[DBManager saveVerb] -> ERROR: opening DB" );
	}
	
	if( sqlite3_close(db) != SQLITE_OK ) {
		NSLog( @"[DBManager saveVerb] -> ERROR: closing db" );
	}
}

@end
