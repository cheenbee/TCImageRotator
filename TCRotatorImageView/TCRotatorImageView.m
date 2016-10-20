//
//  TCRotatorImageView.m
//  ScrollInfinite
//
//  Created by cheenbee on 16/10/17.
//  Copyright © 2016年 cheenbee. All rights reserved.
//

#import "TCRotatorImageView.h"
#import "TCImageViewCell.h"

NSString * const reuseID = @"TCImageViewCell";
static const NSInteger kInfiniteLoopMultiple = 1000;

@interface TCRotatorImageView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *colletcionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIPageControl *pageControll;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSArray *imagePathsArray;
@property (nonatomic, strong) UIImage *placeholderImage;

@property (nonatomic, assign) NSInteger totalItemsCount;

@end

@implementation TCRotatorImageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        [self setupSubViews];
    }
    
    return self;
}

- (void)initialization {
    _rotateTimeInterval = 2.0f;
    _autoScroll = YES;
    _infiniteLoopMode = YES;
    _hidesForSinglePage = YES;
    _currentPageIndicatorColor = [UIColor whiteColor];
    _pageIndicatorColor = [UIColor lightGrayColor];
}

+ (instancetype)rotatorImageViewWithFrame:(CGRect)frame
                       imageURLStrigArray:(NSArray<NSString *> *)imagesURLStringArray placeholerImage:(UIImage *)placeholerImage {
    TCRotatorImageView *rotatorImageView = [[self alloc] initWithFrame:frame];
    rotatorImageView.imageURLStrigArray = imagesURLStringArray;
    rotatorImageView.placeholderImage = placeholerImage;
    
    return rotatorImageView;
}

+ (instancetype)rotatorImageViewWithFrame:(CGRect)frame
                           imageNameArray:(NSArray<NSString *> *)imageNameArray {
    TCRotatorImageView *rotatorImageView = [[self alloc] initWithFrame:frame];
    rotatorImageView.localImageNameArray = imageNameArray;
    
    return rotatorImageView;
}

- (void)setupSubViews {
    [self addSubview:self.colletcionView];
}


#pragma mark - properties

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [UICollectionViewFlowLayout new];
        _flowLayout.minimumInteritemSpacing = 0.0f;
        _flowLayout.minimumLineSpacing = 0.0f;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

- (UICollectionView *)colletcionView {
    if (!_colletcionView) {
        _colletcionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _colletcionView.delegate = self;
        _colletcionView.dataSource = self;
        _colletcionView.pagingEnabled = YES;
        _colletcionView.showsHorizontalScrollIndicator = NO;
        _colletcionView.showsVerticalScrollIndicator = NO;
        _colletcionView.bounces = NO;
        [_colletcionView registerClass:[TCImageViewCell class] forCellWithReuseIdentifier:reuseID];
    }
    return _colletcionView;
}

- (UIPageControl *)pageControll {
    if (!_pageControll) {
        _pageControll = [[UIPageControl alloc] init];
    }
    return _pageControll;
}

- (NSInteger)currentItemIndex {
    if (self.colletcionView.bounds.size.width == 0) {
        return 0;
    }
    
    NSInteger index = 0;
    if (self.flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        //itemSize 一般与 collectionView's size 同样大小
        index = (self.colletcionView.contentOffset.x + self.flowLayout.itemSize.width*0.5) / self.flowLayout.itemSize.width;
    }
    
    return MAX(0, index);
}

- (void)setLocalImageNameArray:(NSArray<NSString *> *)localImageNameArray {
    _localImageNameArray = localImageNameArray;
    self.imagePathsArray = [localImageNameArray copy];
}

- (void)setImageURLStrigArray:(NSArray<NSString *> *)imageURLStrigArray {
    _imagePathsArray = imageURLStrigArray;
    self.imagePathsArray = [imageURLStrigArray copy];
}

- (void)setImagePathsArray:(NSArray *)imagePathsArray {
    _imagePathsArray = imagePathsArray;
    
    [self invalidateTimer];
    _totalItemsCount = self.infiniteLoopMode ? self.imagePathsArray.count*kInfiniteLoopMultiple : self.imagePathsArray.count;
    
    if (imagePathsArray.count != 1) {
        self.colletcionView.scrollEnabled = YES;
        [self setAutoScroll:self.isAutoScroll];
    } else {
        self.colletcionView.scrollEnabled = NO;
    }
    
    [self setupPageControl];
    [self.colletcionView reloadData];
}

