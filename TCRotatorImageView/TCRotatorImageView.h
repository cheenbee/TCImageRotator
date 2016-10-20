//
//  TCRotatorImageView.h
//  ScrollInfinite
//
//  Created by cheenbee on 16/10/17.
//  Copyright © 2016年 cheenbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCRotatorImageView;
@protocol TCRotatorImageViewDelegate<NSObject>

/** 点击图片回调 */
- (void)rotatorImageView:(TCRotatorImageView *)rotatorImageView didClickImageIndex:(NSInteger)index;

@end

@interface TCRotatorImageView : UIView

/**
 *  初始化轮播图,图片从网络获取
 *
 *  @param frame                显示frame
 *  @param imagesURLStringArray 图片URL地址字符串数组
 *  @param placeholerImage      占位图
 *
 *  @return TCRotatorImageView 实例
 */
+ (instancetype)rotatorImageViewWithFrame:(CGRect)frame
                                   imageURLStrigArray:(NSArray<NSString *> *)imagesURLStringArray
                          placeholerImage:(UIImage *)placeholerImage;

/**
 *  初始化轮播图,图片在本地
 *
 *  @param frame          显示frame
 *  @param imageNameArray 本地图片名称数组
 *
 *  @return TCRotatorImageView 实例
 */
+ (instancetype)rotatorImageViewWithFrame:(CGRect)frame
                       imageNameArray:(NSArray<NSString *> *)imageNameArray;


@property (nonatomic, weak) id<TCRotatorImageViewDelegate> delegate;

/** 网络图片 URL string 数组 */
@property (nonatomic, strong) NSArray<NSString *> *imageURLStrigArray;

/** 本地图片 名称 string 数组 */
@property (nonatomic, strong) NSArray<NSString *> *localImageNameArray;

///////////////////////////////    自定义样式     /////////////////////////////////

/** 自动轮播间隔, 默认为 2s */
@property (nonatomic, assign) CGFloat rotateTimeInterval;

/** 是否无限循环模式, 默认为 YES */
@property (nonatomic, assign, getter=isInfiniteLoopMode) BOOL infiniteLoopMode;

/** 是否自动滚动, 默认为 YES */
@property (nonatomic, assign, getter=isAutoScroll) BOOL autoScroll;

/** 是否在只有一张图片时隐藏 pageControl, 默认为 YES */
@property (nonatomic, assign, getter=isHidesForSinglePage) BOOL hidesForSinglePage;

/** pageControl 当前页小图标颜色*/
@property (nonatomic, strong) UIColor *currentPageIndicatorColor;

/** pageControl 所有小图标颜色*/
@property (nonatomic, strong) UIColor *pageIndicatorColor;

@end
