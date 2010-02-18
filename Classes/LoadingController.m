//
//  LoadingController.m
//  VerbConjugations
//
//  Created by Fernando Guillen on 30/01/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "LoadingController.h"
#import "VerbConjugationsAppDelegate.h"



@implementation LoadingController

- (IBAction)cancelLoading {
	NSLog( @"[LoadingController cancelLoading]" );
	[appDelegate cancelLoading];
}


- (void)viewDidLoad {
	[cancelButton setBackgroundImage:[[UIImage imageNamed:@"redButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
	[appDelegate cancelLoading];
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
	NSLog(@"[LoadingController didReceiveMemoryWarning]");
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    [super dealloc];
}


@end
