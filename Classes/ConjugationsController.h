//
//  VerbConjugationsViewController.h
//  VerbConjugations
//
//  Created by Fernando Guillen on 18/01/10.
//  Copyright FernandoGuillen.info 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VerbConjugationsAppDelegate;

@interface ConjugationsController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	IBOutlet VerbConjugationsAppDelegate *appDelegate;
	IBOutlet UITableView *tView;
	NSArray *values;
}

@property (nonatomic, retain) NSArray *values;

@end

