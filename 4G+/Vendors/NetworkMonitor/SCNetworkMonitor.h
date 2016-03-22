//
//  SCNetworkMonitor.h
//  网络状态监听
//
//  Created by jinzhongliu on 14-8-6.
//  Copyright (c) 2014年 cgf. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络监听
 */

@interface SCNetWorkStatus : NSObject

@property(nonatomic, assign)NSInteger nStatus;
@property(nonatomic, assign)BOOL bConnectionRequired;


@end

@interface SCNetworkMonitor : NSObject

+ (instancetype)sharedInstance;

- (void)addReachabilityObserver:(id)observer selector:(SEL)aSelector;
- (void)removeReachabilityObserver:(id)observer;

@property(nonatomic, strong, readonly)SCNetWorkStatus* netStatus;//当前网络状态
@property(nonatomic, copy)NSString* serverAddress;//监听服务器地址 默认为百度

@end
