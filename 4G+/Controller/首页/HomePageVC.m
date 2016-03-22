//
//  HomePageVC.m
//  GoodOffice
//  首页控制器
//  Created by yg on 16/3/2.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "HomePageVC.h"
//#import "AreaViewController.h"
#import "DropView.h"
#import "LargeRoomCell.h"
#import "ThumbRoomCell.h"
#import "RoomDetailVC.h"

#import "UIView+MJExtension.h"
#import "MJRefresh.h"

@interface HomePageVC ()<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIButton *_teseBtn;
    IBOutlet UIButton *_regionBtn;
    IBOutlet UIButton *_priceBtn;
    IBOutlet UIButton *_squareBtn;
    
    IBOutlet UIButton *_preBtn;
    
    BOOL _isOpenFlag1;
    BOOL _isOpenFlag2;
    BOOL _isOpenFlag3;
    BOOL _isOpenFlag4;
    
    BOOL _isLargeshow; //大图展示状态
}

@property (nonatomic,strong) UIButton *areaBtn;
@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic,weak) IBOutlet UITableView *bigTableView;

@property (nonatomic,strong) NSMutableArray *dataSource1;
@property (nonatomic,strong) NSMutableArray *dataSource2;

@end

@implementation HomePageVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataSource1 = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",nil];
        _dataSource2 = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",nil];
    }
    return self;
}

- (UIButton *)areaBtn
{
    if (_areaBtn == nil) {
        _areaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _areaBtn.backgroundColor = [UIColor clearColor];
        [_areaBtn setFrame:CGRectMake(0, 0, 60, 44)];
        [_areaBtn setImage:[UIImage imageNamed:@"arrow_down_white"] forState:UIControlStateNormal];
        [_areaBtn setTitle:@"福州" forState:UIControlStateNormal];
        [_areaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_areaBtn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
        _areaBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_areaBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0.0, -47.0)];
        [_areaBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -50, 0.0, 0.0)];
        [_areaBtn addTarget:self
                     action:@selector(pushAreaViewController:)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _areaBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.areaBtn];
    [self.navigationItem setRightBarButtonItemWithNormalImage:@"nav_sytleswitch" hightlight:nil addTarget:self action:@selector(changeShowStyle)];
    [self initTableView1];
    [self initTableView2];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)initTableView1
{
    __unsafe_unretained __typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewDataWithTable:self.tableView];
    }];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData1)];
    self.tableView.mj_footer = footer;
    [self.tableView.mj_header beginRefreshing];
}

- (void)initTableView2
{
    __unsafe_unretained __typeof(self) weakSelf = self;
    self.bigTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewDataWithTable:self.bigTableView];
    }];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData2)];
    self.bigTableView.mj_footer = footer;
    [self.bigTableView.mj_header beginRefreshing];
}


- (void)pushAreaViewController:(id)sender {
    //    AreaViewController *areaVCtl = [[AreaViewController alloc] initWithNibName:@"AreaViewController" bundle:nil];
    //    areaVCtl.delegate = self;
    //    areaVCtl.target = self;
    //    areaVCtl.action = @selector(changeCityWith:);
    //    areaVCtl.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:areaVCtl animated:YES];
}

#pragma mark - 下拉刷新
- (void)loadNewDataWithTable:(UITableView *)tableView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView reloadData];
        [tableView.mj_header endRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    });
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData1
{
    for (int i = 0; i <5; i++) {
        [self.dataSource1 addObject:@"1"];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    });
}

- (void)loadMoreData2
{
    for (int i = 0; i <5; i++) {
        [self.dataSource2 addObject:@"1"];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.bigTableView reloadData];
        [self.bigTableView.mj_footer endRefreshing];
    });
}

- (void)changeShowStyle
{
    if (_isLargeshow) {
        _isLargeshow = NO;
        self.tableView.hidden = NO;
        self.bigTableView.hidden = YES;
    } else {
        _isLargeshow = YES;
        self.tableView.hidden = YES;
        self.bigTableView.hidden = NO;
    }
}

