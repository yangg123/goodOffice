//
//  UIView+Circle.m
//  Yeke
//
//  Created by yoyea on 14-7-16.
//  Copyright (c) 2014年 tm. All rights reserved.
//

#import "UIView+Circle.h"
#import "UIView+Layout.h"

@implementation UIView (Circle)
/**
 *	@brief 转换为圆形
 */
- (void)transformToCircle {
    CGFloat cornerRadius = 0;
    if (self.frameHeight > self.frameWidth) {
        cornerRadius = self.frameWidth / 2;
    }
    else {
        cornerRadius = self.frameHeight / 2;
    }
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}
@end
