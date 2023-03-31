//
//  GJBrowseTransitionParameter.h
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/27.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJMultiMediaBrowserNavBarView.h"
NS_ASSUME_NONNULL_BEGIN

@interface GJBrowseTransitionParameter : NSObject
/*
 firstVC : 发起查看图片浏览器的界面
 secondVC: 图片浏览器界面
 */

///转场过渡的图片
@property (nonatomic, strong) UIImage *transitionImage;
///正在浏览的图片下标
@property (nonatomic, assign) NSInteger browsingImageIndex;

///firstVC 上所显示的图片frame
@property (nonatomic, assign) CGRect  firstVcImageFrame;
///firstVC 上所显示的图片圆角
@property (nonatomic, assign) CGFloat firstVcImageCornerRadius;
///secondVC上所显示的图片frame
@property (nonatomic, assign, readonly) CGRect secondVcImageFrame;

///滑动返回手势
@property (nonatomic, strong) UIPanGestureRecognizer * __nullable gestureRecognizer;
///当前滑动时，对应图片的frame
@property (nonatomic, assign) CGRect currentPanGestImageFrame;

@property (nonatomic, strong) GJMultiMediaBrowserNavBarView *navBarView;
@property (nonatomic, strong) UIView *footerContentView;
@end

NS_ASSUME_NONNULL_END
