//
//  MultipleRecordModel.h
//  4G
//  多人通话 记录模型
//  Created by yg on 16/2/29.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MultipleRecordModel : NSObject

@property (nonatomic,strong) NSArray *namesArr;   //多方通话 名字
@property (nonatomic,strong) NSArray *numbersArr; //多方通话 号码
@property (nonatomic,strong) NSString *startCallTime; //呼叫开始时间,用时间戳来表示 ===>可以拿这个作为主键，唯一标识
@property (nonatomic,strong) NSString *callLong;      //呼叫时长



@end
