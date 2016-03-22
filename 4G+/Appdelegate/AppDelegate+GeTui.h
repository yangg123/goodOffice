//
//  AppDelegate+GeTui.h
//  4G
//
//  Created by yg on 16/2/26.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "AppDelegate.h"
#import "GeTuiSdk.h"

#define kGtAppId           @"DMLxWJEadH8hRIagoq8ia2"
#define kGtAppKey          @"WceVVN3FYY5GgvjLCTfCQ8"
#define kGtAppSecret       @"zVBBcFZNSeAUuHEbOAujK"

@interface AppDelegate (GeTui)<GeTuiSdkDelegate>

- (void)easemobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end
