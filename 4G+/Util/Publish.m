//
//  Publish.m
//  全局工具类
//
//  Created by yangg on 15-1-6.
//  Copyright (c) 2015年 西米网络科技. All rights reserved.
//

#import "Publish.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "NSString+TKUtilities.h"
#import <CoreLocation/CoreLocation.h>
#import "TKAddressBook.h"
#import "NSString+MD5.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "NSString+md5.h"
#import "AppDelegate.h"
//#import "SCNetworkMonitor.h"

@implementation Publish

/**
 *	@brief	获取Publish的单例
 *
 *	@return	Publish
 */
+ (Publish *)sharePublish
{
    static Publish *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[[self alloc] init];
    });
    return _instance;
}

/**
 *	@brief	判断是否是第一次登录
 *	@return	BOOL
 */
- (BOOL)isFirstLaunch
{
    NSString *firstLaunchStr = [APP_DEFAULT objectForKey:@"firstLaunchStatus"];
    if ([firstLaunchStr isEqualToString:IS_NOT_FIRST_LAUNCH]) {
        return NO;
    }
    return YES;
}

/**
 *	@brief	设置是否第一次登录
 *	@param 	isFirstLaunch 	是否是第一次登录
 */
- (void)setFirstLaunchStatus:(BOOL)isFirstLaunch
{
    if (isFirstLaunch) {
        [APP_DEFAULT setObject:IS_FIRST_LAUNCH forKey:@"firstLaunchStatus"];
    } else {
        [APP_DEFAULT setObject:IS_NOT_FIRST_LAUNCH forKey:@"firstLaunchStatus"];
    }
    [APP_DEFAULT synchronize];//  这边加个立即写入磁盘
}


/**
 *	@brief	判断是否自动登录
 *	@return	BOOL
 */
- (BOOL)isAutoLogin
{
    NSString *firstLaunchStr = [APP_DEFAULT objectForKey:@"autoLoginStatus"];
    if ([firstLaunchStr isEqualToString:IS_AUTO_LOGIN]) {
        return YES;
    }
    return NO;
}

/**
 *	@brief	设置是否自动登录
 *	@param 	isAotoLogin 	自动登录
 */
- (void)setAutoLogin:(BOOL)isAotoLogin
{
    if (isAotoLogin) {
        [APP_DEFAULT setObject:IS_AUTO_LOGIN forKey:@"autoLoginStatus"];
    } else {
        [APP_DEFAULT setObject:IS_NOT_AUTO_LOGIN forKey:@"autoLoginStatus"];
    }
    [APP_DEFAULT synchronize];//  这边加个立即写入磁盘
}



//  功能描述: 用于获取手机上的全部联系人
+ (NSArray *)getAllContacts
{
    if ([Publish sharePublish].allContactsArr == nil) {
        /************************* 下面都是通讯录来源 ***********************/
        
        NSMutableArray *allContactsArr = [NSMutableArray array];
        
        ABAddressBookRef addressBooks = nil;
        __block BOOL accessGranted = NO;
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
            addressBooks = ABAddressBookCreateWithOptions(NULL, NULL);
            //获取通讯录权限
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){
                accessGranted = granted;
                dispatch_semaphore_signal(sema);
                
            });
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        } else {
            accessGranted = YES;
            
            addressBooks = ABAddressBookCreate();
        }
        
        if (accessGranted) {
            NSLog(@"已经有获取通讯录权限!");
            NSLog(@"we got the access right");
            
        } else {
            NSLog(@"没有获取通讯录权限!");
            [YGAlertView showAlertWithMessage:@"您当前通讯录权限已关闭，\n打开我会给您推荐更多人哦.."
                              completionBlock:^(NSUInteger buttonIndex) {
                                  if (buttonIndex == 1) {
                                      
                                  }
                              } cancelButtonTitle:@"关闭"
                          completeButtonTitle:@"打开"];
        }
        
        if (addressBooks == nil) {
            return nil;
        };
        
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
        CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
        
        for (NSInteger i = 0; i < nPeople; i++)
        {
            TKAddressBook *addressBook = [[TKAddressBook alloc] init];
            
            addressBook.recordID = [NSNumber numberWithInteger:i];
            ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
            NSString *nameString = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
            NSString *lastNameString = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
            NSString *abFullName = (__bridge NSString *)ABRecordCopyCompositeName(person);
            
            
            if (NSStringIsValid(abFullName)) {
                nameString = abFullName;
            } else {
                if (NSStringIsValid (lastNameString)) {
                    nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
                }
            }
            
            if(!NSStringIsValid(nameString))
                continue;
            addressBook.name = nameString;
            
            //取电话号码
            ABPropertyID multiProperties[] = {
                kABPersonPhoneProperty,
            };
            
            NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
            
            for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
                ABPropertyID property = multiProperties[j];
                ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
                NSInteger valuesCount = 0;
                if (valuesRef != nil)
                    valuesCount = ABMultiValueGetCount(valuesRef);
                
                if (valuesCount == 0) {
                    CFRelease(valuesRef);
                    continue;
                }
                
                NSMutableArray *phonesArr = [NSMutableArray array];
                for (NSInteger k = 0; k < valuesCount; k++) {
                    NSString *value = (__bridge NSString*)ABMultiValueCopyValueAtIndex(valuesRef, k);
                    switch (j) {
                        case 0: {// Phone number
                            [phonesArr addObject:value];
                        }
                    }
                }
                addressBook.telPhones = [phonesArr copy];
                CFRelease(valuesRef);
            }
            
            if(!NSArrayIsValid(addressBook.telPhones))
                continue;
            
            [allContactsArr addObject:addressBook];
        }
        
        CFRelease(allPeople);
        [Publish sharePublish].allContactsArr = [allContactsArr copy];
    }
    return [Publish sharePublish].allContactsArr;
}


