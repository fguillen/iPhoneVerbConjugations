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
	NSMutableDictionary *tenses;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSMutableDictionary *tenses;

+ (Verb *) initWithJson:(NSString *)jsonString;
- (NSString *) verbStructureToJSON;

@end
