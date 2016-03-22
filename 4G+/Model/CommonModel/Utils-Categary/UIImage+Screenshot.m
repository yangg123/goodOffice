//
//  UIImage+Screenshot.m
//  SmartCampus
//
//  Created by LianJR on 14-7-16.
//  Copyright (c) 2014年 cgf. All rights reserved.
//

#import "UIImage+Screenshot.h"

@implementation UIImage (Screenshot)



/**
 *	@brief  按参数截图
 *
 *	@param 	frame 	需要截取的大小及位置
 *
 *	@return	截取后的图片
 */
- (UIImage *)getCaptureImage:(CGRect)frame
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, frame);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    CGImageRelease(subImageRef);
    
    return smallImage;
}


@end
