//
//  ViewController.h
//  DouJiang
//
//  Created by mac  on 13-1-6.
//  Copyright (c) 2013年 mac . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;


- (IBAction)login:(id)sender;

@end
