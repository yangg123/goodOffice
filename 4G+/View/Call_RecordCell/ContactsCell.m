//
//  ContactsCell.m
//  4G
//
//  Created by yg on 16/1/27.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "ContactsCell.h"

@implementation ContactsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)initWithName:(NSString *)name andNum:(NSAttributedString *)number
{
    self.nameLb.text = name;
    self.numLb.attributedText = number;
}

- (IBAction)detailClick:(id)sender
{
    if (_block) {
        _block();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