//获得按索引分组排序后的联系人列表
+ (NSArray *)getAllSortedContactsFromSource:(NSArray *)originArr
{
    if ([Publish sharePublish].allSortedContactsArr == nil) {
        //通讯录里面的全部人员
        NSMutableArray *allContactsArr = [NSMutableArray array];
        allContactsArr = [NSMutableArray arrayWithArray:originArr];
        /*=========================================================*/
        // Sort data,这个用来找到某个联系人在通讯录里面的大下标sectionId（A,B,C,D...）
        UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];
        for (TKAddressBook *addressBook in allContactsArr) {
            NSInteger sect = [theCollation sectionForObject:addressBook
                                    collationStringSelector:@selector(name)];
            addressBook.sectionNumber = sect;
        }
        
        NSInteger highSection = [[theCollation sectionTitles] count];
        NSMutableArray *sectionArrays = [NSMutableArray array];
        for (int i = 0; i<highSection; i++) {
            NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
            [sectionArrays addObject:sectionArray];
        }
        
        for (TKAddressBook *addressBook in allContactsArr) {
            [(NSMutableArray *)[sectionArrays objectAtIndex:addressBook.sectionNumber] addObject:addressBook];
        }
        
        NSMutableArray *allcontacts = [NSMutableArray array];
        for (NSMutableArray *sectionArray in sectionArrays) {
            NSArray *sortedSection = [theCollation sortedArrayFromArray:sectionArray collationStringSelector:@selector(name)];
            [allcontacts addObject:sortedSection];
        }
        
        [Publish sharePublish].allSortedContactsArr = [allcontacts copy];
    }
    return [Publish sharePublish].allSortedContactsArr;
}

//根据目标号码找到该号码的所有人
+ (TKAddressBook *)getContactFromCallNum:(NSString *)callNum
{
    NSArray *allConatcts = [Publish getAllContacts];
    for (int i = 0; i < allConatcts.count; i++) {
        TKAddressBook *contact = allConatcts[i];
        for (NSString *telPhone in contact.telPhones) {
            if (EqualString(telPhone, callNum) ) {
                return contact;
            }
        }
    }
    return nil;
}

#pragma mark - 验证手机号
BOOL isNumber (char ch)
{
    if (!(ch >= '0' && ch <= '9')) {
        return FALSE;
    }
    return TRUE;
}

/**
 *	@brief	判断是否是有效的电话号码
 *  @param  mobileNum 电话号码
 *	@return	BOOL
 */

+ (BOOL)isValidNumber:(NSString*)value{
    const char *cvalue = [value UTF8String];
    int len = strlen(cvalue);
    for (int i = 0; i < len; i++) {
        if(!isNumber(cvalue[i])){
            return FALSE;
        }
    }
    return TRUE;
}

+ (BOOL) isValidPhone:(NSString*)value {
    
    if (value.length != 11) {  //不是11位数
        return FALSE;
    }
    
    const char *cvalue = [value UTF8String];
    int len = strlen(cvalue);
    if (len != 11) {
        return FALSE;
    }
    if (![Publish isValidNumber:value])
    {
        return FALSE;
    }
    NSString *preString = [[NSString stringWithFormat:@"%@",value] substringToIndex:1];
    if ([preString isEqualToString:@"1"])
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
    return TRUE;
}

