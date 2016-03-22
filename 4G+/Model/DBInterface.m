//
//  DBInterface.m
//  GoodOffice
//  数据库接口
//  Created by cgf yangg on 16-1-31.
//  Copyright (c) 2016年 cgf. All rights reserved.

#import "DBInterface.h"
#import "FMDatabaseQueue.h"
#import "FMDatabaseAdditions.h"

#define DB_FILE_NAME @"4g_database.db"
#define OperatorDBDelay(sec) [NSThread sleepForTimeInterval:(0.0)];

#define ClearTblSQLStr(name) [NSString stringWithFormat:@"delete from %@",(name)]

#define DeleteTblSQLStr(name) [NSString stringWithFormat:@"DROP TABLE '%@';",(name)]

#define TblIsExsitSQLStr(name) [NSString stringWithFormat:@"SELECT COUNT(*) FROM sqlite_master WHERE type='table' AND name='%@'",(tblName)]

#define TblDataIsExsitSQLStr(name,whereSql) [NSString stringWithFormat:@"SELECT COUNT(*) FROM %@ WHERE %@;",(name),(whereSql)]

@interface DBInterface ()

@property(nonatomic, copy)NSString* dbFile;
@property(nonatomic, strong)FMDatabaseQueue* dbQueue;

@end

@implementation DBInterface

static DBInterface *s_DBInterface = nil;

/**
 *	@brief	获取DBInterface单例
 *
 *	@return	DBInterface
 */
+(DBInterface *)shareDBInterface{
    @synchronized(self) {
        if (nil==s_DBInterface) {
            s_DBInterface = [[DBInterface alloc] init];
        }
    }
    return s_DBInterface;
}

/**
 *	@brief	init
 *
 *	@return	DBInterface
 */
- (id) init{
    if (self = [super init]) {
        if ([self initDatabase]) {
        }
    }
    return self;
}

#pragma mark --Database
/**
 *	@brief	初始化Database
 *
 *	@return	BOOL
 */
- (BOOL)initDatabase
{
    BOOL success = NO;
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    self.dbFile = [documentsDirectory stringByAppendingPathComponent:DB_FILE_NAME];
    NSLog(@"数据库的存储路径是-------- %@",self.dbFile);
    
    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:self.dbFile];
    success = YES;
    
    _localDB = [[FMDatabase alloc] initWithPath:self.dbFile];
    if ([_localDB open]) {
        [_localDB setShouldCacheStatements:YES];
        success = YES;
    } else {
        NSLog(@"Failed to open database.");
    }
	
    return success;
}

/**
 *	@brief	关闭Database
 */
- (void)closeDatabase
{
    if (_localDB){
        [_localDB close];
    }
}

/**
 *	@brief	获取Database
 *
 *	@return	FMDatabase
 */
- (FMDatabase *)getDatabase
{
	if ([self initDatabase]) {
		return _localDB;
	}
	
	return nil;
}
#pragma end mark

#pragma mark --table
/**
 *	@brief	根据sql语句创建表
 *
 *	@param 	createSql 	对应sql语句
 *
 *	@return	BOOL
 */
-(BOOL) createTable:(NSString *)createSql{

    __block BOOL bRet = NO;

    if (createSql && createSql.length){
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);//同步等待
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            bRet =[db executeUpdate:createSql];
            
            dispatch_semaphore_signal(sema);
        }];
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    
    return bRet;
    
}

/**
 *	@brief	根据表名清空表
 *
 *	@param 	tblName 	表名
 *
 *	@return	BOOL
 */
-(BOOL) clearTableWithName:(NSString *)tblName{

    __block BOOL bRet = NO;
    
    if (tblName && tblName.length){
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);//同步等待

        [self.dbQueue inDatabase:^(FMDatabase *db) {
            NSString *delSqlStr = ClearTblSQLStr(tblName);
            bRet =[db executeUpdate:delSqlStr];
            
            dispatch_semaphore_signal(sema);
        }];
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    
    return bRet;
}


/**
 *	@brief	判断是否存在字段
 *
 *	@param 	columnName 	字段名
 *	@param 	tableName 	表名
 *
 *	@return	bool
 */
- (BOOL)columnExists:(NSString *)columnName WithTableName:(NSString *)tableName
{
    return [_localDB columnExists:columnName inTableWithName:tableName];
}



/**
 *	@brief	添加字段
 *
 *
 *	@return	bool
 */
- (BOOL)alterAddField:(NSString *)sql
{
    __block BOOL bRet = NO;
    
    if (sql && sql.length){
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);//同步等待
        
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            bRet =[db executeUpdate:sql];
            
            dispatch_semaphore_signal(sema);
        }];
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    
    return bRet;
}


