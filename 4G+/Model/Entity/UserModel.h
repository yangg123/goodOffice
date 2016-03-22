//
//  UserInfo.h
//  SmartCampus
//
//  Created by yangg on 14-12-23.
//  Copyright (c) 2014年 cgf. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface UserModel : NSObject

//@property (nonatomic, assign)   BOOL isFirstLogin;        //是否是第一次登陆

@property (nonatomic, copy)     NSString *mobile;           //手机号码
@property (nonatomic, copy)     NSString *pwd;              //密码

@property (nonatomic, strong)   NSString *lat;
@property (nonatomic, strong)   NSString *lng;
@property (nonatomic, copy)     NSString *userId;

@property (nonatomic, copy)     NSString *gender;           //性别
@property (nonatomic, assign)   NSInteger age;              //年龄
@property (nonatomic, copy)     NSString *birthDay;         //生日
@property (nonatomic, copy)     NSString *education;

@property (nonatomic, copy)     NSString *constellation;    //星座
@property (nonatomic, copy)     NSString *nickName;         //别名


@property (nonatomic, copy)     NSString *province;         //省份
@property (nonatomic, copy)     NSString *city;             //城市

@property (nonatomic, copy)     NSString *curCityId;
@property (nonatomic, copy)     NSString *curProvinceId;

@property (nonatomic, copy)     NSArray *tags;             //个性标签

@property (nonatomic, copy)     NSString *avatar;           //头像
@property (nonatomic, assign)   BOOL vip;                   //vip
@property (nonatomic, copy)     NSString *height;           //身高
@property (nonatomic, copy)     NSString *weight;           //体重


@property (nonatomic, assign)   long long updateTime;       //地理位置更新时间
@property (nonatomic, assign)   long long headUpdateTime;   //头像更新时间,第一次默认为地理位置更新时间

@property (nonatomic, copy)     NSArray *photosArr;         //图片完整地址
@property (nonatomic, copy)     NSArray *tokensArr;         //图片key
@property (nonatomic, assign)   BOOL isNeedUpdateAvatar;    //是否需要更新自己的头像


@property (nonatomic, copy)     NSString *createTime;       //创建时间
@property (nonatomic, strong)   NSArray *barsList;          //经理所属酒吧  （仅当用户为酒吧经理的时候有用）
@property (nonatomic, strong)   NSString *shopName;         //所属酒吧名字
@property (nonatomic, assign)   long long shopId;                //所属酒吧ID
@property (nonatomic, strong)   NSString *shopType;         //夜店类型(普通酒吧或者夜总会)
@property (nonatomic, assign)   NSInteger storeId;          //酒水小铺Id;
@property (nonatomic, copy)     NSString *isStore;          //是否开了店铺 (-1:未开店 0:审核中 1:审核通过 2:审核失败)
@property (nonatomic, assign)   BOOL isManager;             //是否是经理



@property (nonatomic, assign)   BOOL binedZhifubao;         //绑定支付宝
@property (nonatomic, assign)   BOOL binedWeixin;           //绑定微信

@property (nonatomic, strong)   NSString *zhifubaoAccount;  //支付宝帐号
@property (nonatomic, strong)   NSString *weixinAccount;    //微信钱包帐号


@property (nonatomic, assign)   BOOL isSetPwd;              //是否设置了夜客宝支付密码
@property (nonatomic, strong)   NSString *accountMoney;     //夜客宝余额
@property (nonatomic, strong)   NSArray *accountArr;        //所有的支付帐号信息
@property (nonatomic, strong)   NSData *headData;

@end


@interface NSDictionary (UserModel)
/**
 *	@brief	获取用户信息
 */
- (UserModel *)userInformate;

@end

