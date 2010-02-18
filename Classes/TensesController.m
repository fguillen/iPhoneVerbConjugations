//
//  TenseViewController.m
//  VerbConjugations
//
//  Created by Fernando Guillen on 18/01/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "TensesController.h"
#import "VerbConjugationsAppDelegate.h"



@implementation TensesController

@synthesize values;

- (void)setValues:(NSArray *)newValues {
	NSLog(@"setValues");
	[values release];
	values = [newValues retain];
	[tView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@"[TensesController tableView:%@ numberOfRowsInSection:%@", tableView, section);
	return [values count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"[TenseViewController tableView:%@ cellForRowAtIndexPath:%@", tableView, indexPath);
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	
	if( cell == nil ){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"cell"] autorelease];
	}
	
	cell.textLabel.text = [values objectAtIndex:indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog( @"cell clicked xx {%d, %d}", indexPath.section, indexPath.row );
	[appDelegate tenseClicked:[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text]];
	NSLog( @"cell clicked yy {%d, %d}", indexPath.section, indexPath.row );
}

- (void)viewDidLoad {
	NSLog(@"[TensesController viewDidLoad]");
    [super viewDidLoad];
}


- (void)viewDidAppear:(BOOL)animated {
	NSLog(@"[TensesController viewDidAppear:%d]", animated);
	[super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
	NSLog(@"[TensesController didReceiveMemoryWarning]");
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
	[values release];
    [super dealloc];
}


@end
