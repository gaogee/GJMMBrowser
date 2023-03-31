//
//  GJMMBrowser.h
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/27.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJMultiMediaBrowserHelper.h"
#import "GJMultiMediaBrowserDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface GJMMBrowser : NSObject
/**
 需要浏览的资源
 @discussion 资源目前包括本地和网络的图片，本地和网络的视频，GIF图片
 */
@property (nonatomic, strong) NSArray *resources;
/**
 承载资源的控件元素
 @discussion 传入承载资源的控件元素，用来做过度动画
 1.发起浏览器的资源承载视图的超父/父视图，目前支持view，scrollView，tableView，collectionView
 2.发起浏览的资源承载视图数组，目前支持imageView数组，button数组
 **/
@property (nonatomic, strong) id elements;
/**
 当前资源承载视图的下标
 @discussion 点击的发起浏览的当前资源承载视图的下标
 */
@property (nonatomic, assign) NSInteger currentPage;
/**
 网络资源占位图
 @discussion 如果不传入网络资源占位图，则会使用默认的占位图
 */
@property (nonatomic, strong) UIImage *placeholderImage;
/**
 是否展示返回按钮
 @discussion 是否展示顶部的返回按钮，默认‘NO’
 */
@property (nonatomic, assign) BOOL isShowBackbutton;
/**
 是否展示页码指示器
 @discussion 是否展示顶部的页码指示器，默认‘NO’
 */
@property (nonatomic, assign) BOOL isShowPageIndicator;
/**
 自定义视图
 @discussion 底部自定义视图，传入自定义的视图，自定义的视图需要设置Frame
 */
@property (nonatomic, strong) UIView *footerContentView;
/**
 浏览器代理
 @discussion 浏览器代理，更具需要选择是否代理
 */
@property (nonatomic, weak, nullable) id <GJMultiMediaBrowserDelegate> delegate;

/**
 打开浏览器
 @discussion 打开浏览器前请先实现属性
 必须实现的3个属性：resources，elements，currentPage
*/
-(void)openBrowser;
/**
 关闭浏览器
 @discussion 浏览器关闭后，浏览器视上的所有视图被销毁
*/
-(void)closeBrowser;
@end

NS_ASSUME_NONNULL_END
