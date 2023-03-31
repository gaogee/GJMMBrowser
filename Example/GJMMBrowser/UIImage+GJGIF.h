//
//  UIImage+GJGIF.h
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/30.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (GJGIF)
+ (UIImage *)gj_animatedGIFNamed:(NSString *)name;

+ (UIImage *)gj_animatedGIFWithData:(NSData *)data;

- (UIImage *)gj_animatedImageByScalingAndCroppingToSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
