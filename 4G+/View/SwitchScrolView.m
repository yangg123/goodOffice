//
//  SwitchScrolView.m
//  SmartCampus
//
//  Created by LianJR on 14-7-2.
//  Copyright (c) 2014年 cgf. All rights reserved.
//
//  开发版本: v1.0
//  开发者: LJR
//  编写时间: 14-7-02
//  功能描述: 首页图片切换scrollview


#import "SwitchScrolView.h"
//#import "UIImageView+WebCache.h"

@implementation SwitchScrolView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageArr = [NSMutableArray array];
    }
    return self;
}


/**
 *	@brief	添加图片并赋予图片URL
 *	@param 	imgUrlArr 	图片URL的数组
 *	@return
 */
- (void)setImgUrlArr:(NSArray *)imgUrlArr
{
    _imgUrlArr = imgUrlArr;
    
    self.contentSize = CGSizeMake(_imgUrlArr.count * Main_Screen_Width, self.frame.size.height);
    
    for (NSInteger i = 0; i < _imgUrlArr.count; i++) {
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i * Main_Screen_Width, 0.0f, Main_Screen_Width, self.frame.size.height)];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.layer.masksToBounds = YES;
        NSString *imageUrl = [_imgUrlArr objectAtIndex:i];

//        [imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl]
//                       placeholderImage:[UIImage imageNamed:@"loading"]
//                                options:SDWebImageProgressiveDownload
//                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                                  
//                                  if(error != nil) {
//                                      imgView.image = [UIImage imageNamed:@"smallShopListFail@2x"];
//                                  }
//                              }];
        
        //临时使用，服务端数据过来时使用上面注释的代码
        [imgView setImage:[UIImage imageNamed:imageUrl]];
        imgView.userInteractionEnabled = YES;
        imgView.tag = MJPhotoTag + i;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(UesrClicked:)];
        [imgView addGestureRecognizer:singleTap];
        [self addSubview:imgView];
        [self sendSubviewToBack:imgView];
        [_imageArr addObject:imgView];
    }
}


- (void)setLaungchImgArr:(NSArray *)LaungchImgArr
{
    _LaungchImgArr = LaungchImgArr;

    self.contentSize = CGSizeMake(_LaungchImgArr.count * Main_Screen_Width, self.frame.size.height);
    for (NSInteger i = 0; i < _LaungchImgArr.count; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i * Main_Screen_Width, 0.0f, Main_Screen_Width, Main_Screen_Height)];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.layer.masksToBounds = YES;
        
        [imgView setImage:[UIImage imageNamed:_LaungchImgArr[i]]];
        //临时使用，服务端数据过来时使用上面注释的代码
        //[imgView setImage:[UIImage imageNamed:imageUrl]];
        imgView.userInteractionEnabled = YES;
        imgView.tag = MJPhotoTag + i;
        [self addSubview:imgView];
        [self sendSubviewToBack:imgView];
    }
}
/**
 *	@brief	图片点击事件
 *	@param
 *	@return
 */

- (void)UesrClicked:(UIGestureRecognizer *)sender
{
    if ([_switchDelegate respondsToSelector:@selector(bannerAction:)]) {
        [_switchDelegate bannerAction:sender.view.tag];
    }
}

@end
