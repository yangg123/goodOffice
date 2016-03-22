//
//  DataCenter.h
//  GoodOffice
//  用户中心单例模型
//  Created by yangg on 14-12-23.
//  Copyright (c) 2014年 cgf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

#define LAST_LOGIN_ACCOUNT_KEY @"lastLoginAccountKey"
#define LAST_LOGIN_PWD_KEY @"lastLoginPwdKey"
#define DataCenterManager [DataCenter sharedInstance]

@interface DataCenter : NSObject

@property (nonatomic, copy)   NSString *lat;              //经度
@property (nonatomic, copy)   NSString *lng;              //纬度
@property (nonatomic, copy)   NSString *userToken;//用户登录
@property (nonatomic, copy)   NSString *cid;      //个推ID
@property (nonatomic, copy)   NSString *userId;
@property (nonatomic, assign) BOOL loginState;
@property (nonatomic, strong) UserModel *userInfo;

+ (instancetype)sharedInstance;


+ (NSString *)getLastLoginAccount;
+ (void)setLastLoginAccount:(NSString *)lastLoginAccount;


+ (NSString *)getLastLoginAccountPwd;
+ (void)setLastLoginAccountPwd:(NSString *)lastLoginAccountPwd;

@end
