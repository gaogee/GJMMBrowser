//
//  GJMultiMediaBrowserZoomScrollView.h
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/24.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GJMultiMediaBrowserZoomScrollView : UIScrollView
@property (nonatomic,strong) UIImageView *zoomImageView;
@property (nonatomic,copy)   void (^tapZoomImageViewBlock)(void);
@end

NS_ASSUME_NONNULL_END
