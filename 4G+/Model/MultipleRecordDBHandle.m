//
//  MultipleRecordDBHandle.m
//  4G
//  多人通话记录 数据库操作
//  Created by yg on 16/2/29.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "MultipleRecordDBHandle.h"
#import "DBInterface.h"
#import "MultipleRecordModel.h"

#define RECORD_TABLE                @"t_Mul_RecordsDB"

#define RECORD_ID                   @"recordId"     //记录ID
#define USER_NAME                   @"userNames"    //多人通话用户名   (干干|杨高)
#define USER_TEL                    @"telphoneNums" //多人通话电话号码 (15080476625|13696891565)
#define RECORD_BEGIN_TIME           @"beginTime"    //开始时间
#define RECORD_TIME                 @"times"        //通话时长


@implementation MultipleRecordDBHandle

+ (MultipleRecordDBHandle *)shareRecordBD
{
    static MultipleRecordDBHandle *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}


- (id)init{
    if (self = [super init]) {
        if ([self initRecordsDB]) {
        }
    }
    return self;
}

/**
 *	@brief	创建通话记录表
 *	@return	BOOL
 */
- (BOOL)initRecordsDB
{
    BOOL isSuccess = NO;
    
    if (![[DBInterface shareDBInterface] isTableExists:RECORD_TABLE]) {
        NSMutableString *sql = [[NSMutableString alloc] init];
        [sql appendFormat:@"create table if not exists %@(", RECORD_TABLE];
        [sql appendFormat:@"%@ integer NOT NULL PRIMARY KEY AUTOINCREMENT,",RECORD_ID];
        [sql appendFormat:@"%@ text,",  USER_NAME];
        [sql appendFormat:@"%@ text,",  USER_TEL];
        [sql appendFormat:@"%@ text ,",  RECORD_BEGIN_TIME];
        [sql appendFormat:@"%@ text)",  RECORD_TIME];
        
        isSuccess = [[DBInterface shareDBInterface] createTable:sql];
    }
    return isSuccess;
}


//插入数据
- (BOOL)insertContactsList:(MultipleRecordModel *)recordData
{
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendFormat:@"replace into %@(", RECORD_TABLE];
    
    [sql appendFormat:@"%@,",   USER_NAME];
    [sql appendFormat:@"%@,",   USER_TEL];
    [sql appendFormat:@"%@,",   RECORD_BEGIN_TIME];
    [sql appendFormat:@"%@)",   RECORD_TIME];
    [sql appendString:@" values(?, ?, ?, ?, ?)"];
    
    NSMutableArray * arguments = [NSMutableArray arrayWithObjects:
                                  [Publish combinePhonesFromArr:recordData.namesArr],
                                  [Publish combinePhonesFromArr:recordData.numbersArr],
                                  recordData.startCallTime,
                                  recordData.callLong,
                                  nil];
    
    return [[DBInterface shareDBInterface] insertDataWithSql:sql obj:arguments];
}

/**
 *	@brief  从数据库获取praised数据
 *	@return	返回的数据
 */
- (NSArray *)getAllRecordsDataFromDB
{
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendString:@"select * from t_RecordsDB"];
    NSArray *tempArr = [[DBInterface shareDBInterface] queryDataWithSql:sql obj:nil];
    
    NSMutableArray *returnArr = [NSMutableArray arrayWithCapacity:tempArr.count];
    for (NSDictionary *dic in tempArr) {
        MultipleRecordModel *model = [MultipleRecordModel new];
        model.namesArr =  [dic[USER_NAME] componentsSeparatedByString:@","];
        model.numbersArr = [dic[USER_TEL] componentsSeparatedByString:@","];
        model.startCallTime = dic[RECORD_BEGIN_TIME];
        model.callLong = dic[RECORD_TIME];
        [returnArr addObject:model];
    }
    return [returnArr copy];
}

/**
 *	@brief  删除某一条通话记录
 *	@return	返回状态
 */
- (BOOL)deleteRecordWithId:(NSString *)startCallTime
{
    NSString *sqlString = [NSString stringWithFormat:
                           @"delete from t_RecordsDB where beginTime='%@'",
                           startCallTime];
    return [[DBInterface shareDBInterface] deleteDataWithSql:sqlString obj:nil];
}

@end
