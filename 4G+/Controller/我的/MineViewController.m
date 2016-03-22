//
//  MineViewController.m
//  GoodOffice
//
//  Created by yg on 16/3/2.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "ParallaxHeaderView.h"
#import "MyCollectionVC.h"
#import "MyOrderVC.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    ParallaxHeaderView *_headBackView;
}

@property (nonatomic,weak) IBOutlet UIView *headView;
@property (nonatomic,weak) IBOutlet UIButton *loginBtn;
@property (nonatomic,weak) IBOutlet UITableView *tableView;
@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showNavTransparent];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self showNavigationBar];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _headView.width = Main_Screen_Width;
    ViewBorderRadius(self.loginBtn, 7, 1, [UIColor whiteColor]);
    
    _headBackView = [ParallaxHeaderView parallaxHeaderViewWithCGSize:CGSizeMake(Main_Screen_Width, 259)];
    [_headBackView addSubview:_headView];
    _tableView.tableHeaderView = _headBackView;
    _headBackView.headerImage = [UIImage imageNamed:@"person_background"];
}

- (IBAction)loginActon:(id)sender
{
    LoginViewController *vc = [[LoginViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)jumpToCollect:(id)sender
{
    MyCollectionVC *vc = [[MyCollectionVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)jumpToMyOrder:(id)sender
{
    MyOrderVC *vc = [[MyOrderVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [(ParallaxHeaderView *)_tableView.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 2;
    } else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"我的分享";
    cell.textLabel.textColor = [UIColor colorFromHexRGB:@"f0f2f5"];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
//    cell.imageView.image = [UIImage imageNamed:_imagesArray[indexPath.row]];
    cell.imageView.image = [UIImage imageNamed:@"person_messages"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
