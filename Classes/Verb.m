//
//  Verb.m
//  VerbConjugations
//
//  Created by Fernando Guillen on 19/01/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "Verb.h"



@implementation Verb

@synthesize tenses;
@synthesize name;

+ (Verb *) initWithJson:(NSString *)jsonString{
	return NULL;
}

- (NSString *) verbStructureToJSON{
	NSString *verbStructure = @"";
	NSString *tense;
	
	for (tense in [self.tenses allKeys]) {
		if( [verbStructure length] != 0 ){
			verbStructure = [NSString stringWithFormat:@"%@|", verbStructure, @"|"];
		}
		NSString *conjugations = [[self.tenses objectForKey:tense] componentsJoinedByString:@","];
		verbStructure = [NSString stringWithFormat:@"%@%@:%@", verbStructure, tense, conjugations];
	}
	
	NSLog(@"verbStructure:%@", verbStructure);
	
	return verbStructure;
}
	

@end
