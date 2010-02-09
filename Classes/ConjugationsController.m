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

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//	NSLog( @"cell clicked xx {%d, %d}", indexPath.section, indexPath.row );
//	[appDelegate tenseClicked:[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text]];
//	NSLog( @"cell clicked yy {%d, %d}", indexPath.section, indexPath.row );
//	//[appDelegate tenseClicked:[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text]];
//}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
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


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (void)viewDidAppear:(BOOL)animated {
	NSLog(@"[ConjugationsController viewDidAppear:%d]", animated);
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
	NSLog(@"[ConjugationsController didReceiveMemoryWarning]");
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
