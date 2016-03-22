//
//  RecordDetailCell.m
//  4G
//
//  Created by yg on 16/1/28.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "RecordDetailCell.h"

@implementation RecordDetailCell

- (void)awakeFromNib {
    self.inviteBtn.layer.cornerRadius = 4;
}

- (IBAction)callAction:(id)sender
{
    if (_callBlock) {
        _callBlock();
    }
}

- (IBAction)shareToOthers:(id)sender
{
    if (_inviteBlock) {
        _inviteBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
