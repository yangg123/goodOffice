//
//  AreaData.h
//  Yeke
//
//  Created by yangg on 15-1-19.
//  Copyright (c) 2015年 西米网络科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaData : NSObject

@property(nonatomic, assign) NSInteger areaId;
@property(nonatomic, assign) NSInteger seqId;
@property(nonatomic, copy)   NSString *areaName;
@property(nonatomic, copy)   NSString *lng;
@property(nonatomic, copy)   NSString *lat;
@end


//"id": 9,
//"name": "宁德",
//"seq": 9,
//"lng": 26.665762,
//"lat": 119.59411