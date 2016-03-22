//
//  UserInfo.m
//  SmartCampus
//
//  Created by yangg on 14-12-23.
//  Copyright (c) 2014年 cgf. All rights reserved.
//
#import "UserModel.h"
#import "NSString+MD5.h"

@implementation UserModel

- (id)init
{
    if (self = [super init]) {
        
        _mobile = @"";
        _pwd = @"";
        
        _userId = @"";
        _nickName = @"";
    
        _gender = @"";
        _birthDay = 0;
        _province = @"";
        _city = @"";
        _education = @"";
        _curCityId = 0;
        _curProvinceId = 0;
        
        _updateTime = 0;
        _constellation = @"";
        _lat = @"";
        _lng = @"";
        _avatar = @"";
        _isNeedUpdateAvatar = NO;
        
        _createTime = @"";
        
        _accountMoney = @"";
        _shopType = @"";
        _shopName = @"";
        _storeId = 0;
        _isStore = @"";
        _isManager = NO;
        
    }
    return self;
}

@end

@implementation NSDictionary (UserInfo)

/**
 *	@brief	获取用户信息
 */
- (UserModel *)userInformate {
    
    UserModel *userModel = [[UserModel alloc] init];
    
    userModel.userId = [self[@"userId"] stringValue];
    return userModel;
}
@end