//
//  ParaseJSON.m
//  DouJiang
//
//  Created by mac  on 13-1-11.
//  Copyright (c) 2013年 mac . All rights reserved.
//

#import "ParaseJSON.h"

@implementation ParaseJSON
-(NSDictionary *)getDictionaryWithURL:(NSURL*)url{
    NSError *error = nil;
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    NSDictionary *dic = [parser objectWithString:jsonString error:&error];
    
    return dic;
}
-(NSDictionary *)getDictionaryWithJSONString:(NSString *)jsonString{
    
    NSError *error = nil;
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    NSDictionary *dic = [parser objectWithString:jsonString error:&error];
    
    return dic;
}
-(NSDictionary *)getDictionaryWithData:(NSData *)data{
    
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    return dic;
}

@end
