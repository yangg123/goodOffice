//
//  CallRecordCell.h
//  4G
//
//  Created by yg on 16/1/27.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecordModel;

typedef void(^DetailBlock)(void);

@interface CallRecordCell : UITableViewCell
{
    IBOutlet UILabel *_callNameLb;
    IBOutlet UILabel *_callNumLb;
    IBOutlet UILabel *_callTimeLb;
}
@property (nonatomic,strong) DetailBlock block;

- (void)initWithModel:(RecordModel *)model;

@end
