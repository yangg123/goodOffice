//
//  RecordDetailCell.h
//  4G
//
//  Created by yg on 16/1/28.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MessageInviteBlock)(void);   //短信邀请
typedef void(^CallBlock)(void);

@interface RecordDetailCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UIButton *inviteBtn;
@property (nonatomic,weak) IBOutlet UILabel *phoneLb;

@property (nonatomic,strong) MessageInviteBlock inviteBlock;
@property (nonatomic,strong) CallBlock callBlock;

@end
