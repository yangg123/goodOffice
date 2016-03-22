//
//  RoomDetailVC.m
//  GoodOffice
//
//  Created by yg on 16/3/4.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "RoomDetailVC.h"
#import "BannerView.h"
#import "TagsView.h"
#import "RentTableViewCell.h"
#import "GeocodeDemoViewController.h"

@interface RoomDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _pageIndex;
    NSInteger _pageSize;
    NSInteger _count; //总个数
    NSInteger _tempCount; //临时用的
    
    NSMutableArray *_rentRommArr;
}
@property (nonatomic,weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic,strong) BannerView *bannerView;
@property (nonatomic,strong) UILabel *nameLb;
@property (nonatomic,strong) UILabel *noteLb;
@property (nonatomic,strong) UILabel *priceLb;
@property (nonatomic,strong) UIView *line1;

@property (nonatomic,strong) UIView *roomInfoView;
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,weak) IBOutlet UIView *locationView;
@property (nonatomic,weak) IBOutlet UILabel *locationLb;

@property (nonatomic,weak) IBOutlet UIView *btnBgView;
@property (nonatomic,weak) IBOutlet UIButton *infoBtn;
@property (nonatomic,weak) IBOutlet UIButton *rentableRoomBtn;

@property (nonatomic,weak) IBOutlet UIView *businessView;   //商圈
@property (nonatomic,weak) IBOutlet UIView *trafficView;    //交通
@property (nonatomic,weak) IBOutlet UIView *supportingView; //配套
@property (nonatomic,weak) IBOutlet UIView *introduingView; //介绍
@property (nonatomic,weak) IBOutlet UILabel *noInfoView;    //暂无该楼的描述
@property (nonatomic,weak) IBOutlet UIButton *seeMoreBtn;   //查看更多

@property (nonatomic,strong) UITableView *usableRoomTable;
@property (nonatomic,strong) UIButton *footBtn;

@end

@implementation RoomDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pageIndex = 1;
    _pageSize = 0;
    _count = 42;
    _tempCount = 4;
    
    _rentRommArr = [NSMutableArray arrayWithCapacity:3];
    self.bannerView = [[BannerView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 150)];
    [self.scrollView addSubview:self.bannerView];
    
    [self.scrollView addSubview:self.nameLb];
    [self.scrollView addSubview:self.noteLb];
    [self.scrollView addSubview:self.priceLb];
    [self.scrollView addSubview:self.line1];
    
    self.locationView.top = self.line1.bottom;
    self.btnBgView.top = self.locationView.bottom;
    
    [self.scrollView addSubview:self.locationView];
    [self.scrollView addSubview:self.btnBgView];
    
    self.roomInfoView.top = self.btnBgView.bottom;
    self.tableView.top = self.btnBgView.bottom;
    
    [self.scrollView addSubview:self.roomInfoView];
    [self.scrollView addSubview:self.tableView];
    
    self.scrollView.contentSize = CGSizeMake(Main_Screen_Width, self.roomInfoView.bottom);
    NSLog(@"size is %@",NSStringFromCGSize(self.scrollView.contentSize));
    NSArray *tags = @[@"5A写字楼",@"地铁周边",@"名企开发商"];
    TagsView *tagsView = [[TagsView alloc] initWithOriginTagArr:tags
                                                    andMaxWidth:Main_Screen_Width
                                                        andOriginX:10
                                                     andOriginY:40];
    [self.businessView addSubview:tagsView];
    
    UITapGestureRecognizer *imgvTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(locateShopSite:)];
    [self.locationView addGestureRecognizer:imgvTap];
}

- (UILabel *)nameLb
{
    if (_nameLb == nil) {
        _nameLb = [[UILabel alloc] initWithFrame:CGRectMake(15, self.bannerView.bottom, Main_Screen_Width-15, 30)];
        _nameLb.font = FONT(14);
        _nameLb.text = @"万达广场";
    }
    return _nameLb;
}


