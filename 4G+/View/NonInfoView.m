//
//  NonInfoView.m
//  Yeke
//
//  Created by yangg on 15/6/30.
//  Copyright (c) 2015年 西米网络科技. All rights reserved.
//
//  开发版本: v1.0
//  开发者: yangg
//  编写时间: 14-7-02
//  功能描述: 显示暂无任何内容的视图

#import "NonInfoView.h"
#import "UIView+Layout.h"

@implementation NonInfoView

- (id)initWithFrame:(CGRect)frame Type:(InformType)type
{
    if (frame.size.width == 0 && frame.size.height == 0) {  //等于0 就是默认
        self = [super initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64 - 49)];
    } else {  //指定大小
        self = [super initWithFrame:frame];
    }
    
    if (self) {
        
        NSString *inforStr = @"";
        NSString *subInfo = @"";
        NSString *showImgv = @"";
        switch (type) {
            case NoResult:
                inforStr = @"太低调了 , 空空哒~";
                subInfo = @"别让这里空着呦";
                showImgv = @"noResult";
                break;
            case NetWorkError:
                inforStr = @"当前网络不给力";
                subInfo = @"请检查网络是否正常";
                showImgv = @"NetWorkError";
                break;
            case RequestError:
                inforStr = @"Sorry 访问出错";
                showImgv = @"下拉重新加载数据";
                showImgv = @"RequestError";
                break;
            case NoEqualData:
                inforStr = @"太低调了 , 空空哒~";
                subInfo = @"别让这里空着呦";
                showImgv = @"noResult";
            default:
                break;
        }
        
        self.backgroundColor = [UIColor clearColor];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, (Main_Screen_Height-64-49)/3)];
        bgView.centerY = self.centerY;
        bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:bgView];
        
        
        UIImageView *iconImgv = [[UIImageView alloc] initWithFrame:CGRectMake((Main_Screen_Width-84) / 2,
                                                                              16,
                                                                              84,
                                                                              84)];
        iconImgv.image = [UIImage imageNamed:showImgv];
        [bgView addSubview:iconImgv];
        
        
        UILabel *nonInfoLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, iconImgv.bottom + 12, Main_Screen_Width, 25)];
        nonInfoLabel.backgroundColor = [UIColor clearColor];
        nonInfoLabel.textAlignment=NSTextAlignmentCenter;
        nonInfoLabel.textColor = [UIColor colorFromHexRGB:@"cacfd5"];
        nonInfoLabel.font=[UIFont boldSystemFontOfSize:19];
        nonInfoLabel.text = inforStr;
        [bgView addSubview:nonInfoLabel];
        
        
        UILabel *sublb=[[UILabel alloc]initWithFrame:CGRectMake(0, nonInfoLabel.bottom + 3, Main_Screen_Width, 18)];
        sublb.backgroundColor = [UIColor clearColor];
        sublb.textAlignment=NSTextAlignmentCenter;
        sublb.textColor = [UIColor colorFromHexRGB:@"cacfd5"];
        sublb.font=[UIFont boldSystemFontOfSize:12];
        sublb.text = subInfo;
        [bgView addSubview:sublb];
    }
    return self;
}

@end
