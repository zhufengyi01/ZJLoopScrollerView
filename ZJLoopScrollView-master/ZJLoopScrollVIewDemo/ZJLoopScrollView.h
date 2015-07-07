//
//  ZJLoopScrollView.h
//  ZJLoopScrollView
//
//  Created by mac on 13-10-17.
//  Copyright (c) 2013年 zhang jian. All rights reserved.
//

#import <UIKit/UIKit.h>

//========用法============
/*
    //1.先包含头文件
    //#import "ZJLoopScrollView.h"
 
 
    //2.创建循环滚动视图
    ZJLoopScrollView *loopScrollView = [[ZJLoopScrollView alloc] init];
    //设置位置
    loopScrollView.frame = CGRectMake(0, 20, 320, 460);
    //设置显示的图片数组
    loopScrollView.imageArray = @[@"Welcome_3.0_1.jpg",@"Welcome_3.0_2.jpg",@"Welcome_3.0_3.jpg",@"Welcome_3.0_4.jpg",@"Welcome_3.0_5.jpg"];
    //设置是否自动滚动
    loopScrollView.autoScroll = YES;
    //添加到view中显示
    [self.view addSubview:loopScrollView];

*/


//功能: 自动循环滚动显示多张图片
@interface ZJLoopScrollView : UIView
//需要显示的图片数组
@property (copy,nonatomic) NSArray *imageArray;
//是否自动滚动
@property (nonatomic) BOOL autoScroll;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIPageControl *pageControl;
@end
