# TCRotatorImageView
[![CI Status](http://img.shields.io/travis/cheenbee/TCRotatorImageView.svg?style=flat)](https://travis-ci.org/cheenbee/TCRotatorImageView)
[![Version](https://img.shields.io/cocoapods/v/TCRotatorImageView.svg?style=flat)](http://cocoapods.org/pods/TCRotatorImageView)
[![License](https://img.shields.io/cocoapods/l/TCRotatorImageView.svg?style=flat)](http://cocoapods.org/pods/TCRotatorImageView)
[![Platform](https://img.shields.io/cocoapods/p/TCRotatorImageView.svg?style=flat)](http://cocoapods.org/pods/TCRotatorImageView)     
无限循环图片轮播器
![demo](http://obr2ozlb6.bkt.clouddn.com/gif/TCRotatorImageView/demo.gif)

## Installation

TCRotatorImageView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod "TCRotatorImageView"
```
或者将 TCRotatorImageView 文件夹拖入工程中
 
#### Usage 


```
//网络加载图片轮播器
TCRotatorImageView *rotatorImageView = [TCRotatorImageView rotatorImageViewWithFrame:frame imageURLStrigArray:imageUrlStrings placeholerImage:placeholderImage];

//本地加载图片轮播器
TCRotatorImageView *rotatorImageView = [TCRotatorImageView rotatorImageViewWithFrame:frame imageNameArray:localImageNamesArray];
```

#### 详细配置
1. rotatorImageView.delegate = self; //设置监听点击图片代理,请实现代理方法  

2. 自定义样式,请设置对应的属性     

```
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
```

##### 参考自最好用的图片轮播器
[SDCycleScrollView](https://github.com/gsdios/SDCycleScrollView)

