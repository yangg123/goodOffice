//
//  AppDelegate.m
//  GoodOffice
//
//  Created by yg on 16/1/21.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+GeTui.h"
#import "AppDelegate+UMeng.h"

#import "MainViewController.h"
#import "IQKeyboardManager.h"
#import "LoginViewController.h"
#import "AutoLoginViewController.h"
#import "LoginService.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self appConfigInfoInitAction];
    
    // 环信UIdemo中有用到友盟统计crash
    [self setupUMeng];
    
    // 初始化个推SDK，详细内容在AppDelegate+GeTui.m 文件中
    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    manager.shouldResignOnTouchOutside = YES; //控制点击背景是否收起键盘。
    
    //登录状态改变
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNOT_LOGINCHANGE
                                               object:nil];
    
    [self.window makeKeyAndVisible];
    [self loginStateChange:nil];
    [self initBaiduSdkInit];
    return YES;
}


#pragma mark - 程序配置信息初始化
- (void)appConfigInfoInitAction
{
    NSString *homePath = [[NSBundle mainBundle] bundlePath];
    NSString *libraryPath = [homePath stringByAppendingPathComponent:@"/config.plist"];
    NSDictionary * dicConfigFile = [NSDictionary dictionaryWithContentsOfFile:libraryPath];
    NSString * pjType  = [dicConfigFile objectForKey:@"ProjectType"];
    
    PJConfigModel *pJConfigData = [Publish getPJConfigData];
    pJConfigData.mProjectType = [pjType integerValue] ;//工程点
    NSInteger pjTypeNum = [pjType integerValue];     //0(测试环境)
    NSArray *arrConfig = [dicConfigFile objectForKey:@"ProjectData"];
    NSDictionary * dicPjConfig  = [arrConfig objectAtIndex:pjTypeNum];
    
    //获取其他数据
    pJConfigData.mServiceURL = [dicPjConfig objectForKey:@"gServiceURL"];
    pJConfigData.mVersion = [dicPjConfig objectForKey:@"gVersion"];
    pJConfigData.mTrendURL = [dicPjConfig objectForKey:@"gTrendURL"];
    pJConfigData.mQiNiuURL = [dicPjConfig objectForKey:@"gQiNiuURL"];
    pJConfigData.mShortUrlHead = [dicPjConfig objectForKey:@"gShortUrl_Head"];
    pJConfigData.mBundleId = [dicPjConfig objectForKey:@"gBundleId"];
    pJConfigData.mBaiduKey = [dicPjConfig objectForKey:@"gBaiduKey"];
    
    //检查网络设置
    [Publish checkNetUsable];
    //当网络状态改变的时候触发
    [[SCNetworkMonitor sharedInstance] addReachabilityObserver:self selector:@selector(networkStatusChangeAction:)];
}

- (void)networkStatusChangeAction:(NSNotification *)notification
{
    [Publish checkNetUsable];
}

#pragma mark - 退出登录配置还原
- (void)resetAppInit
{
    [DataCenter setLastLoginAccount:@""];
    [DataCenter setLastLoginAccountPwd:@""];
    [Publish sharePublish].allContactsArr = nil;
    [Publish sharePublish].allSortedContactsArr = nil;
}

#pragma mark - 百度地图初始化
- (void)initBaiduSdkInit
{
    NSLog(@"BaiduKey is %@",BaiduKey);
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:BaiduKey generalDelegate:self];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    } else {
        
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
        [self startUpdate];
    }
}


- (void)startUpdate {
    
    [_locService startUserLocationService];
}


//实现相关delegate 处理位置信息更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"============定位获取的经纬度如下 lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_locService stopUserLocationService];
    
    NSString *_lng = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    NSString *_lat = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    
    //定位不到的时候用默认的福州地区(福建省福州市仓山区金榕北路1号)经纬度
    if ([_lng integerValue] <= 0 || [_lat integerValue] <= 0) {
        
        NSLog(@"不上传到服务器！！！");
        
    } else {
        
        DataCenterManager.lat = _lat;
        DataCenterManager.lng = _lng;
    }
    
#if TARGET_IPHONE_SIMULATOR
    DataCenterManager.lat = @"26.0896";
    DataCenterManager.lng = @"119.291";
#endif
    
    //定位回来更新缓存的经纬度
    [Publish setLat:DataCenterManager.lat andLng:DataCenterManager.lng];
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"用户没有开启定位功能,从缓存读取.");
    
#if TARGET_IPHONE_SIMULATOR
    DataCenterManager.lat = @"26.0896";
    DataCenterManager.lng = @"119.291";
#else
    NSLog(@"LAT_VALUE is %@",LAT_VALUE);
    if (LAT_VALUE == nil || LNG_VALUE == nil) {
        DataCenterManager.lat = @"0";
        DataCenterManager.lng = @"0";
    } else {
        DataCenterManager.lat = LAT_VALUE;
        DataCenterManager.lng = LNG_VALUE;
    }
#endif
}

#pragma mark - 登录成功通知(private)

- (void)loginStateChange:(NSNotification *)notification
{
    BOOL isAutoLogin = [Publish sharePublish].isAutoLogin;
    BOOL loginSuccess = [notification.object boolValue];
    
    if (isAutoLogin) {
        
        //获取最后一次登录成功的账号，并给accountTextField赋值
        NSString *lastLoginAccount = [DataCenter getLastLoginAccount];
        NSString *lastLoginPwd = [DataCenter getLastLoginAccountPwd];
        
        AutoLoginViewController *vc = [[AutoLoginViewController alloc] init];
        self.window.rootViewController = vc;
        
        [MBProgressHUD showHUDAddedTo:vc.view animated:YES];
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate enterMainViewController];
        
//        [LoginService loginWithUserAccountStr:lastLoginAccount
//                           andUserPasswordStr:lastLoginPwd
//                              andSuccessBlock:^(id data) {
//                                  
//                                  [MBProgressHUD hideHUDForView:vc.view animated:YES];
//                                  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//                                  AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//                                  [delegate enterMainViewController];
//                                  [Publish getAllContacts];
//                                  
//                              } andFailedBlock:^(NSString *error) {
//                                  [MBProgressHUD hideHUDForView:vc.view animated:YES];
//                                  [YKToast showWithText:error];
//                                  [DataCenter setLastLoginAccount:@""];
//                                  [DataCenter setLastLoginAccountPwd:@""];
//                                  [[Publish sharePublish] setAutoLogin:NO];
//                              }];
    
    } else if (loginSuccess) {//登陆成功加载主窗口控制器
        
        [[Publish sharePublish] setAutoLogin:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate enterMainViewController];
        [Publish getAllContacts];
        
    } else {//登陆失败加载登陆页面控制器
        _mainController = nil;
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate resetAppInit];
        [delegate enterLoginViewController];
    }
}

- (void)enterMainViewController{
    if(!_mainController)
        _mainController = [[MainViewController alloc] init];
    self.window.rootViewController = _mainController;
}

- (void)enterLoginViewController {
    
    if (_loginViewController == nil) {
        _loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    }
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:_loginViewController];
    nav.delegate = self;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
