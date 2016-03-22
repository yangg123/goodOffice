//
//  MainViewController.h
//  TKContactsMultiPicker
//
//  Created by Jongtae Ahn on 12. 8. 31..
//  Copyright (c) 2012년 TABKO Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKAddressBook : NSObject

@property NSInteger sectionNumber;
@property (nonatomic, strong) NSNumber *recordID;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *telPhones;  //一个人对应多个号码

@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) UIImage  *thumbnail; //预留图片或者头像字段
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *profession;
@property (nonatomic, strong) NSString *note;
@property (nonatomic, assign) BOOL isSelect;

//商机
@property (nonatomic, assign) BOOL isFollow;
@property (nonatomic, strong) NSString *companyName;

@property (nonatomic, strong) NSString *type;      //联系人来源类型  0:原手机通讯录  1:手动添加 2:商机

- (id)copyWithZone:(NSZone *)zone;

@end