- (IBAction)filteBtnClick:(UIButton *)sender
{
    if (_preBtn != sender) {
        [DropView dismiss];
        [_preBtn setImage:[UIImage imageNamed:@"down_unfold"] forState:UIControlStateNormal];
    }
    
    _preBtn = sender;
    switch (sender.tag) {
        case 10:
        {
            if (_isOpenFlag1) {
                [sender setImage:[UIImage imageNamed:@"down_unfold"] forState:UIControlStateNormal];
                _isOpenFlag1 = NO;
                [DropView dismiss];
            } else {
                [sender setImage:[UIImage imageNamed:@"down_fold"] forState:UIControlStateNormal];
                _isOpenFlag1 = YES;
                _isOpenFlag2 = NO;
                _isOpenFlag3 = NO;
                _isOpenFlag4 = NO;
                
                [DropView showWithOriginView:sender
                                  chooseList:@[@"不限",@"创业办公",@"纳什空间",@"互联网",@"地标建筑",@"金融精英地铁周边",@"创意园区",@"名气开发商"]withType:DropTeSe
                                   aboveView:self.navigationController.view
                                    andBlock:^(NSInteger row) {
                                        [sender setTitleColor:[UIColor colorFromHexRGB:@"3F8AA4"] forState:UIControlStateNormal];
                                    } andCancelBlock:^{
                                        [sender setImage:[UIImage imageNamed:@"down_unfold"] forState:UIControlStateNormal];
                                        _isOpenFlag1 = NO;
                                    }];
            }
            
        } break;
        case 20:
        {
            if (_isOpenFlag2) {
                [sender setImage:[UIImage imageNamed:@"down_unfold"] forState:UIControlStateNormal];
                _isOpenFlag2 = NO;
                [DropView dismiss];
            } else {
                [sender setImage:[UIImage imageNamed:@"down_fold"] forState:UIControlStateNormal];
                _isOpenFlag1 = NO;
                _isOpenFlag2 = YES;
                _isOpenFlag3 = NO;
                _isOpenFlag4 = NO;
                [DropView showWithOriginView:sender
                                  chooseList:@[@"不限",@"福州",@"厦门",@"泉州",@"莆田",@"宁德",@"三明",@"南平",@"漳州"]
                                    withType:DropArea
                                   aboveView:self.navigationController.view
                                    andBlock:^(NSInteger row) {
                                        [sender setTitleColor:[UIColor colorFromHexRGB:@"3F8AA4"] forState:UIControlStateNormal];
                                    } andCancelBlock:^{
                                        [sender setImage:[UIImage imageNamed:@"down_unfold"] forState:UIControlStateNormal];
                                        _isOpenFlag2 = NO;
                                    }];
            }
            
        } break;
        case 30:
        {
            if (_isOpenFlag3) {
                [sender setImage:[UIImage imageNamed:@"down_unfold"] forState:UIControlStateNormal];
                _isOpenFlag3 = NO;
                [DropView dismiss];
            } else {
                [sender setImage:[UIImage imageNamed:@"down_fold"] forState:UIControlStateNormal];
                _isOpenFlag1 = NO;
                _isOpenFlag2 = NO;
                _isOpenFlag3 = YES;
                _isOpenFlag4 = NO;
                [DropView showWithOriginView:sender
                                  chooseList:@[@"不限",@"<1万元/月",@"1-3万元/月",@"3-5万元/月",@"5-10万元/月",@">10万元/月"]
                                    withType:DropPrice
                                   aboveView:self.navigationController.view
                                    andBlock:^(NSInteger row) {
                                        [sender setTitleColor:[UIColor colorFromHexRGB:@"3F8AA4"] forState:UIControlStateNormal];
                                    } andCancelBlock:^{
                                        [sender setImage:[UIImage imageNamed:@"down_unfold"] forState:UIControlStateNormal];
                                        _isOpenFlag3 = NO;
                                    }];;
            }
            
        } break;
        case 40:
        {
            if (_isOpenFlag4) {
                [sender setImage:[UIImage imageNamed:@"down_unfold"] forState:UIControlStateNormal];
                _isOpenFlag4 = NO;
                [DropView dismiss];
            } else {
                [sender setImage:[UIImage imageNamed:@"down_fold"] forState:UIControlStateNormal];
                _isOpenFlag1 = NO;
                _isOpenFlag2 = NO;
                _isOpenFlag3 = NO;
                _isOpenFlag4 = YES;
                [DropView showWithOriginView:sender
                                  chooseList:@[@"不限",@"<100平米",@"100-200平米",@"200-300平米",@"300-500平米",@"500-1000平米",@">1000平米"]
                                    withType:DropSquare
                                   aboveView:self.navigationController.view
                                    andBlock:^(NSInteger row) {
                                        [sender setTitleColor:[UIColor colorFromHexRGB:@"3F8AA4"] forState:UIControlStateNormal];
                                    } andCancelBlock:^{
                                        [sender setImage:[UIImage imageNamed:@"down_unfold"] forState:UIControlStateNormal];
                                        _isOpenFlag4 = NO;
                                    }];
            }
            
        } break;
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {  ///小的
        return self.dataSource1.count;
    } else { //大的
        return self.dataSource2.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.bigTableView) {
        
        static NSString *rankIndentifier = @"LargeRoomCell";
        LargeRoomCell *cell = (LargeRoomCell*)[tableView dequeueReusableCellWithIdentifier:rankIndentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LargeRoomCell" owner:self options:nil] objectAtIndex:0];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        
        static NSString *rankIndentifier = @"ThumbRoomCell";
        ThumbRoomCell *cell = (ThumbRoomCell*)[tableView dequeueReusableCellWithIdentifier:rankIndentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ThumbRoomCell" owner:self options:nil] objectAtIndex:0];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        return 95;
    } else {
        return 198;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RoomDetailVC *vc = [[RoomDetailVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
