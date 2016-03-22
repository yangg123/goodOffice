//
//  BaseViewController.m
//  Yeke
//
//  Created by cgf yangg on 14-6-26.
//  Copyright (c) 2014年 cgf. All rights reserved.
//  功能描述: 工程的controller基类
//  修改记录:(仅记录功能修改)

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark --生命周期方法
/**
 *	@brief	initWithNibName
 *
 *	@param 	nibNameOrNil 	nibNameOrNil
 *	@param 	nibBundleOrNil 	nibBundleOrNil
 *
 *	@return	BaseViewController
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


/**
 *	@brief	viewDidLoad
 */
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorFromHexRGB:@"f1f4f7"];
    if (SYSTEM_VERSION >= 7.0) {
        //使视图不会穿过navigationBar
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        //为其子类scrollView自动留白，默认就是YES，如果子类scrollView超过一个，则务必将此属性重写为NO
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    
}

//默认导航栏
- (void)showNavigationBar
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    UIImage *image = [UIImage imageNamed:@"navigationbar_background"];
    UIImage *navBarBackgroundImg=[image resizableImageWithCapInsets:UIEdgeInsetsMake(1.0f, 1.0f, 1.0f, 1.0f)
                                                       resizingMode:UIImageResizingModeStretch];
    [navigationBar setBackgroundImage:navBarBackgroundImg forBarMetrics:UIBarMetricsDefault];
}

//全透明的导航栏
- (void)showNavTransparent
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIImage *image = [UIImage imageNamed:@"bg_clear"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
}

- (void)popViewControllerCustomAnimated
{
    UIView *animateView = self.view;
    CGRect frame = animateView.frame;
    frame.origin.y +=20;
    animateView.frame = frame;
    [[UIApplication sharedApplication].keyWindow addSubview:animateView];
    [self.navigationController popViewControllerAnimated:NO];
    [UIView animateWithDuration:0.35 animations:^{
        animateView.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width, 0);
    } completion:^(BOOL finished) {
        [animateView removeFromSuperview];
    }];
}

- (void)pushViewControllerCustomAnimated:(UIViewController *)viewController
{
    UIView *animateView = nil;
    animateView = viewController.view;
    [[UIApplication sharedApplication].keyWindow addSubview:animateView];
    animateView.transform = CGAffineTransformMakeTranslation(animateView.frame.size.width, 0);
    [UIView animateWithDuration:0.35 animations:^{
        animateView.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        [animateView removeFromSuperview];
        [self.navigationController pushViewController:viewController animated:NO];
    }];
}

- (void)displayBadge{
    
}

#pragma end mark

@end
