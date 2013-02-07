//
//  BookDetailViewController.m
//  DouJiang
//
//  Created by mac  on 13-1-11.
//  Copyright (c) 2013年 mac . All rights reserved.
//

#import "BookDetailViewController.h"

@interface BookDetailViewController ()

@end

@implementation BookDetailViewController
@synthesize dicBook;
@synthesize imageViewBook,labelAllPages,labelAuthorIntro,labelAuthorName,labelBookName,labelISBN,labelPice,labelPublisher,labelPublisherYear,labelSummary,labelTranslator;

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
	
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    dicBook = [userDefaults objectForKey:@"dicBook"];
    
    //将字典中的内容设置到View上显示
    labelBookName.text = [[NSString alloc]initWithFormat:@"书名：%@",[dicBook objectForKey:@"title"]];
    //author和translator都是数组类型的
    NSArray *authors = [dicBook objectForKey:@"author"];
    NSMutableString *author;
    if (authors.count==0) {
        author = [[NSMutableString alloc]init];
    }else
    {
        author= [[NSMutableString alloc]initWithString:[authors objectAtIndex:0]];
        for (int i=1;i<[authors count];i++) {
            [author appendFormat:@"/%@",[authors objectAtIndex:i]];
        }
    }
    
    NSArray *translators = [dicBook objectForKey:@"translator"];
    NSMutableString *translator;
    if (translators.count ==0) {
        translator= [[NSMutableString alloc]init];
    }else{
        translator= [[NSMutableString alloc]initWithString:[translators objectAtIndex:0]];
        for ( int i=1;i<[translators count];i++) {
            [translator appendFormat:@"/%@",[translators objectAtIndex:i]];
        }
    }
    labelAuthorName.text = [[NSString alloc]initWithFormat:@"作者：%@",author];
    labelTranslator.text = [[NSString alloc]initWithFormat:@"译者：%@",translator];
    labelPublisher.text = [[NSString alloc]initWithFormat:@"出版社：%@",[dicBook objectForKey:@"publisher"]];
    labelPublisherYear.text = [[NSString alloc]initWithFormat:@"出版年份：%@",[dicBook objectForKey:@"pubdate"]];
    labelAllPages.text = [[NSString alloc]initWithFormat:@"页数：%@",[dicBook objectForKey:@"pages"]];
    labelPice.text = [[NSString alloc]initWithFormat:@"定价：%@",[dicBook objectForKey:@"price"]];
    labelISBN.text = [[NSString alloc]initWithFormat:@"ISBN：%@",[dicBook objectForKey:@"isbn13"]];
    labelAuthorIntro.text = [dicBook objectForKey:@"author_intro"];
    labelSummary.text = [dicBook objectForKey:@"summary"];
    //获得书的封面图片的地址并将其转换成NSURL
    NSURL *url = [[NSURL alloc]initWithString:[dicBook objectForKey:@"image"]];
    NSData *imageData = [[NSData alloc]initWithContentsOfURL:url];
    imageViewBook.image = [UIImage imageWithData:imageData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showBookDetail:(NSDictionary *)dic{
    //将字典中的内容设置到View上显示
    labelBookName.text = [[NSString alloc]initWithFormat:@"书名：%@",[dic objectForKey:@"title"]];
    //author和translator都是数组类型的
    NSArray *authors = [dic objectForKey:@"author"];
    NSMutableString *author = [[NSMutableString alloc]initWithString:[authors objectAtIndex:0]];
    for (int i=1;i<[authors count];i++) {
        [author appendFormat:@"/%@",[authors objectAtIndex:i]];
    }
    NSArray *translators = [dic objectForKey:@"translator"];
    NSMutableString *translator = [[NSMutableString alloc]initWithString:[translators objectAtIndex:0]];
    for ( int i=1;i<[translators count];i++) {
        [translator appendFormat:@"/%@",[translators objectAtIndex:i]];
    }
    labelAuthorName.text = [[NSString alloc]initWithFormat:@"作者：%@",author];
    labelTranslator.text = [[NSString alloc]initWithFormat:@"译者：%@",translator];
    labelPublisher.text = [[NSString alloc]initWithFormat:@"出版社：%@",[dic objectForKey:@"publisher"]];
    labelPublisherYear.text = [[NSString alloc]initWithFormat:@"出版年份：%@",[dic objectForKey:@"pubdate"]];
    labelAllPages.text = [[NSString alloc]initWithFormat:@"页数：%@",[dic objectForKey:@"pages"]];
    labelPice.text = [[NSString alloc]initWithFormat:@"定价：%@",[dic objectForKey:@"price"]];
    labelISBN.text = [[NSString alloc]initWithFormat:@"ISBN：%@",[dic objectForKey:@"isbn13"]];
    labelAuthorIntro.text = [dic objectForKey:@"author_intro"];
    labelSummary.text = [dic objectForKey:@"summary"];
    //获得书的封面图片的地址并将其转换成NSURL
    NSURL *url = [[NSURL alloc]initWithString:[dic objectForKey:@"image"]];
    NSData *imageData = [[NSData alloc]initWithContentsOfURL:url];
    imageViewBook.image = [UIImage imageWithData:imageData];
}

@end


