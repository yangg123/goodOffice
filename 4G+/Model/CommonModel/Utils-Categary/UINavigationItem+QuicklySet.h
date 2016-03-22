//
//  UINavigationItem+QuicklySet.h
//  SmartCampus
//
//  Created by yoyea on 14-7-17.
//  Copyright (c) 2014年 tm. All rights reserved.
//
//  功能描述: 提供快速设置导航栏返回按钮/右按钮方法
//
#import <UIKit/UIKit.h>

@interface UINavigationItem (QuicklySet)

//设置导航栏返回按钮
- (void)setBackButtonWithTarget:(id)target
                         action:(SEL)action;

//设置导航栏返回按钮_带返回"字样"
- (void)setBackButtonWithTarget:(id)target
                       andColor:(ItemTitleColor)color
                          title:(NSString *)title
                         action:(SEL)action;

//设置导航栏右按钮
- (void)setRightBarButtonItemWithTitle:(NSString *)title
                              andColor:(ItemTitleColor)color
                             addTarget:(id)target
                                action:(SEL)action;

//设置右侧按钮
- (void)setRightBarButtonItemWithNormalImage:(NSString *)normal
                                  hightlight:(NSString *)highlight
                                   addTarget:(id)target
                                      action:(SEL)action;
@end
