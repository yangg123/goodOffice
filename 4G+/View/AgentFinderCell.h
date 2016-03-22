//
//  AgentFinderCell.h
//  GoodOffice
//
//  Created by yg on 16/3/15.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgentFinderCell : UITableViewCell

@property (nonatomic,assign) BOOL isOpen;
@property (nonatomic,weak) IBOutlet UILabel *titleLb;
@property (nonatomic,weak) IBOutlet UILabel *contentLb;
@property (nonatomic,weak) IBOutlet UIImageView *arrowImgv;
@end
