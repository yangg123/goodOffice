//
//  TagsView.h
//  GoodOffice
//  功能介绍： 标签封装
//  Created by yg on 16/3/7.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagsView : UIView

- (id)initWithOriginTagArr:(NSArray *)tagArr
               andMaxWidth:(CGFloat)maxWidth
                andOriginX:(CGFloat)originX
                andOriginY:(CGFloat)originY;

@end
