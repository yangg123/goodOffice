//
//  YGAlertView.m
//  4G
//
//  Created by yg on 16/2/17.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "YGAlertView.h"

#define ViewHeight 382/2

#define LeftMargin 47/2  //弹框距离Mainwindow 的左右间距
#define InnerEdge 20  //按钮距离父视图的左右间距
#define ButtonWidth  (Main_Screen_Width - LeftMargin * 2 - InnerEdge * 2 - 18)/2  //18是两按钮中间间距

#define WINDOW_ARRAY [[UIApplication sharedApplication] windows]

@implementation YGAlertView

+ (void)showAlertWithMessage:(NSString *)message
             completionBlock:(CompletionBlock)block
           cancelButtonTitle:(NSString *)cancelButtonTitle
         completeButtonTitle:(NSString *)completeButtonTitle
{
    UIWindow *keyWindow = (UIWindow *)WINDOW_ARRAY[0];
    
    YGAlertView *view = [[YGAlertView alloc] initWithFrame:MainScreen_Frame
                                                   message:message
                                                  andBlock:block
                                         cancelButtonTitle:cancelButtonTitle
                                       completeButtonTitle:completeButtonTitle];
    view.alpha = 0;
    [keyWindow addSubview:view];
    
    //添加动画
    [UIView animateWithDuration:0.2 animations:^{
        view.alpha = 1;
        UIView *bgView = [view viewWithTag:1001];
        [view showAlertAnmation:bgView withOpen:YES];
    } completion:^(BOOL finished) {
        
    }];
}

- (id)initWithFrame:(CGRect)frame
            message:(NSString *)message
           andBlock:(CompletionBlock)block
  cancelButtonTitle:(NSString *)cancelButtonTitle
completeButtonTitle:(NSString *)completeButtonTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        self.block = block;
        
        //半透明背景
        UIView *backgroundView = [[UIView alloc] initWithFrame:frame];
        backgroundView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backGroundClick)];
        backgroundView.alpha = 0.5;
        [backgroundView addGestureRecognizer:tap];
        [self addSubview:backgroundView];
        
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin,
                                                           (Main_Screen_Height - ViewHeight)/2+(76/2)/2,
                                                           Main_Screen_Width - LeftMargin * 2,
                                                           ViewHeight)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.cornerRadius = 5;
        bgView.tag = 1001;
        [self addSubview:bgView];
        
        
        UIImageView *topIconImgv = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.width-76)/2, -79/2, 76, 76)];
        topIconImgv.image = [UIImage imageNamed:@"alertIcon"];
        [bgView addSubview:topIconImgv];
        
        UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(20, 76/2, bgView.width-40,bgView.height-76-76/2)];
        titleLb.font = [UIFont systemFontOfSize:18.5];
        titleLb.text = message;
        titleLb.numberOfLines = 0;
        titleLb.textAlignment = NSTextAlignmentLeft;
        titleLb.backgroundColor = [UIColor clearColor];
        titleLb.textColor = [UIColor colorFromHexRGB:@"4a4a4a"];
        [bgView addSubview:titleLb];
        
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.backgroundColor = [UIColor clearColor];
        [cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorFromHexRGB:@"00bf8f"] forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorFromHexRGB:@"00bf8f" andAlpha:0.6] forState:UIControlStateHighlighted];
        cancelBtn.frame = CGRectMake(InnerEdge, bgView.height-75, ButtonWidth, 95/2);
        [cancelBtn addTarget:self action:@selector(compelteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:cancelBtn];
        cancelBtn.tag = 0;
        ViewBorderRadius(cancelBtn, 5, 1, [UIColor colorFromHexRGB:@"00bf8f"]);
        
        
        UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        completeBtn.tag = 1;
        completeBtn.backgroundColor = [UIColor colorFromHexRGB:@"00bf8f"];
        [completeBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [completeBtn setTitleColor:[UIColor colorFromHexRGB:@"ffffff"] forState:UIControlStateNormal];
        [completeBtn setTitleColor:[UIColor colorFromHexRGB:@"ffffff" andAlpha:0.6] forState:UIControlStateHighlighted];
        completeBtn.frame = CGRectMake(cancelBtn.right + 18, bgView.height-75, ButtonWidth, 95/2);
        [completeBtn addTarget:self action:@selector(compelteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:completeBtn];
        ViewRadius(completeBtn, 5);
    }
    return self;
}

#pragma mark - Events Action
- (void)backGroundClick
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        UIView *bgView = [self viewWithTag:1001];
        bgView.alpha = 0;
        [self showAlertAnmation:bgView withOpen:NO];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)compelteBtnClick:(UIButton *)sender
{
    [self backGroundClick];
    if (self.block ) {
        self.block(sender.tag);
    }
}

- (void)showAlertAnmation:(UIView *)view withOpen:(BOOL)open
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.20;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    
    if (open) {
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3, 0.3, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    } else {
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3, 0.3, 1.0)]];
    }

    animation.values = values;
    [view.layer addAnimation:animation forKey:nil];
}

@end
