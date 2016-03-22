//
//  BaseService.h
//  GoodOffice
//  功能描述: 网络请求接口基类
//  Created by cgf yangg on 16-2-25.
//  Copyright (c) 2016年  西米网络科技. All rights reserved.


#import <Foundation/Foundation.h>
#import "AFAppDotNetAPIClient.h"



/**
 *	@brief	请求成功的回调
 *
 *	@param 	^SuccessBlock 	成功回调代码块
 */
typedef void (^SuccessBlock)(id data);

/**
 *	@brief	请求失败的回调
 *
 *	@param 	^FailedBlock 	失败回调代码块
 */
typedef void (^FailedBlock)(NSString *error);

@interface BaseService : NSObject

/**
 *	@brief	根据传入的baseUrlStr和参数字典请求网络[get]
 *
 *	@param 	baseUrlStr 	baseUrlStr
 *  @param  path    路径
 *	@param 	paramsDic 	参数字典
 *	@param 	successBlock 	成功block
 *	@param 	failedBlock 	失败block
 */
+ (void)requestWithBaseUrlStrByGet:(NSString *)baseUrlStr
                           andPath:(NSString *)path
                      andParamsDic:(NSDictionary *)paramsDic
                   andSuccessBlock:(SuccessBlock)successBlock
                    andFailedBlock:(FailedBlock)failedBlock;

/**
 *	@brief	根据传入的baseUrlStr和参数字典请求网络[post]
 *
 *	@param 	baseUrlStr 	baseUrlStr
 *  @param  path    路径
 *	@param 	paramsDic 	参数字典
 *	@param 	successBlock 	成功block
 *	@param 	failedBlock 	失败block
 */
+ (void)requestWithBaseUrlStrByPost:(NSString *)baseUrlStr
                            andPath:(NSString *)path
                       andParamsDic:(NSDictionary *)paramsDic
                    andSuccessBlock:(SuccessBlock)successBlock
                     andFailedBlock:(FailedBlock)failedBlock;

@end
