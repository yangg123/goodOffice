//
//  BusinessModel.h
//  4G
//
//  Created by 赵祥 on 16/2/29.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessModel : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *ctime;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, assign) BOOL isRecommend;
@property (nonatomic, strong) NSString *company;   //公司
@property (nonatomic, strong) NSString *contacts;  //联系人
@property (nonatomic, assign) BOOL isFavorite;  //是否收藏
@property (nonatomic, strong) NSString *Description; // 业务简介
@property (nonatomic, strong) NSString *industry;
@property (nonatomic, strong) NSString *tel;

@end

@interface NSDictionary (BusinessModel)

- (BusinessModel *)BusinessFormate;

@end