/**
 *	@brief	根据表名删除表
 *
 *	@param 	tblName 	表名
 *
 *	@return	BOOL
 */
-(BOOL) deleteTableWithName:(NSString *)tblName{

    __block BOOL bRet = NO;
    
    if (tblName && tblName.length){
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);//同步等待
        
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            NSString *delSqlStr = DeleteTblSQLStr(tblName);
            bRet =[db executeUpdate:delSqlStr];
            
            dispatch_semaphore_signal(sema);
        }];
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    
    return bRet;
}

/**
 *	@brief	根据表名判断表是否存在
 *
 *	@param 	tblName 	表名
 *
 *	@return	BOOL
 */
- (BOOL)isTableExists:(NSString *)tblName
{
    __block BOOL bRet = NO;
    
    if (tblName && tblName.length){
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);//同步等待
        
        [self.dbQueue inDatabase:^(FMDatabase *db) {
        
            NSString *tblIsExsitSql  = TblIsExsitSQLStr(tblName);
            FMResultSet *resSet = [db executeQuery:tblIsExsitSql];
            while ([resSet next]) {
                if ([resSet intForColumnIndex:0] > 0) {
                    bRet = YES;
                    break;
                }
            }
            [resSet close];
            
            dispatch_semaphore_signal(sema);
        }];
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    
    return bRet;
}
#pragma end mark

#pragma mark --data
/**
 *	@brief	根据参数判断数据是否存在
 *
 *	@param 	tblName 	表名
 *	@param 	whereSql 	where的sql语句
 *	@param 	objArr 	参数array
 *
 *	@return	BOOL
 */
- (BOOL)dataIsExsit:(NSString *)tblName where:(NSString *)whereSql obj:(NSArray *)objArr
{
    __block BOOL bRet = NO;
    
    if (NSStringIsValid(tblName) && NSStringIsValid(whereSql)){
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);//同步等待

        [self.dbQueue inDatabase:^(FMDatabase *db) {
            
            FMResultSet *set = nil;
            NSString *sql = TblDataIsExsitSQLStr(tblName, whereSql);
            if (NSArrayIsValid(objArr)) {
                set = [db executeQuery:sql withArgumentsInArray:objArr];
            }else{
                set = [db executeQuery:sql];
            }
            
            if(set){
                while ([set next]){
                    NSLog(@"dataIsExsit::%@",[set stringForColumnIndex:0]);
                    if([set intForColumnIndex:0]>0){
                        bRet = YES;
                        break;
                    }
                }
            }else{
                bRet = NO;
            }
            
            [set close];
            
            dispatch_semaphore_signal(sema);
        }];
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    
    return bRet;
}

/**
 *	@brief	插入数据
 *
 *	@param 	sqlStr 	sql语句
 *	@param 	objArr 	参数array
 *
 *  "insert into newInfo (ID, 姓名) values (10, '妖怪')"
 *
 *	@return	BOOL
 */
- (BOOL)insertDataWithSql:(NSString *)sqlStr obj:(NSArray *)objArr
{
    __block BOOL bRet = NO;
    
    if (NSStringIsValid(sqlStr)){
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);//同步等待

        [self.dbQueue inDatabase:^(FMDatabase *db) {
            
            if (NSArrayIsValid(objArr)){
                bRet = [db executeUpdate:sqlStr withArgumentsInArray:objArr];
            }else{
                bRet = [db executeUpdate:sqlStr,nil];
            }
            
            dispatch_semaphore_signal(sema);

        }];
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    
    return bRet;
}

/**
 *	@brief	删除数据
 *
 *	@param 	sqlStr 	sql语句
 *	@param 	objArr 	参数array
 *
 *  delete from TABLE where id = 2
 *
 *	@return	BOOL
 */