//是否是纯数字
+ (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

//判断输入的是否为整形数字：
+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}



//身份证号
+ (BOOL)validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}


/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


+ (PJConfigModel *)getPJConfigData{
    
    static PJConfigModel *pJConfigData = nil;
    
    if (pJConfigData == nil) {
        pJConfigData = [PJConfigModel alloc];
    }
    return pJConfigData;
}


//url 编码
+ (NSString*)urlEncodedString:(NSString *)string
{
    NSString * encodedString = (__bridge_transfer  NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );
    
    return encodedString;
}


/**
 *  floar转nsstring
 *
 *  @param price    需要处理的数字
 *  @param position 保留小数点第几位
 *  @param NSRoundDown 代表的就是 只舍不入。
 *  @return <#return value description#>
 */
+ (NSString *)notRounding:(float)price afterPoint:(int)position{
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                                      scale:position
                                                                                           raiseOnExactness:NO
                                                                                            raiseOnOverflow:NO
                                                                                           raiseOnUnderflow:NO
                                                                                        raiseOnDivideByZero:NO];
    
    NSDecimalNumber *ouncesDecimal;
    
    NSDecimalNumber *roundedOunces;
    
    
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
    
}


//对象转json格式
+ (NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

/**
 *	@brief  设置右边按钮 item
 *
 *	@param 	title 按钮文字
 *	@param 	target 响应对象
 *  @param 	action 响应函数
 */
+ (UIBarButtonItem *)setRightBarItemWithTitle:(NSString *)title
                                     andColor:(ItemTitleColor)color
                                    addTarget:(id)target
                                       action:(SEL)action {
    
    return [[UIBarButtonItem alloc] initWithCustomView:[Publish setRightButtonWithTitle:title
                                                                               andColor:color
                                                                              addTarget:target
                                                                                 action:action]];
}

/**
 *	@brief  设置右边按钮 button
 *
 *	@param 	title 按钮文字
 *	@param 	target 响应对象
 *  @param 	action 响应函数
 */
+ (UIButton *)setRightButtonWithTitle:(NSString *)title
                             andColor:(ItemTitleColor)color
                            addTarget:(id)target
                               action:(SEL)action {
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.backgroundColor = [UIColor clearColor];
    
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:FONT(17)];
    
    if (title.length == 2) {
        [rightBtn setFrame:CGRectMake(0, 0, 38, 44)];
        [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -15)];
    } else if (title.length == 3) {
        [rightBtn setFrame:CGRectMake(0, 0, 30, 44)];
        [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
    } else {
        [rightBtn setFrame:CGRectMake(0, 0, 70, 44)];
        [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
    }
    
    if (color == GreenColor) {
        [rightBtn setTitleColor:[UIColor colorFromHexRGB:@"00d6be"]
                       forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor colorFromHexRGB:@"00d6be" andAlpha:0.6]
                       forState:UIControlStateHighlighted];
        
    } else {
        [rightBtn setTitleColor:[UIColor colorFromHexRGB:@"f0f2f5"]
                       forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor colorFromHexRGB:@"f0f2f5" andAlpha:0.6]
                       forState:UIControlStateHighlighted];
    }
    
    [rightBtn addTarget:target
                 action:action
       forControlEvents:UIControlEventTouchUpInside];
    
    return rightBtn;
}



#pragma mark - 检查网络设置

+ (BOOL)checkNetUsable
{
    SCNetWorkStatus *networkStatus = [SCNetworkMonitor sharedInstance].netStatus;
    if (networkStatus.nStatus != 0) {//已连接
        return YES;
    } else {
        [YKToast showWithText:@"😂网络好像有点问题"];
    }
    return NO;
}


+ (NSString *)combinePhonesFromArr:(NSArray *)originArr
{
    if (originArr.count == 1) {
        return originArr[0];
    } else {
        NSString *tempStr = originArr[0];
        for (int index = 1;index < originArr.count;index ++) {
            NSString *object = originArr[index];
            tempStr = [NSString stringWithFormat:@"%@,%@",tempStr,object];
        }
        return tempStr;
    }
}

// 设置经纬度
+ (void)setLat:(NSString *)lat andLng:(NSString *)lng
{
    [APP_DEFAULT setObject:lat forKey:LAT];
    [APP_DEFAULT setObject:lng forKey:LNG];
    [APP_DEFAULT synchronize];//  这边加个立即写入磁盘
}


@end

