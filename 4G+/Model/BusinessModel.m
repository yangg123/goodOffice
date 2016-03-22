
//
//  BusinessModel.m
//  4G
//
//  Created by 赵祥 on 16/2/29.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "BusinessModel.h"

@implementation BusinessModel

@end
@implementation NSDictionary (BusinessModel)

- (BusinessModel *)BusinessFormate
{
    BusinessModel *businessModel = [[BusinessModel alloc] init];
    businessModel.status = [self[@"status"] longValue];
    businessModel.ctime = [NSString stringWithFormat:@"%ld",[self[@"status"] longValue]];
    businessModel.userId = [NSString stringWithFormat:@"%ld",[self[@"userId"] longValue]];
    businessModel.Id =[NSString stringWithFormat:@"%ld",[self[@"id"] longValue]];
    businessModel.isRecommend =  [self[@"isRecommend"] boolValue];
    businessModel.company =self[@"company"];
    businessModel.contacts = self[@"contacts"];
    businessModel.isFavorite = [self[@"isFavorite"] boolValue];
    businessModel.Description = self[@"description"];
    businessModel.industry = self[@"industry"];
    businessModel.tel = self[@"tel"];
    return businessModel;
}
@end

