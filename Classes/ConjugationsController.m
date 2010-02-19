//
//  VerbConjugationsViewController.m
//  VerbConjugations
//
//  Created by Fernando Guillen on 18/01/10.
//  Copyright FernandoGuillen.info 2010. All rights reserved.
//

#import "ConjugationsController.h"
#import "VerbConjugationsAppDelegate.h"

@implementation ConjugationsController

@synthesize values;

- (void)setValues:(NSArray *)newValues {
	NSLog(@"setValues");
	[values release];
	values = [newValues retain];
	[tView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [values count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	
	if( cell == nil ){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"cell"] autorelease];
	}
	
	cell.textLabel.text = [values objectAtIndex:indexPath.row];
	
	return cell;
}



- (void)viewDidAppear:(BOOL)animated {
	NSLog(@"[ConjugationsController viewDidAppear:%d]", animated);
	[super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
	NSLog(@"[ConjugationsController viewWillAppear:%d]", animated);
	[[self navigationController] setNavigationBarHidden:NO animated:YES];
	[super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
	NSLog(@"[ConjugationsController didReceiveMemoryWarning]");
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
	[values release];
    [super dealloc];
}

@end
