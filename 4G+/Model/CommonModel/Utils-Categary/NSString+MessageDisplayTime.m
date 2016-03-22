//
//  NSString+MessageDisplayTime.m
//  TimeStameProject_0811
//
//  Created by cgf yangg on 14-8-14.
//  Copyright (c) 2014年 cgf. All rights reserved.
//

#import "NSString+MessageDisplayTime.h"

@implementation NSString (MessageDisplayTime)

- (NSString *)displayTimeMilSecond  //毫秒
{
    return [self _getDisplayTimeWithTimeStr:self];
}

- (NSString *)displayTimeSecond  //秒
{
    return [self _getDisplayTimeWithTimeStrSecond:self];
}

- (NSString *)_getDisplayTimeWithTimeStrSecond:(NSString *)timeStr  //秒级别
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSString *timsSp = [self _getTimeStampWithTimeStrSecond:timeStr];
    

    NSString *nowTimeSp = [self _getTimeStampWithTimeStrSecond:[self _getTimeNowSecond]];
    NSInteger dateSpOffset = [nowTimeSp integerValue] - [timsSp integerValue];
    NSInteger dateCount = dateSpOffset / (24 * 60 * 60);
    NSInteger hourCount = dateSpOffset/ (60 * 60);
    NSInteger minuteCount = dateSpOffset/ 60;
    
    switch (dateCount) {
        case 0: {
            if (60 <= minuteCount) {
                return [NSString stringWithFormat:@"%li小时前", (long)hourCount];
            } else if (1 < minuteCount && minuteCount < 60) {
                return [NSString stringWithFormat:@"%li分钟前", minuteCount];
            }
            return @"刚刚";
        }
            break;
        case 1:
            return @"昨天";
            break;
        case 2:
            return @"前天";
            break;
        case 3:
            return @"大前天";
            break;
        default: {
            NSDate *date = [formatter dateFromString:timeStr];
            
            [formatter setDateFormat:@"yyyy-MM-dd"];
            
            NSString *displayTimeStr = [formatter stringFromDate:date];
            
            return displayTimeStr;
            

        }
            break;
    }
}


- (NSString *)_getDisplayTimeWithTimeStr:(NSString *)timeStr  //毫秒级别
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];

    NSString *timsSp = [self _getTimeStampWithTimeStr:timeStr];
    
    NSString *nowTimeSp = [self _getTimeStampWithTimeStr:[self _getTimeNow]];
    
    NSInteger dateSpOffset = [nowTimeSp integerValue] - [timsSp integerValue];
    
    NSInteger dateCount = dateSpOffset / (24 * 60 * 60);
    NSInteger hourCount = dateSpOffset/ (60 * 60);
    NSInteger minuteCount = dateSpOffset/ 60;
    
    switch (dateCount) {
        case 0: {
            if (60 <= minuteCount) {
                return [NSString stringWithFormat:@"%li小时前", (long)hourCount];
            } else if (1 < minuteCount && minuteCount < 60) {
                return [NSString stringWithFormat:@"%li分钟前", (long)minuteCount];
            }
            return @"刚刚";
        }
            break;
        case 1:
            return @"昨天";
            break;
        case 2:
            return @"前天";
            break;
        case 3:
            return @"大前天";
            break;
        default: {
            NSDate* date = [formatter dateFromString:timeStr];
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:date];
            NSInteger year= [components year];
            NSInteger month= [components month];
            NSInteger day = [components day];
            NSInteger hour = [components hour];
            NSInteger minute = [components minute];
            NSInteger second = [components second];
            
            NSString *displayTimeStr = [NSString stringWithFormat:@"%li-%li %li:%li", month, day, (long)hour, (long)minute];
            return displayTimeStr;
        }
            break;
    }
}

- (NSString *)_getTimeNowSecond
{
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    date = [formatter stringFromDate:[NSDate date]];
    date = [[NSString alloc] initWithFormat:@"%@", date];
    NSLog(@"%@", date);
    return date;
}


- (NSString *)_getTimeNow
{
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    date = [formatter stringFromDate:[NSDate date]];
    date = [[NSString alloc] initWithFormat:@"%@", date];
    NSLog(@"%@", date);
    return date;
}


//妙级
+ (NSInteger)getTimeStampWithTime:(NSString *)timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *date = [formatter dateFromString:timeStr];
    return [date timeIntervalSince1970];
}

//毫秒级
+ (NSInteger)getTimeStampWithTimeMilSecond:(NSString *)timeStr;
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *date = [formatter dateFromString:timeStr];
    return [date timeIntervalSince1970];
}



- (NSString *)_getTimeStampWithTimeStrSecond:(NSString *)timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:timeStr];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}

- (NSString *)_getTimeStampWithTimeStr:(NSString *)timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:timeStr];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}


/*精确到分钟的日期描述*/
- (NSString *)minuteDescription
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    if ([theDay isEqualToString:currentDay]) {//当天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [dateFormatter stringFromDate:self];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {//昨天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:self]];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] < 86400 * 7) {//间隔一周内
        [dateFormatter setDateFormat:@"EEEE ah:mm"];
        return [dateFormatter stringFromDate:self];
    } else {//以前
        [dateFormatter setDateFormat:@"yyyy-MM-dd ah:mm"];
        return [dateFormatter stringFromDate:self];
    }
}

@end
