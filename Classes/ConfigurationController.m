//
//  ConfigurationController.m
//  VerbConjugations
//
//  Created by Fernando Guillen on 21/01/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "ConfigurationController.h"
#import "Constants.h"
#import "VerbConjugationsAppDelegate.h"


@implementation ConfigurationController


# pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	NSLog( @"[ConfigurationController numberOfSectionsInTableView:%@]", tableView );
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog( @"[ConfigurationController tableView:%@ numberOfRowsInSection:%d", tableView, section );
	
	NSInteger result;
	
	switch (section) {
		case 0:
			result = 2;
			break;
		case 1:
			result = 1;
			break;
		default:
			break;
	}
	return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog( @"[ConfigurationController tableView:%@ cellForRowAtIndexPath:%@]", tableView, indexPath );
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	
	switch (indexPath.section) {
		case 0:
			if( cell == nil ){
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"cell"] autorelease];
			}
			
			NSString *activedOrderBy = [[NSUserDefaults standardUserDefaults] stringForKey:HISTORY_ORDER_KEY];
			
			switch (indexPath.row) {
				case 0:
					cell.textLabel.text = @"Insertion Date";
					if( [activedOrderBy isEqualToString:HISTORY_ORDER_BY_DATE] ) {
						cell.accessoryType = UITableViewCellAccessoryCheckmark;
					}
					break;
				case 1:
					cell.textLabel.text = @"Alphabetically";
					if( [activedOrderBy isEqualToString:HISTORY_ORDER_BY_ALPHABETICALLY] ) {
						cell.accessoryType = UITableViewCellAccessoryCheckmark;
					}
					break;
				default:
					break;
			}
			
			break;
		case 1:
			cell = deleteHistoryCell;
			break;
		default:
			break;
	}
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	
	NSString *title;
	switch (section) {
		case 0:
			title = @"History order by";
			break;
		case 1:
			title = @"History delete";
			break;
		default:
			break;
	}
	
	return title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSLog( @"[ConfigurationController tableView:%@ didSelectRowAtIndexPath:%@]", tableView, indexPath );
	
	if( indexPath.section == 0 ){
		
		switch ( indexPath.row ) {
			case 0:
				[appDelegate selectHistoryOrderBy:HISTORY_ORDER_BY_DATE];
				

				break;
			case 1:
				[appDelegate selectHistoryOrderBy:HISTORY_ORDER_BY_ALPHABETICALLY];
				break;
			default:
				break;
		}		
		
		[tView deselectRowAtIndexPath:indexPath animated:YES];

		// mark our cell as checked
		UITableViewCell *cell = [tView cellForRowAtIndexPath:indexPath];
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
		
		// mark the other cell as not checked
		NSInteger otherRow = 0;
		if( indexPath.row == 0 ) otherRow = 1;
		NSIndexPath *otherIndexPath = [NSIndexPath indexPathForRow:otherRow inSection:0];
		UITableViewCell *otherCell = [tView cellForRowAtIndexPath:otherIndexPath];
		otherCell.accessoryType = UITableViewCellAccessoryNone;
	}
}

# pragma mark my methods

- (IBAction)deleteHistory{
	[appDelegate deleteHistory];
}

- (void)reloadData{
	NSLog(@"[ConfigurationController reloadData]");
	[tView reloadData];
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

- (void)viewDidLoad {
	[deleteButton setBackgroundImage:[[UIImage imageNamed:@"redButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [super viewDidLoad];
}


# pragma mark etc

- (void)viewDidAppear:(BOOL)animated {
	NSLog(@"[ConfigurationController viewDidAppear:%@]", animated);
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
	NSLog(@"[ConfigurationController didReceiveMemoryWarning]");
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
