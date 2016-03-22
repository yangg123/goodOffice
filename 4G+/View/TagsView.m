//
//  TagsView.m
//  GoodOffice
//  功能介绍： 标签封装
//  Created by yg on 16/3/7.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "TagsView.h"

@implementation TagsView

- (id)initWithOriginTagArr:(NSArray *)tagArr
               andMaxWidth:(CGFloat)maxWidth
                andOriginX:(CGFloat)originX
                andOriginY:(CGFloat)originY
{
    self = [super initWithFrame:CGRectMake(0, 0, maxWidth, 60)];
    if (self)
    {
        if (NSArrayIsValid(tagArr)) {
            
            CGFloat startX = originX;
            CGFloat startY = originY;
            
            for (int i = 0; i < tagArr.count; i++) {
                
                NSString *content = tagArr[i];
                CGSize constraint = CGSizeMake(CGFLOAT_MAX, 23);
                
                NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11.5],NSFontAttributeName,nil];
                CGSize size = [content boundingRectWithSize:constraint
                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 attributes:tdic
                                                    context:nil].size;
                
                if (size.width + 13 > maxWidth) {
                    startX = originX;
                    startY += 32;
                }
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(startX , startY, size.width + 13, 20)];
                label.text = content;
                label.textAlignment = NSTextAlignmentCenter;
                label.font = [UIFont systemFontOfSize:11.5];
                label.textColor = [UIColor colorFromHexRGB:@"00d6be"];
                ViewBorderRadius(label, 10, 0.5, [UIColor colorFromHexRGB:@"00d6be"]);
                [self addSubview:label];
                
                startX = label.right + 10;
                if (startX > maxWidth) {
                    startY += 32;
                }
            }
            
            self.height = startY + 10;
        }   
    }
    return self;
}

@end
