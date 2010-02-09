//
//  ConfigurationController.h
//  VerbConjugations
//
//  Created by Fernando Guillen on 21/01/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VerbConjugationsAppDelegate;


@interface ConfigurationController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet VerbConjugationsAppDelegate *appDelegate;
	IBOutlet UITableViewCell *deleteHistoryCell;
	IBOutlet UITableView *tView;
	IBOutlet UIButton *deleteButton;
}

- (IBAction)deleteHistory;
- (void)reloadData;

@end
