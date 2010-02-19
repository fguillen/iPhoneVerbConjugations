//
//  SearchViewController.m
//  VerbConjugations
//
//  Created by Fernando Guillen on 19/01/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "SearchsController.h"
#import "VerbConjugationsAppDelegate.h"


@implementation SearchsController


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	NSLog(@"[SearchsController textFieldShouldReturn]");
	[textSearch resignFirstResponder];
	[appDelegate search:[textSearch text]];
	return YES;
}

- (void)viewDidLoad {
	NSLog( @"viewDidLoad:" );
	[[self navigationController] setNavigationBarHidden:YES animated:NO];
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
	NSLog(@"[SearchsController viewDidAppear:%d]", animated);
	[super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
	NSLog(@"[SearchsController viewWillAppear:%d]", animated);
	[[self navigationController] setNavigationBarHidden:YES animated:YES];
	[super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
	NSLog(@"[SearchsController didReceiveMemoryWarning]");
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	if( textSearch.editing ) {
		[textSearch resignFirstResponder];
	}
}



- (void)dealloc {
    [super dealloc];
}


@end