- (UILabel *)noteLb
{
    if (_noteLb == nil) {
        _noteLb = [[UILabel alloc] initWithFrame:CGRectMake(15, self.nameLb.bottom, Main_Screen_Width-15, 30)];
        _noteLb.text = @"仓山地区地标建筑，科技智能化办公体验";
        _noteLb.font = FONT(12);
    }
    return _noteLb;
}

- (UILabel *)priceLb
{
    if (_priceLb == nil) {
        _priceLb = [[UILabel alloc] initWithFrame:CGRectMake(15, self.noteLb.bottom, Main_Screen_Width-15, 25)];
        _priceLb.text = @"7.2 元/天/平米";
        _priceLb.font = FONT(13);
    }
    return _priceLb;
}

- (UIView *)line1
{
    if (_line1 == nil) {
        _line1 = [[UIView alloc] initWithFrame:CGRectMake(0, _priceLb.bottom + 5, Main_Screen_Width, 0.5)];
        _line1.backgroundColor = [UIColor redColor];
    }
    return _line1;
}

- (UIView *)roomInfoView
{
    if (_roomInfoView == nil) {
        _roomInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
        
        self.trafficView.top = self.businessView.bottom;
        self.supportingView.top = self.trafficView.bottom;
        self.introduingView.top = self.supportingView.bottom;
        
        [_roomInfoView addSubview:self.businessView];
        [_roomInfoView addSubview:self.trafficView];
        [_roomInfoView addSubview:self.supportingView];
        [_roomInfoView addSubview:self.introduingView];
        _roomInfoView.height = self.introduingView.bottom;
    }
    return _roomInfoView;
}

//地图
- (void)locateShopSite:(id)sender
{
    GeocodeDemoViewController *controller = [[GeocodeDemoViewController alloc] initWithNibName:@"GeocodeDemoViewController" bundle:nil];
    controller.lng = @"119.28";
    controller.lat = @"26.08";
    controller.address = @"福州市经纬度";
    controller.title = @"测试";
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)btnClick:(UIButton *)sender
{
    if ([sender tag] == 10) {
        self.roomInfoView.hidden = NO;
        self.tableView.hidden = YES;
        self.scrollView.contentSize = CGSizeMake(Main_Screen_Width, self.roomInfoView.bottom);
    } else {
        self.roomInfoView.hidden = YES;
        self.tableView.hidden = NO;
        self.scrollView.contentSize = CGSizeMake(Main_Screen_Width, self.tableView.bottom);
    }
}

- (void)moreRoomClick
{
    _tempCount += 10;
    
    if (_tempCount < _count) {
        NSString * showContent = [NSString stringWithFormat:@"查看剩余%ld套房源",_count - _tempCount];
        [self.footBtn setTitle:showContent forState:UIControlStateNormal];
    } else {
        self.tableView.tableFooterView = nil;
    }
    
    [self.tableView reloadData];
}

- (IBAction)callClick:(id)sender
{
    NSMutableString * phoneNum = [[NSMutableString alloc] initWithFormat:@"tel:%@",@"15080476625"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneNum]]];
    [self.view addSubview:callWebview];
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 108*_tempCount)];
        if (_tempCount < _count) {
            _tableView.height += 30;
        }
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.hidden = YES;
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30)];
        [bgView addSubview:self.footBtn];
        _tableView.tableFooterView = bgView;
    }
    return _tableView;
}

- (UIButton *)footBtn
{
    if (_footBtn == nil) {
        _footBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, 0, Main_Screen_Width - 160, 30)];
        _footBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_footBtn setBackgroundImage:[UIImage imageNamed:@"lookhousetrip_btn"] forState:UIControlStateNormal];
        [_footBtn.titleLabel setFont:FONT(15)];
        [_footBtn setTitle:@"查看剩余42套房源" forState:UIControlStateNormal];
        [_footBtn addTarget:self action:@selector(moreRoomClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footBtn;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tempCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *rankIndentifier = @"RentTableViewCell";
    RentTableViewCell *cell = (RentTableViewCell*)[tableView dequeueReusableCellWithIdentifier:rankIndentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RentTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
