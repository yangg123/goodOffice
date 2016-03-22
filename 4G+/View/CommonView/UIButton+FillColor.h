//
//  UIButton+FillColor.h
//  Yeke
//
//  Created by yg on 15/10/9.
//  Copyright (c) 2015年 西米网络科技. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  为按钮设置不同状态下的背景色
 */

@interface UIButton (FillColor)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end
