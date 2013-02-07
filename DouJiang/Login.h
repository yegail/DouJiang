//
//  Login.h
//  DouJiang
//
//  Created by mac  on 13-1-6.
//  Copyright (c) 2013年 mac . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libDoubanApiEngine/DOUService.h>

@interface Login : NSObject
{
    int count1;
}
@property (nonatomic,retain) NSString *name;

-(void)login:(NSString *)userName:(NSString *)password;

@end
