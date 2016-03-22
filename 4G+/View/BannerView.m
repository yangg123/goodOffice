//
//  BannerView.m
//  4G
//  轮播图
//  Created by yg on 16/1/27.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "BannerView.h"
#import "NSTimer+TMCBlocksSupport.h"

@implementation BannerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        [self.scrollView setImgUrlArr:[NSArray arrayWithObjects:@"test1.jpg", @"test2.jpg", @"test1.jpg",@"test2.jpg", nil]];
        [self startTimer];
    }
    return self;
}

- (SwitchScrolView *)scrollView
{
    if (_scrollView == nil) {
        //添加轮播图
        _scrollView = [[SwitchScrolView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, self.height)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.switchDelegate = self;
        [_scrollView setDelegate:self];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.height - 25, Main_Screen_Width, 25)];
        _pageControl.currentPage = 0;
        _pageControl.backgroundColor = [UIColor clearColor];//背景
        _pageControl.numberOfPages = 4;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor colorFromHexRGB:@"ffffff" andAlpha:0.4];
        _pageControl.enabled = YES;
    }
    
    return _pageControl;
}

- (void)startTimer{
    
    __weak BannerView* weakSelf = self;
    _switchTime = [NSTimer tmc_scheduledTimerWithTimeInterval:3 block:^{
        [weakSelf runTimePage];
    } repeats:YES];
}


/**
 *	@brief	定时器方法
 */
- (void)runTimePage
{
    int page = (int)_pageControl.currentPage;
    page++;
    page = page >= _pageControl.numberOfPages ? 0 : page;
    _pageControl.currentPage = page;
    [self turnPage];
}


- (void)turnPage
{
    int page = (int)_pageControl.currentPage;
    [_scrollView scrollRectToVisible:CGRectMake(Main_Screen_Width*page,0,Main_Screen_Width,_scrollView.height) animated:NO];
}

#pragma mark - scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    _pageControl.currentPage = _scrollView.contentOffset.x/Main_Screen_Width;
}

#pragma mark - scrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_switchTime invalidate];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}


@end
