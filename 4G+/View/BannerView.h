//
//  BannerView.h
//  4G
//  轮播图
//  Created by yg on 16/1/27.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwitchScrolView.h"

@interface BannerView : UIView<SwitchScrolDelegate,UIScrollViewDelegate>
{
    NSTimer *_switchTime; //主页图片切换的定时器
}
@property (nonatomic,strong) SwitchScrolView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;

@end
