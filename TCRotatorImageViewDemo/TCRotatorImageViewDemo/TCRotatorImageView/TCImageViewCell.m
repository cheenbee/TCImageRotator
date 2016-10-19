//
//  TCImageViewCell.m
//  ScrollInfinite
//
//  Created by 艾呦呦 on 16/10/17.
//  Copyright © 2016年 艾呦呦. All rights reserved.
//

#import "TCImageViewCell.h"
#import "UIImageView+WebCache.h"

@interface TCImageViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TCImageViewCell



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
}

- (void)setImagePathStr:(NSString *)imagePathStr {
    _imagePathStr = imagePathStr;

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imagePathStr] placeholderImage:self.placeholderImage];
}

- (void)setLocalImageName:(NSString *)localImageName {
    _localImageName = localImageName;
    
    UIImage *image = [UIImage imageNamed:localImageName];
    if (!image) {
        image = [UIImage imageWithContentsOfFile:localImageName];
    }
    self.imageView.image = image;
}

@end
