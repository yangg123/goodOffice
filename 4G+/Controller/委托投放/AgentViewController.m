//
//  AgentViewController.m
//  GoodOffice
//
//  Created by yg on 16/3/2.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "AgentViewController.h"
#import "AgentFinderVC.h"

@interface AgentViewController ()
@property (nonatomic,weak) IBOutlet UIView *headView;
@property (nonatomic,weak) IBOutlet UIView *footView;
@property (nonatomic,weak) IBOutlet UITableView *tableView;
@end

@implementation AgentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"委托投放";
    self.headView.width = Main_Screen_Width;
    self.headView.height = (150*Main_Screen_Width)/375;
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = (indexPath.row == 0 ? @"委托找楼" : @"房东投放");
    //    cell.textLabel.textColor = [UIColor colorFromHexRGB:@"f0f2f5"];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    //    cell.imageView.image = [UIImage imageNamed:_imagesArray[indexPath.row]];
    cell.imageView.image = [UIImage imageNamed:@"person_messages"];
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AgentFinderVC *vc = [[AgentFinderVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
