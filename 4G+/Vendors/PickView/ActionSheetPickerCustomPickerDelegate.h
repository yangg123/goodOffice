//
//  ActionSheetPickerCustomPickerDelegate.h
//  ActionSheetPicker
//
//  Created by  on 13/03/2012.
//  Copyright (c) 2012 Club 15CC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionSheetPicker.h"
#import "TSLocation.h"


@protocol CustomPickerDelegate <NSObject>

@required
/** 代理回调方法 */
- (void)theCitySelect:(NSInteger)pIndex andCity:(NSInteger)cIndex andOriginArr:(NSArray *)originArr;

@end


@interface ActionSheetPickerCustomPickerDelegate : NSObject <ActionSheetCustomPickerDelegate>
{
    NSArray *_provinces;
    NSArray	*_cities;
}

//@property (strong, nonatomic) TSLocation *locate;
@property (assign, nonatomic) int pIndex;
@property (assign, nonatomic) int cIndex;

@property (nonatomic, assign) id <CustomPickerDelegate> delegate;

- (id)initwithProvince:(NSString *)province andCity:(NSString *)city isRegisterType:(BOOL)isRegisterVC;
@end
