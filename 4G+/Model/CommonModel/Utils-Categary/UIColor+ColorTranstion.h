//
//  UIColor+ColorTranstion.h
//  SmartCampus
//
//  Created by cgf yangg on 14-6-26.
//  Copyright (c) 2014年 cgf. All rights reserved.
//  功能描述: 将色值转换为UIColor


#import <UIKit/UIKit.h>

@interface UIColor (ColorTranstion)


/**
 *	@brief	将色值转换为UIColor
 *	@param 	inColorString 	色值字符串
 *	@return	UIColor
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;

/**
 *	@brief	将色值转换为UIColor
 *	@param 	inColorString 	色值字符串
 *	@param 	alpha 	透明度
 *	@return	UIColor
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString andAlpha:(CGFloat)alpha;


@end
