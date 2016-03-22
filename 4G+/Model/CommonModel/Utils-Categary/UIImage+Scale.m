//
//  UIImage+Scale.m
//  SmartCampus
//
//  Created by yoyea on 14-7-22.
//  Copyright (c) 2014年 cgf. All rights reserved.
//
//  开发版本: 1.0
//  开发者: yoyea
//  编写时间: 14.07.22
//  功能描述: 重新调整UIImage大小
//  修改记录:
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)
/**
 *	@brief  等比例缩放
 *  @param  image 原图片
 *	@param 	scaleSize 比例
 */
- (UIImage *)scaleImage:(float)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scaleSize, self.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    return scaledImage;
}

/**
 *	@brief  调整图片大小
 *  @param  image 原图片
 *	@param 	reSize 新的大小
 */
- (UIImage *)reSizeImage:(CGSize)reSize {
    UIGraphicsBeginImageContext(reSize);
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

/**
 *	@brief  为图片加上空白边框
 *  @param  fullSize 边框大小
 *	@param 	opaqueSize 图片大小
 */
- (UIImage *)transparentImageWithfullSize:(CGSize)fullSize
                               opaqueSize:(CGSize)opaqueSize {
    if (nil == self) return nil;
    
    CGSize size = CGSizeMake(MAX(fullSize.width, opaqueSize.width), MAX(fullSize.height, opaqueSize.height));
    CGRect rect = CGRectMake(0, 0, opaqueSize.width, opaqueSize.height);
    rect.origin.x = (size.width-opaqueSize.width)/2;
    rect.origin.y = (size.height-opaqueSize.height)/2;
    
    if ([UIScreen mainScreen].scale == 2.0) {
        size = CGSizeMake(2*size.width, 2*size.height);
        rect = CGRectMake(2*rect.origin.x, 2*rect.origin.y, 2*rect.size.width, 2*rect.size.height);
    }
    UIGraphicsBeginImageContext(size);
    [self drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if ([UIScreen mainScreen].scale == 2.0) {
        UIImage *retinaImage = [UIImage imageWithCGImage:newImage.CGImage scale:2.0 orientation:UIImageOrientationUp];
        newImage = retinaImage;
    }
    
    return newImage;
}
@end
