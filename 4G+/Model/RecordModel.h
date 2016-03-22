//
//  RecordModel.h
//  4G
//  通话记录数据模型
//  Created by yg on 16/1/31.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordModel : NSObject

@property (nonatomic,strong) NSString *beCalledName;  //被呼叫人名
@property (nonatomic,strong) NSString *beCalledNum;   //被呼叫号码
@property (nonatomic,strong) NSString *startCallTime; //呼叫开始时间,用时间戳来表示 ===>可以拿这个作为主键，唯一标识
@property (nonatomic,strong) NSString *callLong;      //呼叫时长
@property (nonatomic,assign) BOOL isUnkonwn;          //是未知的

@end
