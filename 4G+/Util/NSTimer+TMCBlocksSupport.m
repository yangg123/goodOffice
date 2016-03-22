//
//  NSTimer+TMCBlocksSupport.m
//  SmartCampus
//
//  Created by jinzhongliu on 14-7-31.
//  Copyright (c) 2014年 cgf. All rights reserved.
//

#import "NSTimer+TMCBlocksSupport.h"

@implementation NSTimer (TMCBlocksSupport)

+ (NSTimer*)tmc_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(timerAction)block repeats:(BOOL)repeats{
    
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(tmc_blockInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)tmc_blockInvoke:(NSTimer*)timer{
    timerAction block = timer.userInfo;
    if (block != nil){
        block();
    }
}

@end
