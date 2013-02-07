//
//  LoginViewController.m
//  DouJiang
//
//  Created by mac  on 13-1-6.
//  Copyright (c) 2013年 mac . All rights reserved.
//

#import "LoginViewController.h"
#import <libDoubanApiEngine/DOUAPIEngine.h>


static NSString * const kAPIKey = @"0344ff593a7dc0c009cefe0baf794240";
static NSString * const kPrivateKey = @"c289d7320b3d79e7";
static NSString * const kRedirectUrl = @"http://book.douban.com/";


@interface NSString (ParseCategory)
- (NSMutableDictionary *)explodeToDictionaryInnerGlue:(NSString *)innerGlue
                                           outterGlue:(NSString *)outterGlue;
@end

@implementation NSString (ParseCategory)

- (NSMutableDictionary *)explodeToDictionaryInnerGlue:(NSString *)innerGlue
                                           outterGlue:(NSString *)outterGlue {
    // Explode based on outter glue
    NSArray *firstExplode = [self componentsSeparatedByString:outterGlue];
    NSArray *secondExplode;
    
    // Explode based on inner glue
    NSInteger count = [firstExplode count];
    NSMutableDictionary* returnDictionary = [NSMutableDictionary dictionaryWithCapacity:count];
    for (NSInteger i = 0; i < count; i++) {
        secondExplode =
        [(NSString*)[firstExplode objectAtIndex:i] componentsSeparatedByString:innerGlue];
        if ([secondExplode count] == 2) {
            [returnDictionary setObject:[secondExplode objectAtIndex:1]
                                 forKey:[secondExplode objectAtIndex:0]];
        }
    }
   
    return returnDictionary;
}

@end



@interface LoginViewController ()

@property (nonatomic,retain) UIWebView *webView;
@property (nonatomic,retain) NSURL *requestURL;

@end

@implementation LoginViewController

@synthesize requestURL = requestURL_;
@synthesize webView = webView_;


#pragma mark - View lifecycle
- (id)initWithRequestURL:(NSURL *)aURL{
    self = [super init];
    if (self) {
        self.requestURL = aURL;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    webView_ = [[UIWebView alloc]initWithFrame:CGRectMake(0,
                                                          0,
                                                          self.view.bounds.size.width,
                                                          self.view.bounds.size.height - 49)];
    webView_.scalesPageToFit = YES;
	webView_.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL_];
    [webView_ loadRequest:request];
    [self.view addSubview:webView_];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL *urlObj = [request URL];
    NSString *url = [urlObj absoluteString];
    
    if ([url hasPrefix:kRedirectUrl]) {
        NSString *query = [urlObj query];
        NSMutableDictionary *parsedQuery = [query explodeToDictionaryInnerGlue:@"=" outterGlue:@"&"];
        
        NSString *error = [parsedQuery objectForKey:@"error"];
        if (error) {
            return NO;
        }
        NSString *code = [parsedQuery objectForKey:@"code"];
        DOUOAuthService *service = [DOUOAuthService sharedInstance];
        service.authorizationURL = kTokenUrl;
        service.delegate = self;
        service.clientId = kAPIKey;
        service.clientSecret = kPrivateKey;
        service.callbackURL = kRedirectUrl;
        service.authorizationCode = code;
        [service validateAuthorizationCode];
        
        return NO;
    }
    
    return YES;
}

- (void)OAuthClient:(DOUOAuthService *)client didAcquireSuccessDictionary:(NSDictionary *)dic {
    
    NSLog(@"success!");
    [self.navigationController popViewControllerAnimated:YES];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dic forKey:@"successDic"];
}

- (void)OAuthClient:(DOUOAuthService *)client didFailWithError:(NSError *)error {
    NSLog(@"Fail!");
}

@end
