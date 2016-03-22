//
//  AgentFinderCell.m
//  GoodOffice
//
//  Created by yg on 16/3/15.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "AgentFinderCell.h"

@implementation AgentFinderCell

- (void)awakeFromNib {
    // Initialization code
}

//UITableView添加footerView 后 最后一行分割线无法显示问题解决方案。
- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *subview in self.contentView.superview.subviews) {
        if ([NSStringFromClass(subview.class) hasSuffix:@"SeparatorView"]) {
            NSLog(@"frame is %@",NSStringFromCGRect(subview.frame));
            subview.hidden = NO;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
