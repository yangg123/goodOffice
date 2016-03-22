//
//  MyOrderVC.m
//  GoodOffice
//
//  Created by yg on 16/3/21.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "MyOrderVC.h"
#import "MyOrderTableViewCell.h"

@interface MyOrderVC ()
@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation MyOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的预约";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *rankIndentifier = @"MyOrderTableViewCell";
    MyOrderTableViewCell *cell = (MyOrderTableViewCell*)[tableView dequeueReusableCellWithIdentifier:rankIndentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyOrderTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
