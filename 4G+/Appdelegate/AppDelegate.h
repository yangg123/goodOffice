//
//  AppDelegate.h
//  GoodOffice
//
//  Created by yg on 16/1/21.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

@class MainViewController;
@class LoginViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate,BMKGeneralDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *mainController;
@property (strong, nonatomic) LoginViewController *loginViewController;

@property (nonatomic, strong) BMKMapManager *mapManager;
@property (nonatomic, strong) BMKLocationService *locService;

- (void)startUpdate;  //更新地理位置
- (void)enterMainViewController;
- (void)enterLoginViewController;
@end

