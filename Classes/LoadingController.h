//
//  LoadingController.h
//  VerbConjugations
//
//  Created by Fernando Guillen on 30/01/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VerbConjugationsAppDelegate;


@interface LoadingController : UIViewController {
	IBOutlet VerbConjugationsAppDelegate *appDelegate;
	IBOutlet UIButton *cancelButton;
}

- (IBAction)cancelLoading;
@end
