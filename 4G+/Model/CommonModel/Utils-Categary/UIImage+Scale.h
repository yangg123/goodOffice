//
//  UIImage+Scale.h
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

#import <UIKit/UIKit.h>

@interface UIImage (Scale)
/**
 *	@brief  等比例缩放
 *	@param 	scaleSize 比例
 */
- (UIImage *)scaleImage:(float)scaleSize;

/**
 *	@brief  调整图片大小
 *	@param 	reSize 新的大小
 */
- (UIImage *)reSizeImage:(CGSize)reSize;

/**
 *	@brief  为图片加上空白边框
 *  @param  fullSize 边框大小
 *	@param 	opaqueSize 图片大小
 */
- (UIImage *)transparentImageWithfullSize:(CGSize)fullSize
                               opaqueSize:(CGSize)opaqueSize;
@end
