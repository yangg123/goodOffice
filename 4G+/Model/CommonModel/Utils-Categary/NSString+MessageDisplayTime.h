//
//  NSString+MessageDisplayTime.h
//  TimeStameProject_0811
//
//  Created by cgf yangg on 14-8-14.
//  Copyright (c) 2014年 cgf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MessageDisplayTime)

- (NSString *)displayTimeMilSecond; /*精确到毫秒的时间戳描述:yyyy-MM-dd HH:mm:ss:SSS ==>类似:几分钟前,几天前*/
- (NSString *)displayTimeSecond;    /*精确到秒的时间戳描述*/

+ (NSInteger)getTimeStampWithTime:(NSString *)timeStr;  //秒级
+ (NSInteger)getTimeStampWithTimeMilSecond:(NSString *)timeStr;  //毫秒级

@end
