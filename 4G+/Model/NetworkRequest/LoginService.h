//
//  LoginService.h
//  Yeke
//  功能描述: 用户模块网络接口请求
//  Created by cgf yangg on 16-2-25.
//  Copyright (c) 2016年  西米网络科技. All rights reserved.



#import "BaseService.h"

@interface LoginService : BaseService

/**
 *	@brief	登录接口
 *
 *	@param 	accountStr 	      登录账号
 *	@param 	userPasswordStr 	登录密码
 *	@param 	successBlock 	成功回调
 *	@param 	failedBlock 	失败回调
 */
+ (void)loginWithUserAccountStr:(NSString *)userAccountStr
             andUserPasswordStr:(NSString *)userPasswordStr
                andSuccessBlock:(SuccessBlock)successBlock
                 andFailedBlock:(FailedBlock)failedBlock;

/**
 *	@brief	获取短信验证码接口
 *	@param 	mobile 	                  手机号码
 *	@param 	successBlock              成功回调
 *	@param 	failedBlock 	          失败回调
 */
+ (void)getSmsWithMobile:(NSString *)mobileNum
         andSuccessBlock:(SuccessBlock)successBlock
          andFailedBlock:(FailedBlock)failedBlock;

/**
 *	@brief	验证短信验证码接口
 *	@param 	mobile 	                  手机号码
 *	@param 	checkCode 	              验证码
 *	@param 	successBlock 	  成功回调
 *	@param 	failedBlock 	      失败回调
 */
+ (void)checkSmsCodeWithMobile:(NSString *)mobileNum
                     checkCode:(NSString *)checkCode
               andSuccessBlock:(SuccessBlock)successBlock
                andFailedBlock:(FailedBlock)failedBlock;


/**
 *	@brief	找回密码
 *  @param  newPassword  新密码
 *
 *	@param 	successRequestBlock    成功回调
 *	@param 	failedRequestBlock 	   失败回调
 */
+ (void)modifyWithPhone:(NSString *)phone
               password:(NSString *)newPassword
        andSuccessBlock:(SuccessBlock)successBlock
         andFailedBlock:(FailedBlock)failedBlock;


/**
 *	@brief  注册接口
 *  @param  params  参数
 *	@param 	successBlock 	成功回调
 *	@param 	failedBlock 	失败回调
 */
+ (void)registerWithParam:(NSDictionary *)params
          andSuccessBlock:(SuccessBlock)successBlock
           andFailedBlock:(FailedBlock)failedBlock;


/**
 *	@brief  我的接口
 *	@param 	successBlock 	成功回调
 *	@param 	failedBlock 	失败回调
 */
+ (void)getMyUserInfoSuccessBlock:(SuccessBlock)successBlock
                   andFailedBlock:(FailedBlock)failedBlock;

@end
