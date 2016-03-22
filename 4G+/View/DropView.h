//
//  OrderType.h
//  Yeke
//
//  Created by yangg on 15-1-31.
//  Copyright (c) 2015年 西米网络科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DropTeSe,
    DropArea,
    DropPrice,
    DropSquare
} DropType;

typedef void (^CancelBlock)(void);
typedef void (^CellClickBlock)(NSInteger row);
typedef void (^ConfirmBlock)(NSInteger fromValue,NSInteger toValue);

@interface DropView : UIView<UITableViewDataSource, UITableViewDelegate>
{
    CellClickBlock _cellBlock;
    CancelBlock _cancelBlock;
    
    DropType _type;
    NSInteger _clickedRow;
}

+ (DropView *)sharedView;

@property (nonatomic,assign) DropType preType;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UITableView *subTableView;

@property (nonatomic,strong) NSArray *listArray;
@property (nonatomic,strong) NSArray *subListArray;

/**
 *  @brief  选项视图在屏幕底部
 *	@param 	listArray 	选项的标题数组
 *	@param 	block       选择完成的回调代码块
 */
+ (void)showWithOriginView:(UIView *)originView
                chooseList:(NSArray *)listArray
                  withType:(DropType)type
                 aboveView:(UIView *)superView
                  andBlock:(CellClickBlock)block
            andCancelBlock:(CancelBlock)cancelBlock;

+ (void)dismiss;

@end
