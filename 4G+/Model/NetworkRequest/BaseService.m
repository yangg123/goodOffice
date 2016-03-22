//
//  BaseService.m
//  GoodOffice
//  功能描述: 网络请求接口基类
//  Created by cgf yangg on 16-2-25.
//  Copyright (c) 2016年  西米网络科技. All rights reserved.

#import "BaseService.h"

@implementation BaseService

/**
 *	@brief	根据传入的baseUrlStr和参数字典请求网络[get]
 *
 *	@param 	baseUrlStr 	baseUrlStr
 *  @param  path        路径
 *	@param 	paramsDic 	参数字典
 *	@param 	successRequestBlock 成功block
 *	@param 	failedRequestBlock 	失败block
 */
+ (void)requestWithBaseUrlStrByGet:(NSString *)baseUrlStr
                           andPath:(NSString *)path
                      andParamsDic:(NSDictionary *)paramsDic
                   andSuccessBlock:(SuccessBlock)successBlock
                    andFailedBlock:(FailedBlock)failedBlock
{
    NSString *requestPath = [baseUrlStr stringByAppendingString:path];
    NSLog(@"========> 当前请求的接口是 ：%@",requestPath);
    NSLog(@"\n******** get 请求的参数是：%@",paramsDic);
    
    SCNetWorkStatus *networkStatus = [SCNetworkMonitor sharedInstance].netStatus;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [[AFAppDotNetAPIClient sharedClientWithBaseUrlStr:baseUrlStr]
     GET:path
     parameters:paramsDic
     success:^(NSURLSessionDataTask * __unused task, id JSON) {
         
         //         NSLog(@"\n*************        get 请求成功！！    **************");
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         if (successBlock) {
             NSString *resultString = [[NSString alloc] initWithData:JSON encoding:NSUTF8StringEncoding];
             NSData *resultData = [resultString dataUsingEncoding:NSUTF8StringEncoding];
             NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:nil];
             successBlock(resultDictionary);
         }
     } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
         
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         
         if (failedBlock) {
             
             if (networkStatus.nStatus == 0) {//已连接
                 failedBlock(@"😂网络好像有点问题");
             } else {
                 if(((NSHTTPURLResponse *)task.response).statusCode != 0 && error.userInfo != nil) {
                     
                     NSString *resultStr = [error.userInfo objectForKey:@"NSLocalizedRecoverySuggestion"];
                     
                     NSData *resultData = [resultStr dataUsingEncoding:NSUTF8StringEncoding];
                     
                     NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:nil];
                     
                     NSString *errorMsg = [resultDictionary objectForKey:@"error"];
                     
                     failedBlock(errorMsg);
                     
                 } else {
                     
                     failedBlock(error.description);
                 }
             }
             
         }
     }];
}

/**
 *	@brief	根据传入的baseUrlStr和参数字典请求网络[post]
 *
 *	@param 	baseUrlStr 	baseUrlStr
 *  @param  path        路径
 *	@param 	paramsDic 	参数字典
 *	@param 	successRequestBlock 成功block
 *	@param 	failedRequestBlock 	失败block
 */
+ (void)requestWithBaseUrlStrByPost:(NSString *)baseUrlStr
                            andPath:(NSString *)path
                       andParamsDic:(NSDictionary *)paramsDic
                    andSuccessBlock:(SuccessBlock)successBlock
                     andFailedBlock:(FailedBlock)failedBlock
{
    NSString *requestPath = [baseUrlStr stringByAppendingString:path];
    
    NSLog(@"========> 当前请求的接口是 ：%@",requestPath);
    NSLog(@"\n******** post 请求的参数是：%@",paramsDic);
    
    SCNetWorkStatus *networkStatus = [SCNetworkMonitor sharedInstance].netStatus;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [[AFAppDotNetAPIClient sharedClientWithBaseUrlStr:baseUrlStr]
     POST:path
     parameters:paramsDic
     success:^(NSURLSessionDataTask * __unused task, id JSON) {
         
         NSLog(@"\n**************      %@ 请求成功！！  ****************",path);
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         if (successBlock) {
             
             NSString *resultString = [[NSString alloc] initWithData:JSON encoding:NSUTF8StringEncoding];
             NSData *resultData = [resultString dataUsingEncoding:NSUTF8StringEncoding];
             NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:nil];
             
             NSString *outOfDatae = resultDictionary[@"message"];
             //NSString *outOfDatae = @"登录已过期，请重新登录";
             
             if ([outOfDatae containsString:OutOfDate]) {
//                 [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_OutOfDate object:outOfDatae];
             } else {
                 successBlock(resultDictionary);
             }
         }
     } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
         
         NSLog(@"\n*************        %@ 请求失败！！    **************",path);
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         
         if (failedBlock) {
             
             if (networkStatus.nStatus == 0) {//已连接
                 failedBlock(@"😂网络好像有点问题");
             } else {
                 if(((NSHTTPURLResponse *)task.response).statusCode != 0 && error.userInfo != nil) {
                     
                     NSString *resultStr = [error.userInfo objectForKey:@"NSLocalizedRecoverySuggestion"];
                     
                     if (resultStr == nil) {
                         failedBlock(@"😂服务器出了点问题，请稍后重试");
                     } else {
                         NSData *resultData = [resultStr dataUsingEncoding:NSUTF8StringEncoding];
                         
                         NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:nil];
                         
                         NSString *errorMsg = [resultDictionary objectForKey:@"error"];
                         
                         if (NSStringIsValid(errorMsg)) {
                             failedBlock(errorMsg);
                         }
                     }
                     
                 } else {
                     failedBlock(error.description);
                 }
             }
         }
     }];
}

@end
