//
//  PJConfigModel.h
//  Yeke
//
//  Created by yangg on 15/6/11.
//  Copyright (c) 2015年 西米网络科技. All rights reserved.
//

#import <Foundation/Foundation.h>


//工程全局配置数据
@interface  PJConfigModel : NSObject

@property   (nonatomic,assign) NSInteger    mProjectType;      //工程点类型。
@property   (nonatomic,strong) NSString *   mServiceURL;       //工程服务端地址
@property   (nonatomic,strong) NSString *   mUpLoadServiceURL; //工程点上传图片地址
@property   (nonatomic,strong) NSString *   mVersion;          //工程点版本号
@property   (nonatomic,strong) NSString *   mTrendURL;         //朋友圈地址
@property   (nonatomic,strong) NSString *   mQiNiuURL;         //七牛图片下载地址
@property   (nonatomic,strong) NSString *   mShortUrlHead;     //分享段地址前缀
@property   (nonatomic,strong) NSString *   mBundleId;         //应用bundleID
@property   (nonatomic,strong) NSString *   mBaiduKey;         //百度地图

@end

