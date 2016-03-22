//
//  MultipleRecordDBHandle.h
//  4G
//  多人通话记录 数据库操作
//  Created by yg on 16/2/29.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MultipleRecordModel;

@interface MultipleRecordDBHandle : NSObject

+ (MultipleRecordDBHandle *)shareRecordDB;

- (NSArray *)getAllRecordsDataFromDB;
- (BOOL)insertContactsList:(MultipleRecordModel *)recordData;
- (BOOL)deleteRecordWithId:(NSString *)startCallTime;  //通话ID

@end
