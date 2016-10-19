//
//  ViewController.m
//  TCRotatorImageViewDemo
//
//  Created by 艾呦呦 on 16/10/19.
//  Copyright © 2016年 none. All rights reserved.
//

#import "ViewController.h"
#import "TCRotatorImageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //网络图片
    NSArray *imageUrlStrings = @[
                                 @"http://obr2ozlb6.bkt.clouddn.com/image/TCRotateImageView/photo1m.jpg",
                                 @"http://obr2ozlb6.bkt.clouddn.com/image/TCRotateImageView/photo2m.jpg",
                                 @"http://obr2ozlb6.bkt.clouddn.com/image/TCRotateImageView/photo3m.jpg",
                                 @"http://obr2ozlb6.bkt.clouddn.com/image/TCRotateImageView/photo4m.jpg"
                                 ];
    
    //本地图片
    NSArray *localImageNames = @[
                                 @"1.jpg",
                                 @"2.png",
                                 @"3.jpg",
                                 @"4.jpg"
                                 ];
    
    CGRect frame = CGRectMake(0, 100, self.view.bounds.size.width, 200);
    TCRotatorImageView *rotatorImageView = [TCRotatorImageView rotatorImageViewWithFrame:frame imageURLStrigArray:imageUrlStrings placeholerImage:nil];
    [self.view addSubview:rotatorImageView];
    
    
    CGRect frame1 = CGRectMake(0, 320, self.view.bounds.size.width, 200);
    TCRotatorImageView *rotatorImageView1 = [TCRotatorImageView rotatorImageViewWithFrame:frame1 imageNameArray:localImageNames];
    [self.view addSubview:rotatorImageView1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
