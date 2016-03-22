//
//  ContactsCell.h
//  4G
//
//  Created by yg on 16/1/27.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DetailBlock)(void);

@interface ContactsCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *nameLb;
@property (nonatomic,weak) IBOutlet UILabel *numLb;
@property (nonatomic,strong) DetailBlock block;

@property (nonatomic,strong) NSString *beCalledNum;

- (void)initWithName:(NSString *)name andNum:(NSAttributedString *)number;

@end
