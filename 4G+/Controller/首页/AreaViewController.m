//
//  AreaViewController.m
//  Yeke
//
//  Created by yangg on 15-1-18.
//  Copyright (c) 2015年 西米网络科技. All rights reserved.
//

#import "AreaViewController.h"
#import "ChineseString.h"
#import "pinyin.h"
#import "AreaService.h"
#import "DataCenter.h"
#import "AreaData.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AreaViewController ()<CLLocationManagerDelegate>
{
    AreaData *_defaultArea;
    NSString *_lng;
    NSString *_lat;
    BOOL _locataOut;//是否定位出城市
}
@property (nonatomic,retain)NSMutableArray *dataArr;  //源数组
@property (nonatomic,retain)NSMutableArray *sortedArrForArrays;//目标数组 。按字母分类排序好的
@property (nonatomic,retain)NSMutableArray *sectionHeadsKeys;  //关键字（索引）
@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation AreaViewController

- (void)viewWillAppear:(BOOL)animated{
    
    //打开程序启动定位
    [self openLocationMethod];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //获得数据
    self.title = @"城市列表";

    _defaultArea = [AreaData new];
    _defaultArea.areaId = 0;
    _defaultArea.seqId = 0;
    _defaultArea.areaName = @"";
    _defaultArea.lng = @"";
    _defaultArea.lat = @"";
    _locataOut = false;
    [self getCitys];
}

#pragma mark - 打开程序启动定位
- (void)openLocationMethod
{
    _locationManager = [[CLLocationManager alloc] init];
    if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)
    {
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 500.0f;
        [_locationManager startUpdatingLocation];
        NSLog(@"start gps");
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"请在系统设置中打开“定位服务”来允许“羽毛球”确定您的位置"
                                                       delegate:nil
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil];
        [alert show];
    }
}


// 地理位置发生改变时触发(ios6 以下 deprecated)
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // 获取经纬度
    NSLog(@"纬度:%f",newLocation.coordinate.latitude);
    NSLog(@"经度:%f",newLocation.coordinate.longitude);
    // 停止位置更新
    [manager stopUpdatingLocation];
}

// IOS6.0 以上的方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
    manager.delegate = nil;
    
    CLLocation *location = [locations lastObject];
    _lng = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    _lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    //注册地理位置变更的通知
    _locataOut = true;
    [self getMyDeafaultCity:_lat andLat:_lng];
}

//定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    [SVProgressHUD showErrorWithStatus:@"定位失败!"];
    //NSLog(@"%@",error);
}


#pragma mark -
#pragma mark create method

- (void)getMyDeafaultCity:(NSString *)lat andLat:(NSString *)lng {

    [SVProgressHUD show];
    [AreaService areaWithUserlat:lat
                       andUselng:lng
          andSuccessBlock:^(id data) {
              
               NSDictionary *areaDic = data;
              
//              [DataCenter sharedInstance].userInfo.city = areaDic[@"name"];
//              [DataCenter sharedInstance].userInfo.distance = areaDic[@"distance"];
//              [DataCenter sharedInstance].userInfo.cityId = areaDic[@"id"];
//              [DataCenter sharedInstance].userInfo.lat = areaDic[@"lat"];
//              [DataCenter sharedInstance].userInfo.lng = areaDic[@"lng"];
              
              _defaultArea.areaName = areaDic[@"name"];
              _defaultArea.lng = areaDic[@"lng"];
              _defaultArea.lat = areaDic[@"lat"];
              _defaultArea.areaId = [areaDic[@"id"] integerValue];
              
               [_sectionHeadsKeys insertObject:@"定" atIndex:0];
              
               NSMutableArray *areaDefault = [[NSMutableArray alloc] initWithObjects:_defaultArea.areaName, nil];
              
              [self.sortedArrForArrays insertObject:areaDefault atIndex:0];
              
              [_tableView reloadData];
              
              [SVProgressHUD dismiss];
          }
           andFailedBlock:^(NSString *error) {
                 
                 NSLog(@"错误返回提示：%@",error);
                 
                 NSLog(@"_loginRequest Failed：%@", error);
                 [SVProgressHUD dismiss];
             }];
    
}


