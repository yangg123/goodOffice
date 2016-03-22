//
//  AppMacro.h
//  Yeke
//
//  Created by yg on 15/9/21.
//  Copyright © 2015年 西米网络科技. All rights reserved.
//
//AppMacro.h 里放app相关的宏定义

// ====================== 颜色设置 =====================//

#define MJPhotoTag     10000   //MJphoto Tag

#define LAT                @"lat"     //经度
#define LNG                @"lng"    //纬度
#define LAT_VALUE [APP_DEFAULT objectForKey:LAT]
#define LNG_VALUE [APP_DEFAULT objectForKey:LNG]

#define IS_FIRST_LAUNCH     @"isFirstLaunch"
#define IS_NOT_FIRST_LAUNCH  @"isNoFirstLaunch"

#define IS_AUTO_LOGIN     @"isAutoLogin"
#define IS_NOT_AUTO_LOGIN  @"isNotAutoLogin"


#define OutOfDate           @"过期"

//======================== 消息未读数======================== //

#define GeTuiCID            @"cid"              //个推cid
#define Device_CID          [APP_DEFAULT objectForKey:GeTuiCID]
/* ****************************************************************************************************************** */

#pragma mark - Constants (宏 常量)

/** 时间间隔 */
#define kHUDDuration            (1.f)

/** 一天的秒数 */
#define SecondsOfDay            (24.f * 60.f * 60.f)
/** 秒数 */
#define Seconds(Days)           (24.f * 60.f * 60.f * (Days))

/** 一天的毫秒数 */
#define MillisecondsOfDay       (24.f * 60.f * 60.f * 1000.f)
/** 毫秒数 */
#define Milliseconds(Days)      (24.f * 60.f * 60.f * 1000.f * (Days))

//========================== 系统控件默认高度 ======================================/

 #define kStatusBarHeight        (20.f)
 
 #define kTopBarHeight           (44.f)
 #define kBottomBarHeight        (49.f)
 
 #define kCellDefaultHeight      (44.f)
 
 #define kEnglishKeyboardHeight  (216.f)
 #define kChineseKeyboardHeight  (252.f)




