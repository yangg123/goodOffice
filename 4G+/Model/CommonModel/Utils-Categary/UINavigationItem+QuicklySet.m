//
//  UINavigationItem+QuicklySet.m
//  Yeke
//
//  Created by yangg on 14-7-17.
//  Copyright (c) 2014年 tm. All rights reserved.
//

//  功能描述: 提供快速设置导航栏返回按钮/右按钮方法

#import "UINavigationItem+QuicklySet.h"

@implementation UINavigationItem (QuicklySet)


/**
 *	@brief  设置导航栏返回按钮
 *
 *	@param 	target 响应对象
 *  @param 	action 响应函数
 */

- (void)setBackButtonWithTarget:(id)target
                         action:(SEL)action {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0, 24, 24)];
    [backBtn setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"navigationbar_backHigh"] forState:UIControlStateHighlighted];
    [backBtn addTarget:target
                action:action
      forControlEvents:UIControlEventTouchUpInside];
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}



/**
 *	@brief  设置导航栏返回按钮
 *  @param  title  返回字样
 *	@param 	target 响应对象
 *  @param 	action 响应函数
 */

- (void)setBackButtonWithTarget:(id)target
                       andColor:(ItemTitleColor)color
                          title:(NSString *)title
                         action:(SEL)action
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:title forState:UIControlStateNormal];
    backBtn.titleLabel.font = FONT(17);
    backBtn.backgroundColor = [UIColor clearColor];
    
    [backBtn setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"navigationbar_backHigh"] forState:UIControlStateHighlighted];
    
    if (color == GreenColor) {
        [backBtn setTitleColor:[UIColor colorFromHexRGB:@"00bf8f"] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor colorFromHexRGB:@"00bf8f" andAlpha:0.6] forState:UIControlStateHighlighted];
    } else if (color == WhiteColor) {
        [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor colorFromHexRGB:@"ffffff" andAlpha:0.6] forState:UIControlStateHighlighted];
    } else {
        [backBtn setTitleColor:[UIColor colorFromHexRGB:@"727a83"] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor colorFromHexRGB:@"727a83" andAlpha:0.6] forState:UIControlStateHighlighted];
        
        [backBtn setImage:[UIImage imageNamed:@"navigationbar_back_gray_1"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationbar_back_gray_2"] forState:UIControlStateHighlighted];
    }
    
    if (title.length == 2) {
        [backBtn setFrame:CGRectMake(0, 0, 55, 44)];
    } else if (title.length == 3) {
        [backBtn setFrame:CGRectMake(0, 0, 72, 44)];
    } else if (title.length == 4) {
        [backBtn setFrame:CGRectMake(0, 0, 90, 44)];
    } else {
        [backBtn setFrame:CGRectMake(0, 0, 100, 44)];
    }
    
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -3, 0, 0)];
    [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [backBtn addTarget:target
                action:action
      forControlEvents:UIControlEventTouchUpInside];
    
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}


/**
 *	@brief  设置导右边按钮
 *
 *	@param 	title 按钮文字
 *	@param 	target 响应对象
 *  @param 	action 响应函数
 */
- (void)setRightBarButtonItemWithTitle:(NSString *)title
                              andColor:(ItemTitleColor)color
                             addTarget:(id)target
                                action:(SEL)action {
    
    self.rightBarButtonItem = [Publish setRightBarItemWithTitle:title andColor:color addTarget:target action:action];
}


/**
 *	@brief  设置导右边按钮
 *
 *	@param 	normal   常态图片
 *	@param  highlight 高亮图片
 *	@param 	target 响应对象
 *  @param 	action 响应函数
 */

- (void)setRightBarButtonItemWithNormalImage:(NSString *)normal
                                  hightlight:(NSString *)highlight
                                   addTarget:(id)target
                                      action:(SEL)action {
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0, 44, 44)];
    [backBtn setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:highlight] forState:UIControlStateHighlighted];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -30)];
    [backBtn addTarget:target
                action:action
      forControlEvents:UIControlEventTouchUpInside];
    
    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

@end
