//
//  UIColor+ColorTranstion.m
//  SmartCampus
//
//  Created by cgf yangg on 14-6-26.
//  Copyright (c) 2014年 cgf. All rights reserved.

#import "UIColor+ColorTranstion.h"

@implementation UIColor (ColorTranstion)


/**
 *	@brief	将色值转换为UIColor
 *	@param 	inColorString 	色值字符串
 *	@return	UIColor
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    return [self colorFromHexRGB:inColorString andAlpha:1.0];
}

/**
 *	@brief	将色值转换为UIColor
 *	@param 	inColorString 	色值字符串
 *	@param 	alpha 	透明度
 *	@return	UIColor
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString andAlpha:(CGFloat)alpha
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:alpha];
    return result;
}
@end
