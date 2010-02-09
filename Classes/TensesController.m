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
	NSLog(@"tableView: numberOfRowsInSection:");
	return [values count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"tableView: cellForRowAtIndexPath:");
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
	//[appDelegate tenseClicked:[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text]];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"[TensesController viewDidLoad]");
    [super viewDidLoad];
}


- (void)viewDidAppear:(BOOL)animated {
	NSLog(@"[TensesController viewDidAppear:%d]", animated);
	[super viewDidAppear:animated];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	NSLog(@"[TensesController didReceiveMemoryWarning]");
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
