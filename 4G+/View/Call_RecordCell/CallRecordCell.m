//
//  CallRecordCell.m
//  4G
//
//  Created by yg on 16/1/27.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "CallRecordCell.h"
#import "RecordModel.h"

@implementation CallRecordCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)initWithModel:(RecordModel *)model
{
    _callNameLb.text = model.beCalledName;
    _callNumLb.text = model.beCalledNum;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:model.startCallTime];
    
    
    _callTimeLb.text = [date minuteDescription];
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
