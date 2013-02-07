//
//  ParaseJSON.h
//  DouJiang
//
//  Created by mac  on 13-1-11.
//  Copyright (c) 2013年 mac . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson/SBJson.h"

@interface ParaseJSON : NSObject

-(NSDictionary *)getDictionaryWithURL:(NSURL*)url;
-(NSDictionary *)getDictionaryWithJSONString:(NSString *)jsonString;
-(NSDictionary *)getDictionaryWithData:(NSData *)data;


@end
