//
//  ZJLoopScrollView.m
//  ZJLoopScrollView
//
//  Created by mac on 13-10-17.
//  Copyright (c) 2013年 zhang jian. All rights reserved.
//

#import "ZJLoopScrollView.h"

@interface ZJLoopScrollView ()<UIScrollViewDelegate>
{
    NSTimer *_myTimer;
}
@end

@implementation ZJLoopScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self refreshUI];
}

-(void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    [self refreshUI];
}

-(void)refreshUI
{
    if(_imageArray.count == 0)
    {
        return;
    }
    
    //先移除以前的视图
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    //创建滚动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_scrollView];
    _scrollView.bounces = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    

    //add the last image first
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_imageArray objectAtIndex:([_imageArray count]-1)]]];
    
    imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [_scrollView addSubview:imageView];
    
    for (int i = 0;i<[_imageArray count];i++) {
        //loop this bit
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_imageArray objectAtIndex:i]]];
        imageView.frame = CGRectMake((self.frame.size.width * i) + 0 + 320, 0, self.frame.size.width, self.frame.size.height);
        [_scrollView addSubview:imageView];
    }
    
    //add the first image at the end
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_imageArray objectAtIndex:0]]];
    imageView.frame = CGRectMake((self.frame.size.width * ([_imageArray count] + 1)) + 0, 0, self.frame.size.width, self.frame.size.height);
    [_scrollView addSubview:imageView];
    
    [_scrollView setContentSize:CGSizeMake(self.frame.size.width * ([_imageArray count] + 2), self.frame.size.height)];
    [_scrollView setContentOffset:CGPointMake(0, 0)];

    [_scrollView scrollRectToVisible:CGRectMake(self.frame.size.width,0,self.frame.size.width,self.frame.size.height) animated:NO];

    //添加页面控制
    //创建pageControl
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _pageControl.center = CGPointMake(self.frame.size.width/2, self.frame.size.height - 20);
    [self addSubview:_pageControl];
    _pageControl.numberOfPages = _imageArray.count;
    
    //添加自动滚动
    [self performSelector:@selector(updateScrollView) withObject:nil afterDelay:0.0f];

}

#pragma mark - 循环滚动

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentPage = floor((scrollView.contentOffset.x - scrollView.frame.size.width / ([_imageArray count]+2)) / scrollView.frame.size.width) + 1;
    if (currentPage==0) {
        //go last but 1 page
        [scrollView scrollRectToVisible:CGRectMake(self.frame.size.width * [_imageArray count],0,self.frame.size.width,self.frame.size.height) animated:NO];
    } else if (currentPage==([_imageArray count]+1)) { //如果是最后+1,也就是要开始循环的第一个
        [scrollView scrollRectToVisible:CGRectMake(self.frame.size.width,0,self.frame.size.width,self.frame.size.height) animated:NO];
    }
    
    [self updatePageControl];
}

-(void)updatePageControl
{
    if(_scrollView.frame.size.width == 0)
    {
        return;
    }
    int index = _scrollView.contentOffset.x / _scrollView.frame.size.width;
    //NSLog(@"index = %d",index);
    _pageControl.currentPage = index-1;
}

#pragma mark - 自动滚动

- (void) updateScrollView
{
    [_myTimer invalidate];
    _myTimer = nil;
    //time duration
    NSTimeInterval timeInterval = 3;
    //timer
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(handleMaxShowTimer:) userInfo:nil repeats:YES];
}

- (void)handleMaxShowTimer:(NSTimer*)theTimer
{
    //控制是否自动滚动
    if(_autoScroll == NO)
    {
        return;
    }
    
    CGPoint pt = _scrollView.contentOffset;
    int count = [_imageArray count];
    if(pt.x == _scrollView.frame.size.width * count){
        [_scrollView setContentOffset:CGPointMake(0, 0)];
        [_scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width,0,_scrollView.frame.size.width,_scrollView.frame.size.height) animated:YES];
    }else{
        [_scrollView scrollRectToVisible:CGRectMake(pt.x+_scrollView.frame.size.width,0,_scrollView.frame.size.width,_scrollView.frame.size.height) animated:YES];
    }
    
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updatePageControl];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
