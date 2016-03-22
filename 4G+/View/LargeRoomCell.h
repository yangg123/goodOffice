//
//  LargeRoomCell.h
//  GoodOffice
//
//  Created by yg on 16/3/3.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LargeRoomCell : UITableViewCell
{
    IBOutlet UIImageView *_roomImgv;
    IBOutlet UIImageView *_stateImgv;
    IBOutlet UILabel *_nameLb;
    IBOutlet UILabel *_placeLb;
    IBOutlet UILabel *_priceLb;
    IBOutlet UILabel *_numsLb;
    IBOutlet UILabel *_noteLb;
}
@end
