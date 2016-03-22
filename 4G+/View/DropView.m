//
//  OrderType.m
//  Yeke
//
//  Created by yangg on 15-1-31.
//  Copyright (c) 2015年 西米网络科技. All rights reserved.
//

#import "DropView.h"
#define ViewHeight (7 * 35)
#define WINDOW_ARRAY [[UIApplication sharedApplication] windows]

static DropView *dropView = nil;

@implementation DropView

+ (DropView *)sharedView
{
    if (dropView == nil) {
        dropView = [[DropView alloc] init];//实现一个实例构造方法检查上面声明的静态实例是否为nil，如果是则新建并返回一个本类的实例
    }
    return dropView;
}

+ (void)showWithOriginView:(UIView *)originView
                chooseList:(NSArray *)listArray
                  withType:(DropType)type
                 aboveView:(UIView *)superView
                  andBlock:(CellClickBlock)block
            andCancelBlock:(CancelBlock)cancelBlock
{
    UIWindow *keyWindow = (UIWindow *)WINDOW_ARRAY[0];
    dropView = [[DropView alloc] initWithFrame:CGRectMake(0,209/2,Main_Screen_Width,Main_Screen_Height - 209/2 - 49)
                                 andChooseList:listArray
                                       andType:type
                                  andCellBlock:block
                                andCancelBlock:cancelBlock
                ];
    
    if (superView == nil) {
        [keyWindow addSubview:dropView];
    } else {
        [superView addSubview:dropView];
    }
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^() {
                         if (listArray.count < 7) {
                             dropView.tableView.height = listArray.count * 35;
                         } else {
                             dropView.tableView.height = ViewHeight;
                         }
                     } completion:^(BOOL finished) {
                     }];
    
    dropView.preType = type;
}

+ (void)dismiss
{
    [dropView removeChooseView];
}

- (id)initWithFrame:(CGRect)frame
      andChooseList:(NSArray *)listArray
            andType:(DropType)type
       andCellBlock:(CellClickBlock)block
     andCancelBlock:(CancelBlock)cancelBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _type = type;
        _cellBlock = block;
        _cancelBlock = cancelBlock;
        
        //半透明背景
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, frame.size.height)];
        backgroundView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeChooseView)];
        backgroundView.alpha = 0.3;
        [backgroundView addGestureRecognizer:tap];
        [self addSubview:backgroundView];
        
        self.listArray = listArray;
        self.subListArray = @[@"晋安区",@"台江区",@"金山区",@"鼓楼区",@"仓山区",@"马尾",@"永泰",@"新都"];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,Main_Screen_Width,0)];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.bounces = NO;
        self.tableView.showsVerticalScrollIndicator = YES;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.tableView];

        if (_type == DropArea) {
            self.subTableView = [[UITableView alloc] initWithFrame:CGRectMake(Main_Screen_Width,0,Main_Screen_Width/2,ViewHeight)];
            self.subTableView.bounces = NO;
            self.subTableView.showsVerticalScrollIndicator = NO;
            self.subTableView.delegate = self;
            self.subTableView.dataSource = self;
            self.subTableView.backgroundColor = [UIColor clearColor];
            self.subTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self addSubview:self.subTableView];
            
            if (listArray.count < 7) {
                dropView.subTableView.height = self.subListArray.count * 35;
            } else {
                dropView.subTableView.height = ViewHeight;
            }
        }
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return _listArray.count;
    } else {
        return _subListArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierCell = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    
    if (tableView == self.tableView) {
        cell.textLabel.text = _listArray[indexPath.row];
        if (_type == DropArea && indexPath.row != 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 34.5, Main_Screen_Width - 15, 0.5)];
        line.backgroundColor = [UIColor colorFromHexRGB:@"BCBAC1"];
        if (indexPath.row == _listArray.count - 1) {
            line.height = 0;
        }
        [cell.contentView addSubview:line];
        
    } else {
        cell.textLabel.text = _subListArray[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _clickedRow = indexPath.section;
    
    if (self.tableView == tableView && _type == DropArea) {
        [UIView animateWithDuration:0.15 animations:^{
            
            self.tableView.width = Main_Screen_Width/2;
            self.subTableView.left = Main_Screen_Width/2;
            
        } completion:^(BOOL finished) {
            
            [self.subTableView reloadData];
        }];
        
    } else {
        [self determineButtonAction];
    }
}

/**
 *	@brief 确定按钮 移除self，且给_chooseCompleteBlock返回数据
 */
- (void)determineButtonAction
{
    if (_cellBlock) {
        _cellBlock(_clickedRow);
    }
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (void)removeChooseView
{
    if (_cancelBlock) {
        _cancelBlock();
    }
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
