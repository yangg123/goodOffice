//
//  LoginService.m
//  Yeke
//  功能描述: 用户模块网络接口请求
//  Created by cgf yangg on 14-7-4.
//  Copyright (c) 2014年 cgf. All rights reserved.
//

#import "LoginService.h"
#import "UserModel.h"
#import "DataCenter.h"

#define USER_ACCOUNT_STR @"login_name"
#define USER_PASSWORD_STR @"password"


@implementation LoginService

/**
 *	@brief	登录接口
 *
 *	@param 	accountStr          登录账号
 *	@param 	userPasswordStr 	登录密码
 *	@param  cid                 个推ID （测试阶段不用填）
 *	@param 	successBlock        成功回调
 *	@param 	failedBlock         失败回调
 */
+ (void)loginWithUserAccountStr:(NSString *)userAccountStr
             andUserPasswordStr:(NSString *)userPasswordStr
                andSuccessBlock:(SuccessBlock)successBlock
                 andFailedBlock:(FailedBlock)failedBlock
{
    if (DataCenterManager.cid == nil) {
        if (Device_CID != nil) {
            DataCenterManager.cid  = Device_CID;
        }
    }
    NSDictionary *paramsDic = @{@"tel": userAccountStr,
                                @"password": userPasswordStr,
                                @"cid":DataCenterManager.cid};
    
    [super requestWithBaseUrlStrByPost:DEFAULT_URL
                               andPath:@"user/login"
                          andParamsDic:paramsDic
                       andSuccessBlock:^(id data){
                           
                           NSInteger flag = [[data objectForKey:@"code"] integerValue];
                           
                           if (flag == 200) {
                               
                               NSDictionary *resDic = data[@"data"];
                               NSLog(@"登录返回的信息是:%@",resDic);
                               [DataCenter sharedInstance].userId = userAccountStr;
                               [DataCenter sharedInstance].userToken = [resDic objectForKey:@"userToken"];
                               successBlock(resDic);
                               
                           } else {
                               
                               failedBlock([data objectForKey:@"message"]);
                           }
                       } andFailedBlock:^(NSString *error) {
                           
                           failedBlock(error);
                       }];
}

/**
 *	@brief	获取短信验证码接口
 *
 *	@param 	mobile 	手机号码            必填
 *	@param 	successBlock 	   成功回调
 *	@param 	failedBlock 	       失败回调
 */
+ (void)getSmsWithMobile:(NSString *)mobileNum
         andSuccessBlock:(SuccessBlock)successBlock
          andFailedBlock:(FailedBlock)failedBlock
{
    NSMutableDictionary *paramsDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [paramsDic setObject:mobileNum forKey:@"tel"];
    
    [super requestWithBaseUrlStrByPost:DEFAULT_URL
                               andPath:@"user/sendCode"
                          andParamsDic:paramsDic
                       andSuccessBlock:^(id data) {
                           
                           NSInteger flag = [[data objectForKey:@"code"] integerValue];
                           
                           if (flag == 200) {
                               successBlock(data);
                           } else {
                               failedBlock(data[@"message"]);
                           }
                           
                       } andFailedBlock:^(NSString *error) {
                           
                           NSLog(@"\n++++++++++ 获取验证码失败 : %@++++++++++", error);
                           
                           failedBlock(error);
                           
                       }];
}


/**
 *	@brief	验证短信验证码接口
 *	@param 	mobile 	                  手机号码
 *	@param 	checkCode 	              验证码
 *	@param 	successBlock              成功回调
 *	@param 	failedBlock 	          失败回调
 */
+ (void)checkSmsCodeWithMobile:(NSString *)mobileNum
                     checkCode:(NSString *)checkCode
               andSuccessBlock:(SuccessBlock)successBlock
                andFailedBlock:(FailedBlock)failedBlock
{
    NSMutableDictionary *paramsDic = [[NSMutableDictionary alloc] initWithCapacity:2];
    [paramsDic setObject:mobileNum forKey:@"tel"];
    [paramsDic setObject:checkCode forKey:@"code"];
    
    [super requestWithBaseUrlStrByPost:DEFAULT_URL
                               andPath:@"user/checkCode"
                          andParamsDic:paramsDic
                andSuccessBlock:^(id data) {
                    
                    NSInteger flag = [[data objectForKey:@"code"] integerValue];
                    
                    if (flag == 200) {
                        successBlock(data);
                    } else {
                        failedBlock(data[@"message"]);
                    }
                    
                } andFailedBlock:^(NSString *error) {
                    
                    NSLog(@"\n++++++++++ 该验证码失效 : %@++++++++++", error);
                    
                    failedBlock(error);
                    
                }];
}



/**
 *	@brief	忘记密码/找回密码
 *  @param  newPassword         新密码
 *  @param  checkCode           短信验证码
 *	@param 	successBlock        成功回调
 *	@param 	failedBlock 	    失败回调
 */


+ (void)modifyWithPhone:(NSString *)phone
               password:(NSString *)newPassword
        andSuccessBlock:(SuccessBlock)successBlock
         andFailedBlock:(FailedBlock)failedBlock
{
    NSDictionary *params = @{@"phone":phone,
                             @"password":newPassword};
    
    [super requestWithBaseUrlStrByPost:DEFAULT_URL
                               andPath:@"user/forgetPassword"
                          andParamsDic:params
                andSuccessBlock:^(id data) {
                    
                    NSInteger flag = [[data objectForKey:@"code"] integerValue];
                    
                    if (flag == 200) {
                        
                        successBlock(data);
                        
                    } else {
                        
                        failedBlock(data[@"message"]);
                    }
                    
                } andFailedBlock:^(NSString *error) {
                    
                    NSLog(@"\n++++++++++  修改密码错误 : %@++++++++++", error);
                    
                    failedBlock(error);
                    
                }];
}


/**
 *	@brief  注册接口
 *  @param  params  参数
 *	@param 	successBlock 	成功回调
 *	@param 	failedBlock 	失败回调
 */
+ (void)registerWithParam:(NSDictionary *)params
          andSuccessBlock:(SuccessBlock)successBlock
           andFailedBlock:(FailedBlock)failedBlock {
    
    [super requestWithBaseUrlStrByPost:DEFAULT_URL
                               andPath:@"user/register"
                          andParamsDic:params
                       andSuccessBlock:^(id data) {
                           
                           NSInteger flag = [[data objectForKey:@"code"] integerValue];
                           
                           if (flag == 200) {
                               
                               successBlock(data);
                           } else {
                               failedBlock(data[@"message"]);
                           }
                           
                       } andFailedBlock:^(NSString *error) {
                           
                           failedBlock(error);
                       }];
}

/**
 *	@brief  我的接口
 *	@param 	successBlock 	成功回调
 *	@param 	failedBlock 	失败回调
 */
+ (void)getMyUserInfoSuccessBlock:(SuccessBlock)successBlock
                   andFailedBlock:(FailedBlock)failedBlock
{
    NSDictionary *paramsDic = @{@"userToken": DataCenterManager.userToken};
    [super requestWithBaseUrlStrByPost:DEFAULT_URL
                               andPath:@"user/myInfo"
                          andParamsDic:paramsDic
                       andSuccessBlock:^(id data) {
                           
                           NSInteger flag = [[data objectForKey:@"code"] integerValue];
                           
                           if (flag == 200) {
                               
                               successBlock(data);
                           } else {
                               failedBlock(data[@"message"]);
                           }
                           
                       } andFailedBlock:^(NSString *error) {
                           
                           failedBlock(error);
                       }];
}

@end
