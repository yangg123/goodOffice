//
//  DBInterface.h
//  GoodOffice
//  数据库接口
//  Created by cgf yangg on 16-1-31.
//  Copyright (c) 2016年 cgf. All rights reserved.


#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface DBInterface : NSObject
{
    FMDatabase *_localDB;
}


/**
 *	@brief	获取DBInterface单例
 *
 *	@return	DBInterface
 */
+(DBInterface *) shareDBInterface;

/**
 *	@brief	获取Database
 *
 *	@return	FMDatabase
 */
- (FMDatabase *)getDatabase;

/**
 *	@brief	根据sql语句创建表
 *
 *	@param 	createSql 	对应sql语句
 *
 *	@return	BOOL
 */
-(BOOL) createTable:(NSString *)createSql;





/**
 *	@brief	判断是否存在字段
 *
 *	@param 	columnName 	字段名
 *	@param 	tableName 	表名
 *
 *	@return	bool
 */
- (BOOL)columnExists:(NSString *)columnName WithTableName:(NSString *)tableName;

/**
 *	@brief	关闭Database
 */
- (void)closeDatabase;


/**
 *	@brief	添加字段
 *
 *	@param 	sql 	sql语句
 *	@return	bool
 */
- (BOOL)alterAddField:(NSString *)sql;


/**
 *	@brief	根据表名清空表
 *
 *	@param 	tblName 	表名
 *
 *	@return	BOOL
 */
-(BOOL) clearTableWithName:(NSString *)tblName;

/**
 *	@brief	根据表名删除表
 *
 *	@param 	tblName 	表名
 *
 *	@return	BOOL
 */
-(BOOL) deleteTableWithName:(NSString *)tblName;

/**
 *	@brief	根据表名判断表是否存在
 *
 *	@param 	tblName 	表名
 *
 *	@return	BOOL
 */
- (BOOL)isTableExists:(NSString *)tblName;

/**
 *	@brief	根据参数判断数据是否存在
 *
 *	@param 	tblName 	表名
 *	@param 	whereSql 	where的sql语句
 *	@param 	objArr 	参数array
 *
 *	@return	BOOL
 */
- (BOOL)dataIsExsit:(NSString *)tblName where:(NSString *)whereSql obj:(NSArray *)objArr;

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
- (BOOL)insertDataWithSql:(NSString *)sqlStr obj:(NSArray *)objArr;

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
- (BOOL)deleteDataWithSql:(NSString *)sqlStr obj:(NSArray *)objArr;

/**
 *	@brief	查询数据
 *
 *	@param 	sqlStr 	sql语句
 *	@param 	objArr 	参数array
 *
 *	@return	NSArray
 */
- (NSArray *)queryDataWithSql:(NSString *)sqlStr  obj:(NSArray *)objArr;

/**
 *  @brief  testDbInterface 测试DbInterface各个接口
 */
+ (void)testDbInterface;

@end
