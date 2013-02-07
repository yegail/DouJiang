//
//  SearchBookViewController.h
//  DouJiang
//
//  Created by mac  on 13-1-7.
//  Copyright (c) 2013年 mac . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchBookViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *textFieldSearch;

- (IBAction)searchBook:(id)sender;

@end
