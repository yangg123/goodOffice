//
//  AppStoreSetting.h
//  appstore 发布之前的隐藏类
//
//  Created by yg on 16/1/6.
//  Copyright © 2016年 西米网络科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppStoreSetting : NSObject

+ (AppStoreSetting *)shareAppSetting;

@property (nonatomic,strong) NSString *versionNum;                //版本号
@property (nonatomic,strong) NSString *versionInfo;               //新版本信息
@property (nonatomic,assign) BOOL isInCheck;                     //审核中版本

@end
