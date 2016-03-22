//
//  RentTableViewCell.h
//  GoodOffice
//
//  Created by yg on 16/3/7.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^favouriteBlock)(void);
typedef void (^seeRoomBlock)(void);

@interface RentTableViewCell : UITableViewCell
{
    IBOutlet UIButton *_favouriteBtn;
    IBOutlet UIButton *_seeRoom;
}
@end
