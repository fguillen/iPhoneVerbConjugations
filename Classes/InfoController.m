//
//  InfoController.m
//  VerbConjugations
//
//  Created by Fernando Guillen on 21/01/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "InfoController.h"


@implementation InfoController

- (void)viewDidLoad {
	[self chargeWebView:webView fromBundleFileName:@"info.html"];
	webView.delegate = self;
    [super viewDidLoad];
}

- (void)chargeWebView:(UIWebView *)theWebView fromBundleFileName:(NSString *)fileName{
	NSString *filePath =[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
	NSData *htmlData = [NSData dataWithContentsOfFile:filePath];
	if (htmlData) {
		NSString *path = [[NSBundle mainBundle] bundlePath];
		NSURL *baseURL = [NSURL fileURLWithPath:path];
		[theWebView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
	}	
}

- (void)viewDidAppear:(BOOL)animated {
	NSLog(@"[InfoController viewDidAppear:%d]", animated);
	[super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning {
	NSLog(@"[InfoController didReceiveMemoryWarning]");
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
	NSLog( @"[InfoController webView: shouldStartLoadWithRequest:%@]", request );
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
	return YES;
}


@end
