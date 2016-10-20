//
//  TCImageViewCell.h
//  ScrollInfinite
//
//  Created by cheenbee on 16/10/17.
//  Copyright © 2016年 cheenbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCImageViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imagePathStr;

@property (nonatomic, strong) UIImage *placeholderImage;

@property (nonatomic, copy) NSString *localImageName;

@end
