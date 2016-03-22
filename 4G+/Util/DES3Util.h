//
//  DES3Util.h
//  Yeke
//
//  Created by yangg on 15-5-14.
//  Copyright (c) 2015年 西米网络科技. All rights reserved.
//

//3DES加密程序，源代码如下 http://www.iteye.com/topic/1127949

#import <Foundation/Foundation.h>

@interface DES3Util : NSObject

// 加密方法
+ (NSString*)encrypt:(NSString*)plainText;

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText;

@end
