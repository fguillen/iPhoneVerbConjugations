//
//  InfoController.h
//  VerbConjugations
//
//  Created by Fernando Guillen on 21/01/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InfoController : UIViewController <UIWebViewDelegate> {
	IBOutlet UIWebView *webView;
}

- (void)chargeWebView:(UIWebView *)theWebView fromBundleFileName:(NSString *)fileName;

@end
