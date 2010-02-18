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
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
	NSLog(@"[SearchsController viewDidAppear:%d]", animated);
	[super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning {
	NSLog(@"[SearchsController didReceiveMemoryWarning]");
    [super didReceiveMemoryWarning];
}



- (void)dealloc {
    [super dealloc];
}


@end
