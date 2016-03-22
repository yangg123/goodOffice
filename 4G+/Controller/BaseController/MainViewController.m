//
//  MainViewController.m
//  GoodOffice
//  tabbar容器视图控制器
//  Created by yg on 16/3/2.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "MainViewController.h"

#import "TMCMainMenu.h"
#import "UIColor+ColorTranstion.h"
#import "BaseNavigationController.h"

#import "RecordDBHandle.h"
#import "RecordModel.h"

#import "HomePageVC.h"
#import "ClusterDemoViewController.h"
#import "AgentViewController.h"
#import "MineViewController.h"

@interface MainViewController ()<UITabBarControllerDelegate,UITabBarDelegate>

@property (strong, nonatomic) NSDate *lastPlaySoundDate;

@end

@implementation MainViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTheTabBar];
}


- (void)initTheTabBar
{
    TMCMainMenu *menu1 = [[TMCMainMenu alloc] init];
    menu1.strTitle = @"首页";
    menu1.strClassName = @"HomePageVC";
    menu1.strSelImageName= @"tab_down_on";
    menu1.strNorImageName = @"tab_down";
    menu1.bNav = YES;
    
    TMCMainMenu *menu2 = [[TMCMainMenu alloc] init];
    menu2.strTitle = @"地图找楼";
    menu2.strClassName = @"ClusterDemoViewController";
    menu2.strSelImageName= @"tab_address_on";
    menu2.strNorImageName = @"tab_address";
    menu2.bNav = YES;

    TMCMainMenu *menu3 = [[TMCMainMenu alloc] init];
    menu3.strTitle = @"委托投放";
    menu3.strClassName = @"AgentViewController";
    menu3.strSelImageName= @"tab_commercial_on";
    menu3.strNorImageName = @"tab_commercial";
    menu3.bNav = YES;
    
    TMCMainMenu *menu4 = [[TMCMainMenu alloc] init];
    menu4.strTitle = @"我的好办";
    menu4.strClassName = @"MineViewController";
    menu4.strSelImageName = @"tab_mine_on";
    menu4.strNorImageName = @"tab_mine";
    menu4.bNav = YES;
    
    NSArray *arrMenu = @[menu1,menu2,menu3,menu4];

    NSMutableArray *arrNav = [[NSMutableArray alloc] initWithCapacity:0];
    for (TMCMainMenu *itemMenu in arrMenu) {
        
        UIViewController *viewController = [[NSClassFromString(itemMenu.strClassName) alloc] initWithNibName:itemMenu.strClassName bundle:nil];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:itemMenu.strTitle
                                                           image:[UIImage imageNamed:itemMenu.strNorImageName]
                                                   selectedImage:[UIImage imageNamed:itemMenu.strSelImageName]];
        
        viewController.tabBarItem = item;
        
        BaseNavigationController *nav = nil;
        if (itemMenu.bNav){
            nav = [[BaseNavigationController alloc] initWithRootViewController:viewController];
            [arrNav addObject:nav];
        } else{
            [arrNav addObject:viewController];
        }
    }
    
    self.viewControllers = arrNav;
    
    self.tabBar.tintColor = [UIColor colorFromHexRGB:@"00bf8f"];
    //tabBar选中之后字体颜色的改变
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorFromHexRGB:@"00bf8f"],NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    //tabBar正常状态字体颜色的改变
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorFromHexRGB:@"6a7684"],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 49)];
    backView.backgroundColor = [UIColor colorFromHexRGB:@"fbfcfc"];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
}

#pragma end mark
- (void)dealloc
{
    NSLog(@"VesselViewController--dealloc");
}
/**
 *	@brief	didReceiveMemoryWarning
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
