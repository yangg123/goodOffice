//
//  BaseNavigationController.m
//  SmartCampus
//
//  Created by cgf yangg on 14-6-26.
//  Copyright (c) 2014年 cgf. All rights reserved.
//
//  开发版本: v1.0
//  开发者: cgf
//  编写时间: 14-6-26
//  功能描述: 工程的navigationController基类
//  修改记录:(仅记录功能修改)


#import "BaseNavigationController.h"
#import "Publish.h"


#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]
#define TOP_VIEW  [[UIApplication sharedApplication]keyWindow].rootViewController.view

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

#pragma mark --生命周期方法

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

/**
 *@briefviewDidLoad
 */
- (void)viewDidLoad
{
    [super viewDidLoad];

    NSDictionary *tempDic = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationBar.titleTextAttributes = tempDic;
    
    //设置NavigationController背景颜色373737
    if (SYSTEM_VERSION >= 7.0) {
        self.navigationBar.barTintColor = [UIColor colorFromHexRGB:@"00bf8f"];
    } else {
        self.navigationBar.tintColor = [UIColor colorFromHexRGB:@"00bf8f"];
    }
    
    self.interactivePopGestureRecognizer.delegate = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

// override the pop method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *preVC = [self.viewControllers lastObject];
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1) {
        
        if (preVC.title != nil) {
            [viewController.navigationItem setBackButtonWithTarget:self
                                                          andColor:WhiteColor
                                                             title:preVC.title
                                                            action:@selector(sysBackClick)];
        } else {
            [viewController.navigationItem setBackButtonWithTarget:self action:@selector(sysBackClick)];
        }
    }
}

- (void)sysBackClick
{
    [self popViewControllerAnimated:YES];
}

/**
 *@briefdidReceiveMemoryWarning
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end