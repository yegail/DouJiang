//
//  BookDetailViewController.h
//  DouJiang
//
//  Created by mac  on 13-1-11.
//  Copyright (c) 2013年 mac . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookDetailViewController : UIViewController

@property (weak,nonatomic) NSDictionary *dicBook;
@property (weak,nonatomic) NSArray *arrayBooks;
@property  int selectIndex;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewBook;
@property (weak, nonatomic) IBOutlet UILabel *labelBookName;
@property (weak, nonatomic) IBOutlet UILabel *labelAuthorName;
@property (weak, nonatomic) IBOutlet UILabel *labelTranslator;
@property (weak, nonatomic) IBOutlet UILabel *labelPublisher;
@property (weak, nonatomic) IBOutlet UILabel *labelPublisherYear;
@property (weak, nonatomic) IBOutlet UILabel *labelAllPages;
@property (weak, nonatomic) IBOutlet UILabel *labelPice;
@property (weak, nonatomic) IBOutlet UILabel *labelISBN;

@property (weak, nonatomic) IBOutlet UITextView *labelAuthorIntro;
@property (weak, nonatomic) IBOutlet UITextView *labelSummary;


-(void)showBookDetail:(NSDictionary *)dic;



@end
