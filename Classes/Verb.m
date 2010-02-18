//
//  Verb.m
//  VerbConjugations
//
//  Created by Fernando Guillen on 19/01/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "Verb.h"
#import "JSON.h"

@implementation Verb

@synthesize tenses;
@synthesize name;

+ (Verb *) initWithJson:(NSString *)jsonString{
	NSLog( @"[Verb initWithJson:%@]", jsonString );
		
	SBJSON *json = [[SBJSON new] autorelease];
	NSDictionary *parsedJSON = [json objectWithString:jsonString error:NULL];

	Verb *verb = [[Verb alloc] init];

	verb.name = [parsedJSON objectForKey:@"name"];
	verb.tenses = [parsedJSON objectForKey:@"tenses"];
	
	NSLog( @"name: %@", verb.name );
	NSLog( @"tenses: %@", verb.tenses );
	
	[verb autorelease];
	return verb;
}

- (NSString *) verbStructureToJson{
	SBJSON *json = [SBJSON new];
	NSString *tensesJson = [json stringWithObject:self.tenses error:NULL];
	[json release];
	NSLog(@"verbStructure:%@", tensesJson);
	
	return tensesJson;
}

- (NSArray *) tensesNames{
	NSLog( @"[Verb tensesNames]" );
	NSMutableArray *names = [NSMutableArray arrayWithCapacity:[self.tenses count]];
	
	for( NSDictionary *tense in self.tenses ){
		[names addObject:(NSString *)[tense objectForKey:@"name"]];
	}
		 
	return names;
}

- (NSArray *) conjugationForTenseName:(NSString *)tenseName{
	NSLog( @"[Verb conjugationForTenseName:%@]", tenseName );
	
	NSArray *conjugations;
	
	for( NSDictionary *tense in self.tenses ){
		if( [(NSString *)[tense objectForKey:@"name"] isEqualToString:tenseName] ){
			conjugations = (NSArray *)[tense objectForKey:@"conjugations"];
		}
	}
	
	return conjugations;
}

- (void)dealloc{
	NSLog( @"[Verb dealloc] - name:%@", self.name );
	[name release];
	[tenses release];
	[super dealloc];
}
	

@end