- (void)getCitys {

    _dataArr = [[NSMutableArray alloc]init];
    _sortedArrForArrays = [[NSMutableArray alloc]init];
    _sectionHeadsKeys = [[NSMutableArray alloc]init];     //initialize a array to hold keys like

    [AreaService getAllCitysListandSuccessBlock:^(id data) {

                       NSArray *areaArray = data;

                       NSLog(@".....");
                        NSMutableArray *asAreaArray = [NSMutableArray array];
                        for (NSDictionary *areaDic in areaArray)
                        {
                            AreaData *area = [AreaData alloc];
                            area.areaId = [areaDic[@"id"] intValue];
                            area.seqId = [areaDic[@"seq"] intValue];
                            area.areaName = areaDic[@"name"];
                            area.lng = areaDic[@"lng"];
                            area.lat = areaDic[@"lat"];
                            
                            [asAreaArray addObject:area];
                        }
        
                        _dataArr = [[NSMutableArray alloc]init];
                        _sortedArrForArrays = [[NSMutableArray alloc]init];
                        _sectionHeadsKeys = [[NSMutableArray alloc]init];
                        
                        for(int i=0;i<[asAreaArray count];i++)
                        {
                            [_dataArr addObject:((AreaData *)[asAreaArray objectAtIndex:i]).areaName];
                            NSLog(@"name is %@",((AreaData *)[asAreaArray objectAtIndex:i]).areaName);
                        }
                        self.sortedArrForArrays = [self getChineseStringArr:_dataArr];
                        NSLog(@"self.sortedArrForArrays is %@",self.sortedArrForArrays);
                        [self.tableView reloadData];
        
                   }
                    andFailedBlock:^(NSString *error) {
                        
                        NSLog(@"错误返回提示：%@",error);
                    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [[self.sortedArrForArrays objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sortedArrForArrays count];
}

//为section添加标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([_sectionHeadsKeys count] == 0)
        return nil;
    
    NSString *key = [_sectionHeadsKeys objectAtIndex:section];
    if ([key isEqualToString:@"定"])
        return @"定位城市";
    return key;
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionHeadsKeys;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if(sectionTitle == nil)
    {
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 0)];
        [sectionView setBackgroundColor:[UIColor clearColor]];
        return sectionView;
    }
    else
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 315, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"Helvetica" size:15];
        label.text = sectionTitle;
        
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
        [sectionView setBackgroundColor:[UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1]];
        [sectionView addSubview:label];
        
        return sectionView;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([_sectionHeadsKeys count] == 0)
        return 0;
    return 20;
}

