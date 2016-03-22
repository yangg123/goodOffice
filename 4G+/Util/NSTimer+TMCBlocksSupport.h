//
//  NSTimer+TMCBlocksSupport.h
//  SmartCampus
//
//  Created by jinzhongliu on 14-7-31.
//  Copyright (c) 2014年 cgf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^timerAction)();

@interface NSTimer (TMCBlocksSupport)

+ (NSTimer*)tmc_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(timerAction)block repeats:(BOOL)repeats;

@end
