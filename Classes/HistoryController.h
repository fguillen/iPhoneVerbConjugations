//
//  HistoryController.h
//  VerbConjugations
//
//  Created by Fernando Guillen on 21/01/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VerbConjugationsAppDelegate;

@interface HistoryController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	IBOutlet VerbConjugationsAppDelegate *appDelegate;
	IBOutlet UITableView *tView;
	NSArray *values;
}

@property(nonatomic, retain) NSArray *values;

- (void)reloadData;

@end