- (void)setAutoScroll:(BOOL)autoScroll {
    _autoScroll = autoScroll;
    
    [self invalidateTimer];
    
    if (autoScroll) {
        [self setupTimer];
    }
}

- (void)setRotateTimeInterval:(CGFloat)rotateTimeInterval {
    _rotateTimeInterval = rotateTimeInterval;
    
    [self setAutoScroll:self.isAutoScroll];
}

- (void)setPageIndicatorColor:(UIColor *)pageIndicatorColor {
    _pageIndicatorColor = pageIndicatorColor;
    self.pageControll.pageIndicatorTintColor = pageIndicatorColor;
}

- (void)setCurrentPageIndicatorColor:(UIColor *)currentPageIndicatorColor {
    _currentPageIndicatorColor = currentPageIndicatorColor;
    self.pageControll.currentPageIndicatorTintColor = currentPageIndicatorColor;
}

- (void)setInfiniteLoopMode:(BOOL)infiniteLoopMode {
    _infiniteLoopMode = infiniteLoopMode;
    
    if (self.imagePathsArray.count) {
        self.imagePathsArray = self.imagePathsArray;
    }
}

- (void)setHidesForSinglePage:(BOOL)hidesForSinglePage {
    _hidesForSinglePage= hidesForSinglePage;
    
    if (self.imagePathsArray.count == 1 && hidesForSinglePage) {
        [self setupPageControl];
    }
}

#pragma mark - inner actions

- (void)setupPageControl {
    if (_pageControll) [_pageControll removeFromSuperview];
    
    if (self.imagePathsArray.count == 1 && self.isHidesForSinglePage) return;
    
    self.pageControll.numberOfPages = self.imagePathsArray.count;;
    self.pageControll.currentPage = [self pageControlIndexWithCurrentItemIndex:[self currentItemIndex]];
    self.pageControll.currentPageIndicatorTintColor = self.currentPageIndicatorColor;
    self.pageControll.pageIndicatorTintColor = self.pageIndicatorColor;
    self.pageControll.userInteractionEnabled = NO;
    
    [self addSubview:self.pageControll];
    [self bringSubviewToFront:self.pageControll];
}

- (NSInteger)pageControlIndexWithCurrentItemIndex:(NSInteger)itemImdex {
    return itemImdex % self.imagePathsArray.count;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.colletcionView.frame = self.bounds;
    self.flowLayout.itemSize = self.colletcionView.frame.size;
    
    if (self.isInfiniteLoopMode) {
        [self.colletcionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_totalItemsCount*0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    CGSize pageControlSize = [self.pageControll sizeForNumberOfPages:self.imagePathsArray.count];
    CGFloat pageControlCenterX = (self.bounds.size.width)*0.5;
    CGFloat pageControlCenterY = self.colletcionView.frame.size.height - pageControlSize.height*0.5;

    self.pageControll.bounds = CGRectMake(0, 0, pageControlSize.width, pageControlSize.height);
    self.pageControll.center = CGPointMake(pageControlCenterX, pageControlCenterY);
    
}

- (void)setupTimer {
    if ([self respondsToSelector:@selector(updateTimer)]) {
        self.timer = [NSTimer timerWithTimeInterval:self.rotateTimeInterval target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)updateTimer {
    if (0 == self.imagePathsArray.count) return;
    NSInteger currentPage = [self currentItemIndex];
    NSInteger targetIndex = currentPage + 1;
    
    //若无限轮播即将滚动到的index超出所有预设的item数量
    if (targetIndex >= _totalItemsCount && self.isInfiniteLoopMode) {
        targetIndex = _totalItemsCount * 0.5;
    }
    
    [self.colletcionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)invalidateTimer
{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  _totalItemsCount;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TCImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    
    NSInteger itemIndex = [self pageControlIndexWithCurrentItemIndex:indexPath.item];
    NSString *imagePathStr = self.imagePathsArray[itemIndex];
    
    if ([imagePathStr hasPrefix:@"http"]) {
        cell.placeholderImage = self.placeholderImage;
        cell.imagePathStr = imagePathStr;
    } else {
        cell.localImageName = imagePathStr;
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(rotatorImageView:didClickImageIndex:)]) {
        [self.delegate rotatorImageView:self didClickImageIndex:indexPath.item % self.imagePathsArray.count];
    }
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentPage = [self pageControlIndexWithCurrentItemIndex:[self currentItemIndex]];
    self.pageControll.currentPage = currentPage;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self invalidateTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setupTimer];
}

@end
