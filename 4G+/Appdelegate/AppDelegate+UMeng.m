//
//  AppDelegate+UMeng.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 1/6/15.
//  Copyright (c) 2015 dujiepeng. All rights reserved.
//

#import "AppDelegate+UMeng.h"
#import "MobClick.h"

@implementation AppDelegate (UMeng)

//友盟
- (void)setupUMeng{

    
    NSInteger projectType = gPjType;
    
    if(projectType == 0) {
        
        //============================  正式环境（企业版） ============================================//
        
        [MobClick startWithAppkey:@"554c33ca67e58e9489003ac8"
                     reportPolicy:BATCH
                        channelId:@"test"];
#if DEBUG
        [MobClick setLogEnabled:YES];
#else
        [MobClick setLogEnabled:NO];
#endif

    } else if (projectType == 1) {  //正式环境（appstore 版）
        
        [MobClick startWithAppkey:@"566590c067e58e10df0024f2"
                     reportPolicy:BATCH
                        channelId:@"test"];
#if DEBUG
        [MobClick setLogEnabled:YES];
#else
        [MobClick setLogEnabled:NO];
#endif
        
    } else {  //测试环境（企业版）
        
        [MobClick startWithAppkey:@"55c06cb3e0f55a4d3f000d50"
                     reportPolicy:BATCH
                        channelId:@"test"];
#if DEBUG
        [MobClick setLogEnabled:YES];
#else
        [MobClick setLogEnabled:NO];
#endif
    }
}

//566590c067e58e10df0024f2

@end
