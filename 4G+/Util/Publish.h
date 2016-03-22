//
//  Publish.h
//  全局工具类
//
//  Created by yangg on 15-1-6.
//  Copyright (c) 2014年 simico. All rights reserved.
//
//  开发版本: v1.0
//  开发者: yangg
//  编写时间: 14-6-25
//  功能描述: 公共文件


#import <Foundation/Foundation.h>
#import "PJConfigModel.h"
#import "Enum.h"

@interface Publish : NSObject

/**
 *	@brief	获取Publish的单例
 *	@return	Publish
 */
+ (Publish *)sharePublish;

@property (nonatomic,assign) ItemState ItemState;

@property (nonatomic,assign) BOOL isLogin;
@property (nonatomic,assign) BOOL isShowUpdated;  //是否已经登录过一次,用于版本提示

@property (nonatomic,strong) NSArray *allContactsArr;        //所有联系人
@property (nonatomic,strong) NSArray *allSortedContactsArr;  //所有排序后的联系人
@property (nonatomic,strong) UIView *firstItem;             //第一个TabBar Item


+ (BOOL)isWXAppInstalled;  //是否安装了微信
+ (BOOL)isQQInstalled;     //是否安装了QQ

/**
 *	@brief	判断是否是第一次登录
 *	@return	BOOL
 */
- (BOOL)isFirstLaunch;
- (void)setFirstLaunchStatus:(BOOL)isFirstLaunch;

- (BOOL)isAutoLogin;  //是否是自动登录
- (void)setAutoLogin:(BOOL)isAotoLogin;

//  功能描述: 用于获取手机上的全部联系人号码并且拼接成字符串
//  例子: 手机号列表：tels   例：tels=1212313,31314,141431,33333
+ (NSArray *)getAllContactsTelNums;

//@brief	判断是否是有效的电话号码
+ (BOOL)isValidPhone:(NSString *)mobileNum;

+ (BOOL)isPureNumandCharacters:(NSString *)string;


//判断输入的是否为整形数字：
+ (BOOL)isPureInt:(NSString*)string;

//身份证有效性验证
+ (BOOL)validateIdentityCard:(NSString *)identityCard;


//IOS 把格式化的JSON字符串转换成字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//项目工程初始化
+ (PJConfigModel *)getPJConfigData;

//对sign进行编码(encode)
+ (NSString*)urlEncodedString:(NSString *)string;

//floar转nsstring
+ (NSString *)notRounding:(float)price afterPoint:(int)position;


//对象转json
+ (NSString*)DataTOjsonString:(id)object;


//设置导航栏右按钮(item)
+ (UIBarButtonItem *)setRightBarItemWithTitle:(NSString *)title
                                     andColor:(ItemTitleColor)color
                                    addTarget:(id)target
                                       action:(SEL)action;
//设置导航栏右按钮(buttom)
+ (UIButton *)setRightButtonWithTitle:(NSString *)title
                                     andColor:(ItemTitleColor)color
                                    addTarget:(id)target
                                       action:(SEL)action;

//检查网络状态
+ (BOOL)checkNetUsable;


+ (NSArray *)getAllContacts;

+ (NSArray *)getAllSortedContactsFromSource:(NSArray *)originArr;

//根据目标号码找到该号码的所有人
+ (TKAddressBook *)getContactFromCallNum:(NSString *)callNum;


+ (void)getAllContactsFromIOS9:(void (^)(NSArray *))completion;

+ (NSString *)combinePhonesFromArr:(NSArray *)originArr;


+ (void)setLat:(NSString *)lat andLng:(NSString *)lng;

@end

