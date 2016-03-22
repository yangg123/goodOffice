//
//  MyCollectionVC.m
//  GoodOffice
//  我的收藏 控制器
//  Created by yg on 16/3/21.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "MyCollectionVC.h"
#import "PPiFlatSegmentedControl.h"
#import "CollectionTableViewCell.h"

@interface MyCollectionVC ()
{
    NSMutableArray *_floorArr;  //楼盘
    NSMutableArray *_sourceArr; //房源
}

@property (nonatomic,weak) IBOutlet UITableView *floorTable;
@property (nonatomic,weak) IBOutlet UITableView *sourceTable;

@property (nonatomic,strong) PPiFlatSegmentedControl *segmentedControl;

@end

@implementation MyCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    [self.view addSubview:self.segmentedControl];
}

- (PPiFlatSegmentedControl *)segmentedControl
{
    if (_segmentedControl == nil) {
        _segmentedControl = [[PPiFlatSegmentedControl alloc]
                             initWithFrame:CGRectMake((Main_Screen_Width-280)/2, 16, 280, 30)
                             items:@[@{@"text":@"楼盘"},
                                     @{@"text":@"房源"}]
                             iconPosition:IconPositionRight
                             andSelectionBlock:^(NSUInteger segmentIndex) {
                                 
                                 if (segmentIndex == 0) {
                                     self.floorTable.hidden = NO;
                                     self.sourceTable.hidden = YES;
                                 } else {
                                     self.floorTable.hidden = YES;
                                     self.sourceTable.hidden = NO;
                                 }
                             }];
    }
    
    return _segmentedControl;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (tableView == self.floorTable) {  ///小的
//        return _floorArr.count;
//    } else { //大的
//        return _sourceArr.count;
//    }
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.floorTable) {
        
        static NSString *rankIndentifier = @"CollectionTableViewCell";
        CollectionTableViewCell *cell = (CollectionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:rankIndentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        static NSString *rankIndentifier = @"CollectionTableViewCell";
        CollectionTableViewCell *cell = (CollectionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:rankIndentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
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
