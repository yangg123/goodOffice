//
//  LoginViewController.h
//  Yeke
//  登录视图控制器
//  Created by cgf yangg on 14-7-4.
//  Copyright (c) 2014年 cgf. All rights reserved.

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController

@property (nonatomic,copy) void(^loginBlock)(NSString * state);

- (void)autoLogin;
@end
