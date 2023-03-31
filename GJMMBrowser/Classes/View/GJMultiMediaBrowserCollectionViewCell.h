//
//  GJMultiMediaBrowserCollectionViewCell.h
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/24.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJMultiMediaBrowserZoomScrollView.h"
#import "GJMultiMediaResoucre.h"
NS_ASSUME_NONNULL_BEGIN
@protocol GJMultiMediaBrowserCollectionViewCellDelegate <NSObject>

- (void)imageViewClick:(NSInteger)cellIndex;

@end
@interface GJMultiMediaBrowserCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, weak)   id <GJMultiMediaBrowserCollectionViewCellDelegate> delegate;
@property (nonatomic, assign) NSInteger cellIndex;
@property (nonatomic, strong) GJMultiMediaBrowserZoomScrollView *zoomScrollView;

- (void)showWithModel:(GJMultiMediaResoucre *)model;
@end

NS_ASSUME_NONNULL_END
