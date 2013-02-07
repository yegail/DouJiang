//
//  ViewController.m
//  DouJiang
//
//  Created by mac  on 13-1-6.
//  Copyright (c) 2013年 mac . All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import <libDoubanApiEngine/DOUAPIEngine.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize userImage;
@synthesize userName;

static NSString * const kAPIKey = @"0344ff593a7dc0c009cefe0baf794240";
static NSString * const kPrivateKey = @"c289d7320b3d79e7";
static NSString * const kRedirectUrl = @"http://book.douban.com/";

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    NSString *str = [NSString stringWithFormat:@"https://www.douban.com/service/auth2/auth?client_id=%@&redirect_uri=%@&response_type=code&scope=book_basic_r",kAPIKey,kRedirectUrl];
    NSString *urlStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    UIViewController *loginViewController = [[LoginViewController alloc]initWithRequestURL:url];
    [self.navigationController pushViewController:loginViewController animated:YES];
}
@end
