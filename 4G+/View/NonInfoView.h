//
//  NonInfoView.h
//  Yeke
//
//  Created by yangg on 15/6/30.
//  Copyright (c) 2015年 西米网络科技. All rights reserved.
//
//  开发版本: v1.0
//  开发者: yangg
//  编写时间: 14-7-02
//  功能描述: 显示暂无任何内容的视图


#import <UIKit/UIKit.h>

typedef enum{
    NoResult         = 0,   //没有数据
    NetWorkError     = 1,   //网络不给力
    RequestError     = 2,   //请求服务端出错
    NoEqualData      = 3    //没有匹配的数据
} InformType;

@interface NonInfoView : UIView

- (id)initWithFrame:(CGRect)frame Type:(InformType)type;

@end
