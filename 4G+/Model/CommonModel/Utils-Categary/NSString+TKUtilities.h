//
//  NSString+TKUtilities.h
//  电话号码格式化
//
//  Created by yg
//  Copyright (c) 2014년 Tabko Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TKUtilities)

- (BOOL)containsString:(NSString *)aString;
- (id)telephoneWithReformat;

@end
