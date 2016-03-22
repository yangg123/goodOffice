//
//  AreaService.m
//  Yeke
//
//  Created by yangg on 15-1-19.
//  Copyright (c) 2015年 西米网络科技. All rights reserved.
//

#import "AreaService.h"
#import "UserModel.h"
#import "DataCenter.h"

@implementation AreaService


/**
 *	@brief	获取一个城市下的地区列表
 *	@param  city_id=1    地区ID
 *	@param 	successRequestBlock 	成功回调
 *	@param 	failedRequestBlock 	失败回调
 */
//+ (void)getAreasCityId:(NSString *)cityId
//       andSuccessBlock:(SuccessBlock)successBlock
//        andFailedBlock:(FailedBlock)failedBlock
//{
//    NSDictionary *paramsDic = @{@"city_id":cityId};
//    
//    [super requestWithBaseUrlStrByPost:URL_HEADER
//                               andPath:@"area/districts"
//                          andParamsDic:paramsDic
//                andSuccessRequestBlock:^(id data) {
//                    NSInteger flag = [[data objectForKey:@"succeed"] integerValue];
//                    NSDictionary *currentUserDic = [data objectForKey:@"data"];
//                    NSLog(@"地区列表返回的信息是:%@",currentUserDic);
//                    
//                    
//                    if (flag == 1) {
//                        
//                        successRequestBlock(currentUserDic);
//                        
//                    } else {
//                        failedRequestBlock([data objectForKey:@"message"]);
//                    }
//                    
//                } andFailedRequestBlock:^(NSString *error) {
//                    
//                    NSLog(@"\n++++++++++ 请求失败 : %@++++++++++", error);
//                    
//                    failedRequestBlock(error);
//                    
//                }];
//}
//
//
///**
// *	@brief	获取全部城市列表
// *
// *	@param 	successRequestBlock 	成功回调
// *	@param 	failedRequestBlock 	失败回调
// */
//+ (void)getAllCitysListandSuccessRequestBlock:(SuccessRequestBlock)successRequestBlock
//                        andFailedRequestBlock:(FailedRequestBlock)failedRequestBlock {
//    
//    [super requestWithBaseUrlStrByPost:URL_HEADER
//                               andPath:@"area/cities"
//                          andParamsDic:nil
//                andSuccessRequestBlock:^(id data) {
//                    NSInteger flag = [[data objectForKey:@"succeed"] integerValue];
//                    NSDictionary *currentUserDic = [data objectForKey:@"data"];
//                    NSLog(@"获取全部城市列表返回的信息是:%@",currentUserDic);
//                    if (flag == 1) {
//                        
//                        NSDictionary *resDic = [currentUserDic objectForKey:@"cityList"];
//                        
//                        successRequestBlock(resDic);
//                        
//                    } else {
//                        failedRequestBlock([data objectForKey:@"message"]);
//                    }
//                }
//                andFailedRequestBlock:^(NSString *error) {
//                    
//                    NSLog(@"\n++++++++++ 请求失败 : %@++++++++++", error);
//                    
//                    failedRequestBlock(error);
//                    
//                }];
//}
//
//
///**
// *	@brief	根据用户的经纬度，获取用户可能所在的城市
// *
// *	@param 	lat=26.069886 	经度
// *	@param 	lng=119.310494 	纬度
// *	@param 	successRequestBlock 	成功回调
// *	@param 	failedRequestBlock 	失败回调
// */
//+ (void)areaWithUserlat:(NSString *)lat
//               andUselng:(NSString *)lng
//  andSuccessRequestBlock:(SuccessRequestBlock)successRequestBlock
//   andFailedRequestBlock:(FailedRequestBlock)failedRequestBlock {
//    
//    NSDictionary *paramsDic = @{@"lat": lat,
//                                @"lng": lng};
//    
//    [super requestWithBaseUrlStrByPost:URL_HEADER
//                               andPath:@"area/findCity"
//                          andParamsDic:paramsDic
//                andSuccessRequestBlock:^(id data) {
//                    NSInteger flag = [[data objectForKey:@"succeed"] integerValue];
//                    NSDictionary *currentUserDic = [data objectForKey:@"data"];
//                    NSLog(@"登录返回的信息是:%@",currentUserDic);
//
//                    
//                    if (flag == 1) {
//                        
//                        NSDictionary *resDic = [currentUserDic objectForKey:@"city"];
//                        
//                        successRequestBlock(resDic);
//                        
//                    } else {
//                        failedRequestBlock([data objectForKey:@"message"]);
//                    }
//                    
//                } andFailedRequestBlock:^(NSString *error) {
//                    
//                    NSLog(@"\n++++++++++ 请求失败 : %@++++++++++", error);
//                    
//                    failedRequestBlock(error);
//                    
//                }];
//}

@end
