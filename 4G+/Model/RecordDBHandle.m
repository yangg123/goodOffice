//
//  RecordDBHandle.m
//  4G
//
//  Created by yg on 16/1/31.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "RecordDBHandle.h"
#import "DBInterface.h"
#import "RecordModel.h"

#define RECORD_TABLE                @"t_RecordsDB"

#define RECORD_ID                   @"recordId"     //记录ID
#define USER_NAME                   @"userName"     //用户名
#define USER_TEL                    @"telphoneNum"  //电话号码
#define RECORD_BEGIN_TIME           @"beginTime"    //开始时间
#define RECORD_TIME                 @"times"        //通话时长
#define IS_UNKNOWN                  @"isUnknown"    //是未知的号码

@implementation RecordDBHandle

+ (RecordDBHandle *)shareRecordBD
{
    static RecordDBHandle *_instance;
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
        [sql appendFormat:@"%@ integer ,",IS_UNKNOWN];
        [sql appendFormat:@"%@ text)",  RECORD_TIME];
        
        isSuccess = [[DBInterface shareDBInterface] createTable:sql];
    }
    return isSuccess;
}


//插入数据
- (BOOL)insertContactsList:(RecordModel *)recordData
{
    NSMutableString *sql = [[NSMutableString alloc] init];
    [sql appendFormat:@"replace into %@(", RECORD_TABLE];
    
    [sql appendFormat:@"%@,",   USER_NAME];
    [sql appendFormat:@"%@,",   USER_TEL];
    [sql appendFormat:@"%@,",   RECORD_BEGIN_TIME];
    [sql appendFormat:@"%@,",   IS_UNKNOWN];
    [sql appendFormat:@"%@)",   RECORD_TIME];
    
    [sql appendString:@" values(?, ?, ?, ?, ?)"];
    
    NSMutableArray * arguments = [NSMutableArray arrayWithObjects:
                                  recordData.beCalledName,
                                  recordData.beCalledNum,
                                  recordData.startCallTime,
                                  [NSNumber numberWithBool:recordData.isUnkonwn],
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
        RecordModel *model = [RecordModel new];
        model.beCalledName = dic[USER_NAME];
        model.beCalledNum = dic[USER_TEL];
        model.startCallTime = dic[RECORD_BEGIN_TIME];
        model.isUnkonwn = [dic[IS_UNKNOWN] boolValue];
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

/**
 *	@brief  删除本地联系人数据
 *	@return	返回状态
 */
+ (void)deleteRecordsDataDB
{
    DBInterface *dbInterface = [DBInterface shareDBInterface];
    if ([dbInterface isTableExists:@"t_RecordsDB"]) {
        [dbInterface deleteTableWithName:@"t_RecordsDB"];
    }
}

/**
 *	@brief  根据电话号码 获取某个人全部的通话记录，倒序排序
 *	@return	通话记录
 */
- (NSArray *)getPersonRecordsFromNum:(NSString *)telphoneNum
{
    DBInterface *dbInterface = [DBInterface shareDBInterface];
    
    //判断动态是否存在
    if ([dbInterface dataIsExsit:RECORD_TABLE where:[NSString stringWithFormat:@"%@='%@'",USER_TEL,telphoneNum] obj:nil]) {
        NSString *sql = [NSString stringWithFormat:@"select * from '%@' WHERE %@='%@'   ORDER BY %@ DESC",
                         RECORD_TABLE,
                         USER_TEL,
                         telphoneNum,
                         RECORD_BEGIN_TIME];
        NSArray * returnArr = [dbInterface queryDataWithSql:sql obj:nil];
        return returnArr;
    }
    return nil;
}

//返回更新后的通话记录表，遍历之前每个通话记录的号码，是否存在于 手机通讯录联表里面， 1：就改名字2：没有就是未知号码
- (NSArray *)getUpdatedRecords
{
    for (RecordModel *model in  [self getAllRecordsDataFromDB]) {
        
        BOOL existInAddressBook = NO;
        NSArray *allConatcts = [Publish getAllContacts];
        
        for (int i = 0; i < allConatcts.count; i++) {
            
            TKAddressBook *contact = allConatcts[i];
            for (NSString *subPhone in contact.telPhones) {
                
                if (EqualString(model.beCalledNum, subPhone) ) {
                    model.beCalledName = contact.name;
                    existInAddressBook = YES;
                }
            }
        }
        
        if (existInAddressBook == NO) {
            model.beCalledName = @"未知号码";
        }
        NSString *sqlString = [NSString stringWithFormat:
                               @"UPDATE %@ SET %@=? WHERE %@=?",
                               RECORD_TABLE,
                               USER_NAME,
                               USER_TEL];
        
        NSArray *objArr = @[model.beCalledName,
                            model.beCalledNum,
                            ];
        
        [[DBInterface shareDBInterface] insertDataWithSql:sqlString obj:objArr];
    }
    return [self getAllRecordsDataFromDB];
}

@end
