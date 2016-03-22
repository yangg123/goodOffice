//
//  BusinessService.m
//  4G
//  商机通讯录网络接口
//  Created by yg on 16/2/27.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "BusinessService.h"
#import "DataCenter.h"

@implementation BusinessService

/**
 *	@brief	创建商机通讯录
 *	@param 	businessId 	    商机ID（可选)
 *	@param  company         企业名称
 *	@param  industry        所属行业
 *	@param  description     业务简介
 *	@param  contacts        联系人
 *	@param  tel             联系电话
 *	@param 	successBlock 	成功回调
 *	@param 	failedBlock 	失败回调
 */

+ (void)saveBusiness:(NSString *)businessId
             company:(NSString *)company
            industry:(NSString *)industry
         description:(NSString *)description
            contacts:(NSString *)contacts
                 tel:(NSString *)tel
     andSuccessBlock:(SuccessBlock)successBlock
      andFailedBlock:(FailedBlock)failedBlock
{
    NSDictionary *paramsDic = @{@"userToken": DataCenterManager.userToken,
                                @"businessId": businessId,
                                @"company":company,
                                @"industry":industry,
                                @"description":description,
                                @"contacts":contacts,
                                @"tel":tel};
    
    [super requestWithBaseUrlStrByPost:DEFAULT_URL
                               andPath:@"business/saveBusiness"
                          andParamsDic:paramsDic
                       andSuccessBlock:^(id data){
                           
                           NSInteger flag = [[data objectForKey:@"code"] integerValue];
                           
                           if (flag == 200) {
                               
                                NSString *result = @"success";
                               successBlock(result);
                               
                           } else {
                               
                               failedBlock([data objectForKey:@"message"]);
                           }
                       } andFailedBlock:^(NSString *error) {
                           
                           failedBlock(error);
                       }];
}


/**
 *	@brief	商机动态
 *	@param 	successBlock 	成功回调
 *	@param 	failedBlock 	失败回调
 */
+ (void)getBusinessLisSuccessBlock:(SuccessBlock)successBlock
                    andFailedBlock:(FailedBlock)failedBlock
{
    NSDictionary *paramsDic = @{@"userToken": DataCenterManager.userToken};
    
    [super requestWithBaseUrlStrByPost:DEFAULT_URL
                               andPath:@"business/businessList"
                          andParamsDic:paramsDic
                       andSuccessBlock:^(id data){
                           
                           NSInteger flag = [[data objectForKey:@"code"] integerValue];
                           
                           if (flag == 200) {
                               
                               NSDictionary *resDic = data[@"data"];
                               successBlock(resDic);
                               
                           } else {
                               
                               failedBlock([data objectForKey:@"message"]);
                           }
                       } andFailedBlock:^(NSString *error) {
                           
                           failedBlock(error);
                       }];
}


/**
 *	@brief	我的关注
 *	@param 	successBlock 	成功回调
 *	@param 	failedBlock 	失败回调
 */
+ (void)getMyFavLisSuccessBlock:(SuccessBlock)successBlock
                 andFailedBlock:(FailedBlock)failedBlock
{
    NSDictionary *paramsDic = @{@"userToken": DataCenterManager.userToken};
    
    [super requestWithBaseUrlStrByPost:DEFAULT_URL
                               andPath:@"business/myFavoriteBusinessList"
                          andParamsDic:paramsDic
                       andSuccessBlock:^(id data){
                           
                           NSInteger flag = [[data objectForKey:@"code"] integerValue];
                           
                           if (flag == 200) {
                               
                               NSDictionary *resDic = data[@"data"];
                               successBlock(resDic);
                               
                           } else {
                               
                               failedBlock([data objectForKey:@"message"]);
                           }
                       } andFailedBlock:^(NSString *error) {
                           
                           failedBlock(error);
                       }];
}


/**
 *	@brief	关注商机
 *	@param  businessId      关注哪个商机
 *	@param  isFavorite      是否关注
 *	@param 	successBlock 	成功回调
 *	@param 	failedBlock 	失败回调
 */
+ (void)focusOnBusinessId:(NSString *)businessId
               isFavorite:(BOOL)isFavorite
          andSuccessBlock:(SuccessBlock)successBlock
           andFailedBlock:(FailedBlock)failedBlock
{
    NSDictionary *paramsDic = @{@"userToken": DataCenterManager.userToken,
                                @"businessId":businessId,
                                @"isFavorite":[NSNumber numberWithBool:isFavorite]};
    
    [super requestWithBaseUrlStrByPost:DEFAULT_URL
                               andPath:@"business/favoriteBusiness"
                          andParamsDic:paramsDic
                       andSuccessBlock:^(id data){
                           
                           NSInteger flag = [[data objectForKey:@"code"] integerValue];
                           
                           if (flag == 200) {
                               NSString *result = @"success";
//                               NSDictionary *resDic = data[@"data"][@"result"];
                               successBlock(result);
                               
                           } else {
                               
                               failedBlock([data objectForKey:@"message"]);
                           }
                       } andFailedBlock:^(NSString *error) {
                           
                           failedBlock(error);
                       }];
}

/**
 *	@brief	搜索商机
 *	@param  keyword      关注哪个商机
 *	@param 	successBlock 	成功回调
 *	@param 	failedBlock 	失败回调
 */
+ (void)searchBusinessListWithKeyWord:(NSString *)keyword
                      andSuccessBlock:(SuccessBlock)successBlock
                       andFailedBlock:(FailedBlock)failedBlock
{
    NSDictionary *paramsDic = @{@"userToken": DataCenterManager.userToken,
                                @"keyword":keyword};
    
    [super requestWithBaseUrlStrByPost:DEFAULT_URL
                               andPath:@"business/searchBusinessList"
                          andParamsDic:paramsDic
                       andSuccessBlock:^(id data){
                           
                           NSInteger flag = [[data objectForKey:@"code"] integerValue];
                           
                           if (flag == 200) {
                               
                               NSDictionary *resDic = data[@"data"];
                               successBlock(resDic);
                               
                           } else {
                               
                               failedBlock([data objectForKey:@"message"]);
                           }
                       } andFailedBlock:^(NSString *error) {
                           
                           failedBlock(error);
                       }];
}
@end
