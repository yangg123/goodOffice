//
//  TMCMainMenu.h
//  SmartCampus
//
//  Created by jinzhongliu on 14-8-1.
//  Copyright (c) 2014年 cgf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMCMainMenu : NSObject

@property (nonatomic, copy)NSString* strTitle;
@property (nonatomic, copy)NSString* strClassName;
@property (nonatomic, copy)NSString* strNorImageName;
@property (nonatomic, copy)NSString* strSelImageName;
@property (nonatomic, assign)BOOL bNav;
@property (nonatomic, copy)NSString* strNibName;


@end
