//
//  TenseViewController.h
//  VerbConjugations
//
//  Created by Fernando Guillen on 18/01/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VerbConjugationsAppDelegate;

@interface TensesController : UIViewController <UITableViewDataSource> {
	IBOutlet VerbConjugationsAppDelegate *appDelegate;
	IBOutlet UITableView *tView;
	NSArray *values;
}

@property(nonatomic, retain) NSArray *values;

@end
