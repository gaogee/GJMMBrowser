//
//  GJMultiMediaBrowserHelper.h
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/27.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYWebImage/YYWebImage.h>
#import "GJMultiMediaBrowserViewController.h"
#define GJMBWindow [UIApplication sharedApplication].delegate.window
#define GJMMBScreen_W ([UIScreen mainScreen].bounds.size.width)
#define GJMMBScreen_H ([UIScreen mainScreen].bounds.size.height)
#define GJMMNavH 44+[UIApplication sharedApplication].statusBarFrame.size.height
NS_ASSUME_NONNULL_BEGIN

@interface GJMultiMediaBrowserHelper : NSObject
+(UIViewController *)getCurrentViewController;
@end

NS_ASSUME_NONNULL_END
