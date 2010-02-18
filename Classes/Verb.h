//
//  Verb.h
//  VerbConjugations
//
//  Created by Fernando Guillen on 19/01/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Verb : NSObject {
	NSString *name;
	NSArray *tenses;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSArray *tenses;

+ (Verb *) initWithJson:(NSString *)jsonString;
- (NSString *) verbStructureToJson;
- (NSArray *) tensesNames;
- (NSArray *) conjugationForTenseName:(NSString *)tenseName;

@end
