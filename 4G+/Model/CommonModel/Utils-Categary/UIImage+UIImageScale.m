//
//  UIImage+UIImageScale.m
//  SmartCampus
//
//  Created by jinzhongliu on 14-8-11.
//  Copyright (c) 2014年 cgf. All rights reserved.
//

#import "UIImage+UIImageScale.h"

static inline double radians (double degrees) {return degrees * M_PI/180;}

@implementation UIImage (UIImageScale)

//截取部分图像
-(UIImage*)getSubImage:(CGRect)rect
{
    return [UIImage getSubImage:self withRect:rect];

//    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
//    UIImage *thumbScale = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:bTransform?UIImageOrientationRight:UIImageOrientationUp];
//    CGImageRelease(imageRef);
//    
//    
//    return thumbScale;
    //return [UIImage fixOrientation:thumbScale];
}

+(UIImage*)getSubImage:(UIImage*)image withRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    CGContextRef bitmap = CGBitmapContextCreate(NULL, rect.size.width, rect.size.height, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
    //
    if (image.imageOrientation == UIImageOrientationLeft) {
        CGContextRotateCTM (bitmap, radians(90));
        CGContextTranslateCTM (bitmap, 0, -rect.size.height);
        
    } else if (image.imageOrientation == UIImageOrientationRight) {
        CGContextRotateCTM (bitmap, radians(-90));
        CGContextTranslateCTM (bitmap, -rect.size.width, 0);
        
    } else if (image.imageOrientation == UIImageOrientationUp) {
        // NOTHING
    } else if (image.imageOrientation == UIImageOrientationDown) {
        CGContextTranslateCTM (bitmap, rect.size.width, rect.size.height);
        CGContextRotateCTM (bitmap, radians(-180.));
    }
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, rect.size.width, rect.size.height), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    
    UIImage *resultImage=[UIImage imageWithCGImage:ref];
    CGImageRelease(imageRef);
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return resultImage;

}


//=====>算法有问题
//等比例缩放
- (UIImage*)scaleAspectFit:(CGSize)size {
    
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    
    float verticalRadio = size.height * scale / height;
    float horizontalRadio = size.width * scale / width;
    
    float radio = 1;
    if(verticalRadio > 1 && horizontalRadio > 1) {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else {
        radio = verticalRadio > horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width * radio;
    height = height * radio;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width * scale, height * scale));
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, width * scale, height * scale)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

//等比例缩放
- (UIImage*)scaleToSize:(CGSize)size
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);

    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;

    float radio = 1;
    if(verticalRadio >1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio > horizontalRadio ? verticalRadio : horizontalRadio;
    }

    width = width*radio;
    height = height*radio;

    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;

    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);

    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];

    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();

    // 使当前的context出堆栈
    UIGraphicsEndImageContext();

    // 返回新的改变大小后的图片
    return scaledImage;
}

//指定宽度按比例缩放
- (UIImage *)imageCompressForScreenWidth{
    
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
//    NSLog(@"[UIScreen mainScreen].scale is %f",[UIScreen mainScreen].scale);
    CGFloat targetWidth = 0;
    if ([UIScreen mainScreen].scale == 2.0) {  // 640 * 960
        targetWidth = 640;
    } else if ([UIScreen mainScreen].scale == 1.0) { //320 * 480
        targetWidth = 320;
    } else {
        targetWidth = 750;
    }
    
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

@end
