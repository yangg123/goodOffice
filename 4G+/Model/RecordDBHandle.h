//
//  RecordDBHandle.h
//  4G
//  通话记录 数据库操作
//  Created by yg on 16/1/31.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RecordModel;

@interface RecordDBHandle : NSObject

+ (RecordDBHandle *)shareRecordBD;

- (NSArray *)getAllRecordsDataFromDB;                  //获取所有通话记录
- (BOOL)insertContactsList:(RecordModel *)recordData;
- (BOOL)deleteRecordWithId:(NSString *)startCallTime;  //通话ID
+ (void)deleteRecordsDataDB;
- (NSArray *)getUpdatedRecords;
/**
 *	@brief  根据电话号码 获取某个人全部的通话记录，倒序排序
 *	@return	通话记录
 */
- (NSArray *)getPersonRecordsFromNum:(NSString *)telphoneNum;

@end
