//
//  BottomMenu.h
//  4G
//  底部弹出框
//  Created by yg on 16/2/1.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CancelBlock)(void);
typedef void (^SelectBlock)(NSInteger row);

@interface BottomMenuView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *listArray;
@property (nonatomic,strong) NSString *cancelStr;
@property (nonatomic,strong) SelectBlock block;
@property (nonatomic,strong) CancelBlock cancelBlock;

+ (void)showViewWithList:(NSArray *)listArray
          andCancelTitle:(NSString *)cancelStr
             selectBlock:(SelectBlock)block
             cancelBlock:(CancelBlock)cancelBlock;

@end