- (BOOL)deleteDataWithSql:(NSString *)sqlStr obj:(NSArray *)objArr
{
    __block BOOL bRet = NO;
    
    if (NSStringIsValid(sqlStr)){
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);//同步等待

        [self.dbQueue inDatabase:^(FMDatabase *db) {
            
            if (NSArrayIsValid(objArr)){
                bRet = [db executeUpdate:sqlStr withArgumentsInArray:objArr];
            }else{
                bRet = [db executeUpdate:sqlStr,nil];
            }
            
             dispatch_semaphore_signal(sema);
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    
    return bRet;
}

/**
 *	@brief	查询数据
 *
 *	@param 	sqlStr 	sql语句
 *	@param 	objArr 	参数array
 *
 *	@return	NSArray
 */
- (NSArray *)queryDataWithSql:(NSString *)sqlStr obj:(NSArray *)objArr
{
    NSMutableArray *dataList = [[NSMutableArray alloc] initWithCapacity:68];
    
    if (NSStringIsValid(sqlStr)){
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);//同步等待
        
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            
            FMResultSet *resSet = nil;
            if (NSArrayIsValid(objArr)) {
                resSet = [db executeQuery:sqlStr withArgumentsInArray:objArr];
            }else{
                resSet = [db executeQuery:sqlStr];
            }
            
            while ([resSet next]) {
                [dataList addObject:[resSet resultDictionary]];
            }
            [resSet close];
            dispatch_semaphore_signal(sema);
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    
    return dataList;
}

+(void) showAllTblData{
    //查询全部  － objc＝nil
    NSString *sql = @"select * from tbl_black_list;";
    NSArray *queryArr = [[DBInterface shareDBInterface] queryDataWithSql:sql obj:nil];
    NSLog(@"%@",queryArr);
}
#pragma end mark

+(void) testDbInterface{
    if (1) {
        //建立表
        NSString *sql = @"CREATE TABLE IF NOT EXISTS tbl_black_list (UserId int PRIMARY KEY NOT NULL)";
        [[DBInterface shareDBInterface] createTable:sql];
        
        //插入数据 － objc
        sql = @"insert into tbl_black_list (UserId) values (?)";
        [[DBInterface shareDBInterface] insertDataWithSql:sql obj:[NSArray arrayWithObjects:[NSNumber numberWithInt:100010001], nil]];
        [[DBInterface shareDBInterface] insertDataWithSql:sql obj:[NSArray arrayWithObjects:[NSNumber numberWithInt:100010002], nil]];
        [[DBInterface shareDBInterface] insertDataWithSql:sql obj:[NSArray arrayWithObjects:[NSNumber numberWithInt:100010003], nil]];
        //插入数据 － objc＝nil
        sql = @"insert into tbl_black_list (UserId) values (100010004)";
        [[DBInterface shareDBInterface] insertDataWithSql:sql obj:nil];
        sql = @"insert into tbl_black_list (UserId) values (100010005)";
        [[DBInterface shareDBInterface] insertDataWithSql:sql obj:nil];
        
        
        
        NSArray *tmp = [NSArray arrayWithObjects:[NSNumber numberWithInt:100010003], nil];
        //查询全部  － objc＝nil
        sql = @"select * from tbl_black_list;";
        NSArray *queryArr = [[DBInterface shareDBInterface] queryDataWithSql:sql obj:nil];
        NSLog(@"%@",queryArr);
        
        //查询 where  － objc
        sql = @"select * from tbl_black_list where UserId=?;";
        queryArr = [[DBInterface shareDBInterface] queryDataWithSql:sql obj:tmp];
        NSLog(@"%@",queryArr);
        
        //查询 where － objc＝nil
        sql = @"select * from tbl_black_list where UserId=100010003;";
        queryArr = [[DBInterface shareDBInterface] queryDataWithSql:sql obj:nil];
        NSLog(@"%@",queryArr);
        
        //数据是否存在
        if ([[DBInterface shareDBInterface] dataIsExsit:@"tbl_black_list" where:@"UserId=?" obj:tmp])
        {
            //删除是否存在
            sql = @"delete from tbl_black_list where UserId=?;";
            [[DBInterface shareDBInterface] deleteDataWithSql:sql obj:tmp];
            [DBInterface showAllTblData];
            
            //obj == nil
            if ([[DBInterface shareDBInterface] dataIsExsit:@"tbl_black_list" where:@"UserId=100010002" obj:nil])
            {
                sql = @"delete from tbl_black_list where UserId=100010002;";
                [[DBInterface shareDBInterface] deleteDataWithSql:sql obj:nil];
                [DBInterface showAllTblData];
            }
            
            
            
            //清空表
            [[DBInterface shareDBInterface] clearTableWithName:@"tbl_black_list"];
            [DBInterface showAllTblData];
        }
        
        
        
        //清空表
        [[DBInterface shareDBInterface] clearTableWithName:@"tbl_black_list"];
        [DBInterface showAllTblData];
        
        
        //删除表
        if ([[DBInterface shareDBInterface] isTableExists:@"tbl_black_list"]) {
            [[DBInterface shareDBInterface] deleteTableWithName:@"tbl_black_list"];
        }
        
        if ([[DBInterface shareDBInterface] isTableExists:@"tbl_black_list"]) {
        }else{
            NSLog(@"tbl_black_list 不存在");
        }
    }
    
}
@end
