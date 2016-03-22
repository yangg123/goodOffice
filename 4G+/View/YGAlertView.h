//
//  YGAlertView.h
//  4G
//
//  Created by yg on 16/2/17.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YGAlertView;

typedef void(^CompletionBlock)(NSUInteger buttonIndex);

@interface YGAlertView : UIView

@property (nonatomic,strong) CompletionBlock block;

+ (void)showAlertWithMessage:(NSString *)message
             completionBlock:(CompletionBlock)block
           cancelButtonTitle:(NSString *)cancelButtonTitle
         completeButtonTitle:(NSString *)completeButtonTitle;


@end
