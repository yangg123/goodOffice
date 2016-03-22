//
//  UIImage+Screenshot.h
//  SmartCampus
//
//  Created by LianJR on 14-7-16.
//  Copyright (c) 2014年 ljr. All rights reserved.
//
//
//  开发版本: 1.0
//  开发者: LJR
//  编写时间: 14.07.16
//  功能描述: UIImage截图
//  修改记录:
//

#import <UIKit/UIKit.h>


@interface UIImage (Screenshot)


//截取原图frame大小的图片并返回
- (UIImage *)getCaptureImage:(CGRect)frame;


@end
