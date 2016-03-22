//
//  UIImage+UIImageScale.h
//  SmartCampus
//
//  Created by jinzhongliu on 14-8-11.
//  Copyright (c) 2014年 cgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageScale)
-(UIImage*)getSubImage:(CGRect)rect;
+(UIImage*)getSubImage:(UIImage*)image withRect:(CGRect)rect;
- (UIImage*)scaleAspectFit:(CGSize)size;
-(UIImage*)scaleToSize:(CGSize)size;
-(UIImage *)imageCompressForScreenWidth;


@end
