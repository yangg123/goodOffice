//
//  AreaViewController.h
//  Yeke
//
//  Created by yangg on 15-1-18.
//  Copyright (c) 2015年 西米网络科技. All rights reserved.
//

#import "BaseViewController.h"

@protocol ReloadAreaDelegate <NSObject>

@required

- (void)changeCityWith:(NSString *)text;

@end

@interface AreaViewController : BaseViewController

@property (nonatomic,assign) id target;
@property (nonatomic,assign) SEL action;

@property (nonatomic,weak) id<ReloadAreaDelegate> delegate;

@end
