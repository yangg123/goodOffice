//
//  SCNetworkMonitor.m
//  网络状态监听
//
//  Created by jinzhongliu on 14-8-6.
//  Copyright (c) 2014年 cgf. All rights reserved.
//

#import "SCNetworkMonitor.h"
#import "Reachability.h"

static NSString* const kSCNetwrokMonitorNotification = @"SCNetwrokMonitorNotification";

static NSString* const kSCDefaultRemoteServer = @"www.baidu.com";

@implementation SCNetWorkStatus


@end


@interface SCNetworkMonitor ()

@property(nonatomic, strong)Reachability* reachability;
@property(nonatomic, assign)BOOL bInit;
@end

@implementation SCNetworkMonitor


+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (id)init{
    self = [super init];
    if (nil != self){
        _serverAddress = [kSCDefaultRemoteServer copy];
        _netStatus = [[SCNetWorkStatus alloc] init];
        [self initReachability];
    }
    return self;
}

- (void)initReachability
{
    if (!self.bInit){
        
        if (_serverAddress != nil){
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
            //self.reachability = [Reachability reachabilityWithHostName:_serverAddress];
            //self.reachability = [Reachability reachabilityForLocalWiFi];//本地wifi
            self.reachability = [Reachability reachabilityForInternetConnection];//网络
            [self.reachability startNotifier];
            [self updateInterfaceWithReachability:self.reachability];
            self.bInit = YES;
        }
    }
}

- (void)uninitReachability{
    
    if (self.bInit){
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self.reachability stopNotifier];
        self.bInit = NO;
    }
}

- (void) reachabilityChanged:(NSNotification *)note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
	[self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    if (reachability == self.reachability){
        
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        BOOL connectionRequired = [reachability connectionRequired];
        
        _netStatus.nStatus = netStatus;
        _netStatus.bConnectionRequired = connectionRequired;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kSCNetwrokMonitorNotification object:_netStatus];
    }
}


- (void)addReachabilityObserver:(id)observer selector:(SEL)aSelector{
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:kSCNetwrokMonitorNotification object:nil];
}

- (void)removeReachabilityObserver:(id)observer{
    [[NSNotificationCenter defaultCenter] removeObserver:observer];
}

/**
 *  更新时，先取消原来的监听，再设置新的监听
 *
 *  @param serverAddress 监听服务器的域名
 */
- (void)setServerAddress:(NSString *)serverAddress{
    //
    if (_serverAddress != serverAddress){
        
        [self uninitReachability];
        _serverAddress = [serverAddress copy];
        [self initReachability];
    }
    
}


@end
