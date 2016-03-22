//
//  AgentFinderVC.m
//  GoodOffice
//  委托找楼- 控制器
//  Created by yg on 16/3/15.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "AgentFinderVC.h"
#import "AgentFinderCell.h"
#import "IQTextView.h"

#import "ActionSheetPickerCustomPickerDelegate.h"
#import "ActionSheetStringPicker.h"

@interface AgentFinderVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_titleArr;
    NSArray *_areaArr;        //区域数组
    NSArray *_commercialArr;  //商圈
    NSArray *_squareArr;      //面积
    NSArray *_moneyArr;       //租金
    NSArray *_showArr;        //展示总的数组
}
@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic,weak) IBOutlet UIView *footView;
@property (nonatomic,weak) IBOutlet IQTextView *noteTv;
@property (nonatomic,weak) IBOutlet UITextField *phoneTf;
@property (nonatomic,weak) IBOutlet UIButton *commitBtn;
@end

@implementation AgentFinderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"委托找楼";
    
    _titleArr = @[@"区域",@"商圈",@"面积",@"租金"];
    _areaArr = @[@"仓山区",@"台江区",@"马尾区",@"鼓楼区"];
    _commercialArr = @[@"仓山万达",@"仓山师大",@"仓山对湖"];
    _squareArr = @[@"100-200平",@"200-300平",@"300-500平",@"500-1000平",@"1000以上"];
    _moneyArr = @[@"1000-3000",@"3000-5000",@"5000-1w",@"1-2w",@"2-3w",@"3w以上"];
    
    _showArr = @[_areaArr,_commercialArr,_squareArr,_moneyArr];
    
    self.noteTv.placeholder = @"其他需求备注";
    self.noteTv.scrollEnabled = YES;
    self.noteTv.font = FONT(14);
    self.tableView.tableFooterView = self.footView;
    self.commitBtn.layer.cornerRadius = 4;
    [self.navigationItem setRightBarButtonItemWithTitle:@"委托记录"
                                               andColor:WhiteColor
                                              addTarget:self
                                                 action:@selector(jumpToList)];
}

- (void)jumpToList
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *rankIndentifier = @"AgentFinderCell";
    AgentFinderCell *cell = (AgentFinderCell*)[tableView dequeueReusableCellWithIdentifier:rankIndentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AgentFinderCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLb.text = _titleArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AgentFinderCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.isOpen) {
        cell.arrowImgv.image = [UIImage imageNamed:@"arrow_down_gray"];
        cell.isOpen = NO;
    } else {
        cell.arrowImgv.image = [UIImage imageNamed:@"arrow_up_gray"];
        cell.isOpen = YES;
    }
    
    [ActionSheetStringPicker showPickerWithTitle:[NSString stringWithFormat:@"请选择%@",_titleArr[indexPath.row]]
                                            rows:_showArr[indexPath.row]
                                initialSelection:0
                                          target:self
                                   successAction:@selector(rowSelected:element:)
                                    cancelAction:@selector(actionPickerCancelled:) origin:cell];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //表格线顶格
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)rowSelected:(NSNumber *)selectedIndex element:(id)element {
    
    UITableViewCell *cell = element;
//    _selectIndex = [selectedIndex intValue];
}

- (void)actionPickerCancelled:(id)sender {
    NSLog(@"Delegate has been informed that ActionSheetPicker was cancelled");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