//创建tableView的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId =@"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: cellId];
    }
    
    //sortedArrForArrays存放cell值的动态数组,首先将数组中得值赋给一个静态数组
    if ([self.sortedArrForArrays count] > indexPath.section)
    {
        NSArray *arr = [self.sortedArrForArrays objectAtIndex:indexPath.section];
        if ([arr count] > indexPath.row)
        {
            if(indexPath.row == 0 && indexPath.section == 0 && _locataOut == YES) {
                cell.textLabel.text = NSStringIsValid(_defaultArea.areaName) ?
                                                        _defaultArea.areaName : @"定位中";
            }else {
                //之后,将数组的元素取出,赋值给数据模型
                ChineseString *str = (ChineseString *) [arr objectAtIndex:indexPath.row];
                //给cell赋给相应地值,从数据模型处获得
                cell.textLabel.text = str.string;
            }
        }
        else {
            NSLog(@"arr out of range");
        }
    }
    else
    {
        NSLog(@"sortedArrForArrays out of range");
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:YES animated:YES];
    //设置一个默认的地区
    NSString *areaStr = @"福州";
    NSArray *arr = [self.sortedArrForArrays objectAtIndex:indexPath.section];
    if ([arr count] > indexPath.row)
    {
        if(indexPath.row == 0 && indexPath.section == 0 && _locataOut == YES) {
            areaStr = NSStringIsValid(_defaultArea.areaName) ?
            _defaultArea.areaName : areaStr;
        }else {
            //之后,将数组的元素取出,赋值给数据模型
            ChineseString *str = (ChineseString *) [arr objectAtIndex:indexPath.row];
            //给cell赋给相应地值,从数据模型处获得
            areaStr = str.string;
        }
    }

    // 在页面跳转前将参数传出去
    if ([self.delegate respondsToSelector:@selector(changeCityWith:)]) {
        [self.delegate changeCityWith:areaStr];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

//固定代码,每次使用只需要将数据模型替换就好,这个方法是获取首字母,将填充给cell的值按照首字母排序
- (NSMutableArray *)getChineseStringArr:(NSMutableArray *)arrToSort
{
    //创建一个临时的变动数组
    NSMutableArray *chineseStringsArray = [NSMutableArray array];
    
    for(int i =0; i < [arrToSort count]; i++)
    {
        //创建一个临时的数据模型对象
        ChineseString *chineseString=[[ChineseString alloc]init];
        //给模型赋值
        chineseString.string=[NSString stringWithString:[arrToSort objectAtIndex:i]];
        
        if(chineseString.string==nil)
        {
            chineseString.string=@"";
        }
        
        if(![chineseString.string isEqualToString:@""])
        {
            //join(链接) the pinYin (letter字母) 链接到首字母
            NSString *pinYinResult = [NSString string];
            //按照数据模型中row的个数循环
            for(int j =0;j < chineseString.string.length; j++)
            {
                NSString *singlePinyinLetter = [[NSString stringWithFormat:@"%c",
                                                 pinyinFirstLetter([chineseString.string characterAtIndex:j])]uppercaseString];
                pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
            }
            chineseString.pinYin = pinYinResult;
        } else {
            chineseString.pinYin =@"";
        }
        [chineseStringsArray addObject:chineseString];
        
    }
    
    //sort(排序) the ChineseStringArr by pinYin(首字母)
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin"ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    
    NSMutableArray *arrayForArrays = [NSMutableArray array];
    BOOL checkValueAtIndex=NO; //flag to check
    
    NSMutableArray *TempArrForGrouping =nil;
    
    for(int index =0; index < [chineseStringsArray count]; index++)
    {
        ChineseString *chineseStr = (ChineseString *)[chineseStringsArray objectAtIndex:index];
        NSMutableString *strchar= [NSMutableString stringWithString:chineseStr.pinYin];
        NSString *sr= [strchar substringToIndex:1];
        
        //sr containing here the first character of each string  (这里包含的每个字符串的第一个字符)
        NSLog(@"%@",sr);
        
        //here I'm checking whether the character already in the selection header keys or not  (检查字符是否已经选择头键)
        if(![_sectionHeadsKeys containsObject:[sr uppercaseString]])
        {
            [_sectionHeadsKeys addObject:[sr uppercaseString]];
            TempArrForGrouping = [[NSMutableArray alloc]initWithObjects:nil];
            checkValueAtIndex = NO;
        }
        if([_sectionHeadsKeys containsObject:[sr uppercaseString]])
        {
            [TempArrForGrouping addObject:[chineseStringsArray objectAtIndex:index]];
            if(checkValueAtIndex ==NO)
            {
                [arrayForArrays addObject:TempArrForGrouping];
                checkValueAtIndex = YES;
            }
        }
    }
    
  //  [_sectionHeadsKeys insertObject:@"定" atIndex:0];
  //  NSMutableArray *areaDefault = [[NSMutableArray alloc] initWithObjects:_defaultArea.areaName, nil];
  //  [arrayForArrays insertObject:areaDefault atIndex:0];
    
    return arrayForArrays;
}

- (void)dealloc
{
    _locationManager.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
