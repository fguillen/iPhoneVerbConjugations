//
//  SearchViewController.h
//  VerbConjugations
//
//  Created by Fernando Guillen on 19/01/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VerbConjugationsAppDelegate;


@interface SearchsController : UIViewController <UITextFieldDelegate>{
	IBOutlet VerbConjugationsAppDelegate *appDelegate;
	IBOutlet UITextField *textSearch;
}


@end
