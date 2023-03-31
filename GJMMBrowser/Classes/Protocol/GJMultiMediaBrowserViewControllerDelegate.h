//
//  GJMultiMediaBrowserViewControllerDelegate.h
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/29.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GJMultiMediaBrowserViewControllerDelegate <NSObject>
-(void)browserView:(UIView *)browserView didSelectItem:(UIView *)itme index:(NSInteger)index;
-(void)browserView:(UIView *)browserView didScrollItem:(UIView *)itme index:(NSInteger)index;
-(void)browserView:(UIView *)browserView draggingItem:(UIView *)itme index:(NSInteger)index;
-(void)browserView:(UIView *)browserView didEndDraggingItem:(UIView *)itme index:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
