//
//  SearchBookViewController.m
//  DouJiang
//
//  Created by mac  on 13-1-7.
//  Copyright (c) 2013年 mac . All rights reserved.
//

#import "SearchBookViewController.h"
#import <libDoubanApiEngine/DOUAPIEngine.h>
#import "ParaseJSON.h"
#import "BookDetailViewController.h"

@interface SearchBookViewController (){
    NSDictionary *dicBooks;
    NSArray *arrayBooks;
    NSDictionary *dicBook;
    int currentSelectRow;
    NSString *oldSearchText;
    BOOL requestField;
}
@end

@implementation SearchBookViewController
@synthesize textFieldSearch;

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
    oldSearchText = [[NSString alloc]init];
    requestField = false;
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchBook:(id)sender {
    
    if (textFieldSearch.text.length !=0 && (dicBooks.count == 0 || ![oldSearchText isEqualToString:textFieldSearch.text] || requestField)) {
        //让编辑框消失
        [textFieldSearch resignFirstResponder];
        //获得豆瓣Service
        DOUService *service = [DOUService sharedInstance];
        service.apiBaseUrlString = kHttpsApiBaseUrl;
    
        NSString *subString = [NSString stringWithFormat:@"/v2/book/search?q=%@",textFieldSearch.text];
        DOUQuery *query = [[DOUQuery alloc]initWithSubPath:subString parameters:nil];
   
        DOUReqBlock completionBlock = ^(DOUHttpRequest *req)
        {
            NSError *theError = [req doubanError];
            if (!theError) {
                //获取数据成功
                NSLog(@"successed!");
            
                //将请求网络返回的字符串转换为data类型的数
                NSData *data = [[req responseString]dataUsingEncoding:NSUTF8StringEncoding];
                //将data解析为字典
                dicBooks = [[ParaseJSON alloc]getDictionaryWithData:data];
                arrayBooks = [dicBooks objectForKey:@"books"];
                //打印log查看字典中的内容
                NSLog(@"%@",arrayBooks);
                [self.tableView reloadData];
            }else{
                //获取数据失败
                NSLog(@"theError:%@",theError);
                requestField = true;
            }
        };
    
        [service get:query callback:completionBlock];
        
        oldSearchText = textFieldSearch.text;
    }
}
- (IBAction)closeKeyboard:(id)sender {
    [textFieldSearch resignFirstResponder];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayBooks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    NSDictionary *dic = [arrayBooks objectAtIndex:[indexPath row]];
    UILabel *bookName = (UILabel *)[cell viewWithTag:101];
    UILabel *bookAuthor = (UILabel *)[cell viewWithTag:102];
    bookName.text = [dic objectForKey:@"title"];
    NSArray *authors = [dic objectForKey:@"author"];
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
    bookAuthor.text = author;
    NSLog(@"rating:%@",[[dic objectForKey:@"rating"]objectForKey:@"average"]);
    
    return cell;
}

#pragma mark - Table view delegate
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    dicBook = [arrayBooks objectAtIndex:[indexPath row]];
    currentSelectRow = indexPath.row;
    return  indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showBookDetail"])
    {
        BookDetailViewController *bookDetailViewController = segue.destinationViewController;
        bookDetailViewController.title = [dicBook objectForKey:@"title"];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:dicBook forKey:@"dicBook"];
    }
}

@end
