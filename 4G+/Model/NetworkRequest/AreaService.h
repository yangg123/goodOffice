//
//  AreaService.h
//  Yeke
//
//  Created by yangg on 15-1-19.
//  Copyright (c) 2015年 西米网络科技. All rights reserved.
//

#import "BaseService.h"

@interface AreaService : BaseService


/**
 *	@brief	获取一个城市下的地区列表
 *	@param  city_id=1    地区ID
 *	@param 	successBlock 	成功回调
 *	@param 	failedBlock 	失败回调
 */
+ (void)getAreasCityId:(NSString *)cityId
       andSuccessBlock:(SuccessBlock)successBlock
        andFailedBlock:(FailedBlock)failedBlock;


/**
 *	@brief	获取全部城市列表
 *	@param 	successBlock 	成功回调
 *	@param 	failedBlock 	失败回调
 */
+ (void)getAllCitysListandSuccessBlock:(SuccessBlock)successBlock
                        andFailedBlock:(FailedBlock)failedBlock;


/**
 *	@brief	根据用户的经纬度，获取用户可能所在的城市
 *
 *	@param 	lat=26.069886 	经度
 *	@param 	lng=119.310494 	纬度
 *	@param 	successBlock 	成功回调
 *	@param 	failedBlock 	失败回调
 */
+ (void)areaWithUserlat:(NSString *)lat
              andUselng:(NSString *)lng
        andSuccessBlock:(SuccessBlock)successBlock
         andFailedBlock:(FailedBlock)failedBlock;


@end
