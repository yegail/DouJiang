//
//  LoginViewController.h
//  DouJiang
//
//  Created by mac  on 13-1-6.
//  Copyright (c) 2013年 mac . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <libDoubanApiEngine/DOUOAuthService.h>

@interface LoginViewController : UIViewController<UIWebViewDelegate,DOUOAuthServiceDelegate>
- (id)initWithRequestURL:(NSURL *)aURL;


@end
