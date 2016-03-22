//
//  UtilsMacro.h
//  Yeke
//  放的是一些方便使用的宏定义,如颜色RGB(一些第三方应用常量，如百度、友盟、环信)
//  Created by yg on 15/9/21.
//  Copyright © 2015年 西米网络科技. All rights reserved.
//

#define gPjType             [Publish getPJConfigData].mProjectType
#define gVersion            [Publish getPJConfigData].mVersion
#define DEFAULT_URL         [Publish getPJConfigData].mServiceURL
#define TrendURL            [Publish getPJConfigData].mTrendURL
#define QiNiuDownLoadUrl    [Publish getPJConfigData].mQiNiuURL //七牛图片地址前缀  正式环境
#define ShortUrl_Head       [Publish getPJConfigData].mShortUrlHead
#define BaiduKey            [Publish getPJConfigData].mBaiduKey
#define AppKey              [Publish getPJConfigData].mBundleId


#define IOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)

#define Application_Frame       [[UIScreen mainScreen] applicationFrame]
#define App_Frame_Height        [[UIScreen mainScreen] applicationFrame].size.height
#define App_Frame_Width         [[UIScreen mainScreen] applicationFrame].size.width


#define MainScreen_Frame        [[UIScreen mainScreen] bounds]
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

#define APP_DEFAULT     [NSUserDefaults standardUserDefaults]       //系统比别
//#define USER_SETTING    [[Publish sharePublish] getUserSettingDic] //用户级别,跟帐号关联

#define RGB(R,G,B)      [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:1.0f]

// 字体大小(常规/粗体/指定字体)
#define FONT(CGFloat)   [UIFont systemFontOfSize:CGFloat]
#define FONT_BOLD(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define FONT_NAME(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]


//当前 iOS版本
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define EqualString(string1,string2) ([string1 isEqualToString:string2])

//@brief	判断对象是否为空，一般用于数据返回判断某字段是否为空
#define CheckNull(value) (value != nil && (NSNull *)value != [NSNull null] && ![value isEqualToString:@"(null)"])

//nsarray + nsstring  + nsdictionary是否非法的判断
#define NSArrayIsValid(array) ((array) && ![(array) isEqual:[NSNull null]] && (array).count)
#define NSStringIsValid(string) ((string) && ![(string) isEqual:[NSNull null]] && (string).length)
#define NSDictionaryIsValid(dictionary) ((dictionary) && ![(dictionary) isEqual:[NSNull null]] && (dictionary).count)

//字符串格式化
#define STRINGFORMAT(val)  (val == nil || [val isKindOfClass:[NSNull class]]) ? @"" : [NSString stringWithFormat:@"%@", val];

#define AutoLogin  [[APP_DEFAULT objectForKey:@"autoLogin"] boolValue]
#define FirstLogin [[APP_DEFAULT objectForKey:@"firstLogin"] boolValue]

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

/**
 *	@brief	当前屏幕差
 *
 *	@return	NSInteger
 */
#define SCREEN_HEIGHT_OFFSET ((Main_Screen_Height==568)?(88):(0))


/**
 *	@brief	当前系统版本的上端起点
 *
 *	@return	NSInteger
 */
#define FRAME_ORIGIN_Y ((IOS7)?(64):(0))

/**
 *	@brief	当前系统版本的导航栏高度
 *
 *	@return	NSInteger
 */
#define NAV_HEIGHT ((IOS7)?(64):(44))


/**
 *	@brief	输出调用它的类和方法名称
 */
#define MARK CMLog(@"%s", __PRETTY_FUNCTION__);

/**
 *	@brief	将调用它的类和方法的名称一起输出到控制台
 */
#define CMLog(format, ...) NSLog(@"%s:%@", __PRETTY_FUNCTION__,[NSString stringWithFormat:format, ## __VA_ARGS__]);