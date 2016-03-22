//
//  DataCenter.m
//  GoodOffice
//  用户中心单例模型
//  Created by yangg on 14-12-23.
//  Copyright (c) 2014年 cgf. All rights reserved.
//

#import "DataCenter.h"

@implementation DataCenter

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static DataCenter *sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        
        sSharedInstance = [DataCenter new];
        sSharedInstance.userInfo = [[UserModel alloc] init];
    });
    return sSharedInstance;
}


+ (NSString *)getLastLoginAccount
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *lastLoginAccount = [userDefault objectForKey:LAST_LOGIN_ACCOUNT_KEY];
    if (NSStringIsValid(lastLoginAccount)) {
        return lastLoginAccount;
    }
    return nil;
}

+ (void)setLastLoginAccount:(NSString *)lastLoginAccount
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:lastLoginAccount forKey:LAST_LOGIN_ACCOUNT_KEY];
    [userDefault synchronize];
}


+ (NSString *)getLastLoginAccountPwd
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *lastLoginAccountPwd = [userDefault objectForKey:LAST_LOGIN_PWD_KEY];
    if (NSStringIsValid(lastLoginAccountPwd)) {
        return lastLoginAccountPwd;
    }
    return nil;
}

+ (void)setLastLoginAccountPwd:(NSString *)lastLoginAccountPwd
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:lastLoginAccountPwd forKey:LAST_LOGIN_PWD_KEY];
    [userDefault synchronize];
}


@end
