//
//  ViewController.m
//  LoopScrollView
//
//  Created by mac on 14-11-17.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "ViewController.h"

#import "ZJLoopScrollView.h"

@interface ViewController ()<UIScrollViewDelegate>
{
    NSArray *array;
    
    UIScrollView *scrollView;
    NSMutableArray *slideImages;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //[self.view addSubview:[self homeScrollView]];
    
    //创建循环滚动视图
    ZJLoopScrollView *loopScrollView = [[ZJLoopScrollView alloc] init];
    loopScrollView.frame = CGRectMake(0, 20, 320, 460);
    loopScrollView.imageArray = @[@"Welcome_3.0_1.jpg",@"Welcome_3.0_2.jpg",@"Welcome_3.0_3.jpg",@"Welcome_3.0_4.jpg",@"Welcome_3.0_5.jpg"];
    loopScrollView.autoScroll = YES;
    [self.view addSubview:loopScrollView];
    
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
