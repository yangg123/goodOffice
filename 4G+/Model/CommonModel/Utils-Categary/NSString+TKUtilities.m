//
//  NSString+TKUtilities.m
//  TKContactsMultiPicker
//
//  Created by Jongtae Ahn on 12. 8. 31..
//  Copyright (c) 2012년 TABKO Inc. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "NSString+TKUtilities.h"

@implementation NSString (TKUtilities)

- (BOOL)containsString:(NSString *)aString
{
	NSRange range = [[self lowercaseString] rangeOfString:[aString lowercaseString]];
	return range.location != NSNotFound;
}


- (id)telephoneWithReformat  //电话号码格式化(固话或者手机号)
{
    NSString *result = self;

    NSCharacterSet *setToRemove = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] //去掉其他字符
                                   invertedSet];
    result = [[result componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];

    return result;
}

@end
