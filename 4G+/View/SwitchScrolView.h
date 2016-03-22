//
//  SwitchScrolView.h
//  SmartCampus
//
//  Created by LianJR on 14-7-2.
//  Copyright (c) 2014年 cgf. All rights reserved.
//
//  开发版本: v1.0
//  开发者: LJR
//  编写时间: 14-7-02
//  功能描述: 首页图片切换scrollview
//  修改记录:(仅记录功能修改)
//        LJR  14-7-02  启动开发
//

#import <UIKit/UIKit.h>


@protocol SwitchScrolDelegate;

@interface SwitchScrolView : UIScrollView

//代理
@property (assign, nonatomic) id<SwitchScrolDelegate> switchDelegate;

//需要传入的图片URL数组
@property (retain, nonatomic) NSArray *imgUrlArr;


//启动图片，传image
@property (retain, nonatomic) NSArray *LaungchImgArr;


@property (nonatomic,strong) NSMutableArray *imageArr;

@end



@protocol SwitchScrolDelegate <NSObject>
@optional

- (void)bannerAction:(NSInteger)tag;


@end