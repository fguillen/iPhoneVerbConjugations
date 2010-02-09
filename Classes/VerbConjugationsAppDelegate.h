//
//  VerbConjugationsAppDelegate.h
//  VerbConjugations
//
//  Created by Fernando Guillen on 18/01/10.
//  Copyright FernandoGuillen.info 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ConjugationsController;
@class TensesController;
@class SearchsController;
@class ConfigurationController;
@class InfoController;
@class HistoryController;
@class LoadingController;
@class Verb;

@interface VerbConjugationsAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, UIAlertViewDelegate> {
    IBOutlet UIWindow *window;
	IBOutlet UINavigationController *masterNavController;
	IBOutlet UINavigationController *verbsNavController;
	IBOutlet LoadingController *loadingController;
	IBOutlet UITabBarController *tabController;
    IBOutlet ConjugationsController *conjugationsController;
	IBOutlet TensesController *tensesController;
	IBOutlet SearchsController *searchsController;
	IBOutlet ConfigurationController *configurationController;
	IBOutlet InfoController *infoController;
	IBOutlet HistoryController *historyController;
//	IBOutlet UITabBarController *tabController;
	Verb *verb;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) Verb *verb;

- (void)tenseClicked:(NSString *)tenseName;
- (void)search:(NSString *)verbName;
- (void)searchFinished:(Verb *)verb;
- (void)deleteHistory;
- (void)defaultConfiguration;
- (void)selectHistoryOrderBy:(NSString *)orderByKey;
- (void)cancelLoading;
- (void)showConnectionError:(NSString *)error;


@end

