//
//  NSString+Message.m
//  去掉空格
//
//  Created by zhoubin@moshi on 14-5-10.
//  Copyright (c) 2014年 Crius_ZB. All rights reserved.
//

#import "NSString+Space.h"

@implementation NSString (Space)

//去掉两端的空格
- (NSString *)removeSideSpace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//去掉所有空格
- (NSString *)removeAllSpace
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end
