//
//  BottomMenu.m
//  4G
//  底部弹出框
//  Created by yg on 16/2/1.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "BottomMenuView.h"
#import "BottomMenuCell.h"

#define WINDOW_ARRAY [[UIApplication sharedApplication] windows]

#define CellHeight 54    //行高
#define VerticalSpace 6  //间距

@implementation BottomMenuView

//    http://blog.csdn.net/leikezhu1981/article/details/8047442
//      for (id object in WINDOW_ARRAY) {
//          NSLog(@"object is %@",object);
//      }
//==> 正常的windows
//    2016-02-24 14:17:23.073 4G[8066:125560] object is <UIWindow: 0x7ff0405346b0; frame = (0 0; 375 667); gestureRecognizers = <NSArray: 0x7ff040535700>; layer = <UIWindowLayer: 0x7ff0405338a0>>
//    2016-02-24 14:17:23.073 4G[8066:125560] object is <UITextEffectsWindow: 0x7ff042331320; frame = (0 0; 375 667); opaque = NO; autoresize = W+H; layer = <UIWindowLayer: 0x7ff04232ffc0>>
//    2016-02-24 14:17:23.075 4G[8066:125560] current last object is <UITextEffectsWindow: 0x7ff042331320; frame = (0 0; 375 667); opaque = NO; autoresize = W+H; layer = <UIWindowLayer: 0x7ff04232ffc0>>


//====>present 系统的联系人编辑界面回来后 window层次变化
//    2016-02-24 14:17:57.608 4G[8066:125560] object is <UIWindow: 0x7ff0405346b0; frame = (0 0; 375 667); gestureRecognizers = <NSArray: 0x7ff040535700>; layer = <UIWindowLayer: 0x7ff0405338a0>>
//    2016-02-24 14:17:57.608 4G[8066:125560] object is <UITextEffectsWindow: 0x7ff042331320; frame = (0 0; 375 667); opaque = NO; autoresize = W+H; layer = <UIWindowLayer: 0x7ff04232ffc0>>
//    2016-02-24 14:17:57.609 4G[8066:125560] object is <UITextEffectsWindow: 0x7ff042766260; frame = (0 0; 375 667); layer = <UIWindowLayer: 0x7ff04060aa70>>
//    2016-02-24 14:17:57.609 4G[8066:125560] object is <UIRemoteKeyboardWindow: 0x7ff042766fe0; frame = (0 0; 375 667); opaque = NO; autoresize = W+H; layer = <UIWindowLayer: 0x7ff042767660>>


+ (void)showViewWithList:(NSArray *)listArray
          andCancelTitle:(NSString *)cancelStr
             selectBlock:(SelectBlock)block
             cancelBlock:(CancelBlock)cancelBlock
{
    UIWindow *keyWindow = (UIWindow *)WINDOW_ARRAY[0];
    BottomMenuView *menuView = [[BottomMenuView alloc] initWithFrame:MainScreen_Frame
                                                                list:listArray
                                                           cancelTxt:cancelStr
                                                         selectBlock:block
                                                         cancelBlock:cancelBlock];
    menuView.alpha = 0;
    [keyWindow addSubview:menuView];
    
    CGRect frame = menuView.tableView.frame;
    frame.origin.y += frame.size.height;
    menuView.tableView.frame = frame;
    //添加上升动画
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^() {
                         menuView.alpha = 1;
                         CGRect frame = menuView.tableView.frame;
                         frame.origin.y -= frame.size.height;
                         menuView.tableView.frame = frame;
                     } completion:^(BOOL finished) {
                     }];
}

- (id)initWithFrame:(CGRect)frame
               list:(NSArray *)list
          cancelTxt:(NSString *)cancelStr
        selectBlock:(SelectBlock)block
        cancelBlock:(CancelBlock)cancelBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.listArray = list;
        self.cancelStr = cancelStr;
        self.block = block;
        self.cancelBlock = cancelBlock;
        
        //半透明背景
        UIView *backgroundView = [[UIView alloc]initWithFrame:frame];
        backgroundView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backGroundClick)];
        backgroundView.alpha = 0.4;
        [backgroundView addGestureRecognizer:tap];
        [self addSubview:backgroundView];
        
        CGFloat allHeight = list.count * CellHeight + CellHeight + VerticalSpace;
        CGFloat originY = frame.size.height - allHeight;
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.frame = CGRectMake(0,originY,Main_Screen_Width,allHeight);
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.bounces = NO;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.tableView];
    }
    return self;
}


#pragma mark - table 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)_tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.listArray.count;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"BottomMenuCell";
    BottomMenuCell *cell=(BottomMenuCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BottomMenuCell" owner:self options:nil] objectAtIndex:0];
    }
    
    if (indexPath.section == 0) {
        cell.contentLb.text = self.listArray[indexPath.row];
    } else {
        cell.contentLb.text = self.cancelStr;
    }
    
    if (indexPath.section == 0) {
        cell.contentLb.textColor = [UIColor colorFromHexRGB:@"00bf8f"];
    }
    
    return cell;
}


#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellHeight;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, VerticalSpace)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (section == 1) {
        return VerticalSpace;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self backGroundClick];
    if (self.block && indexPath.section == 0) {
        self.block(indexPath.row);
    }
}

#pragma mark - Events Action
//背景点击取消
- (void)backGroundClick
{
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^() {
                         self.alpha = 0;
                         CGRect frame = self.tableView.frame;
                         frame.origin.y += frame.size.height;
                         self.tableView.frame = frame;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

//取消按钮 移除self
- (void)removeChooseView
{
    [self backGroundClick];
    if (_cancelBlock) {
        _cancelBlock();
    }
}

@end
