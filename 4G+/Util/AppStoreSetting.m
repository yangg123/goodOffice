//
//  AppStoreSetting.m
//  appstore 发布之前的隐藏类
//
//  Created by yg on 16/1/6.
//  Copyright © 2016年 西米网络科技. All rights reserved.
//

#import "AppStoreSetting.h"

@implementation AppStoreSetting

+ (AppStoreSetting *)shareAppSetting
{
    static AppStoreSetting *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[[self alloc] init];
    });
    return _instance;
}

@end
