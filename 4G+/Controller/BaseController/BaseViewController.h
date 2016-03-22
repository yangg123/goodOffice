//
//  BaseViewController.h
//  Yeke
//
//  Created by cgf yangg on 14-6-26.
//  Copyright (c) 2014年 cgf. All rights reserved.

//  功能描述: 工程的controller基类
//  修改记录:(仅记录功能修改)


#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"
#import "Publish.h"

@interface BaseViewController : UIViewController


//自定义动画的界面跳转
- (void)popViewControllerCustomAnimated;

- (void)pushViewControllerCustomAnimated:(UIViewController *)viewController;

//默认导航栏
- (void)showNavigationBar;

//全透明的导航栏
- (void)showNavTransparent;


@end
