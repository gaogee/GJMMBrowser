//
//  GJMultiMediaBrowserHelper.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/27.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJMultiMediaBrowserHelper.h"

@implementation GJMultiMediaBrowserHelper
+(UIViewController *)getCurrentViewController{
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    UIViewController *vc = window.rootViewController;
    while (1){
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
            
        } else if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
            
        } else if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
            
        } else if (vc.childViewControllers.count > 0) {
            //如果是普通控制器，找childViewControllers最后一个
            vc = [vc.childViewControllers lastObject];
            
        } else {
            break;
        }
    }
    return vc;
}

+(UIImage *)getImageFormBundleWithImageName:(NSString *)imageName{
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    NSString *currentBundleName = currentBundle.infoDictionary[@"CFBundleName"];
    NSString *imagePath = [currentBundle pathForResource:imageName ofType:nil inDirectory:[NSString stringWithFormat:@"%@.bundle",currentBundleName]];
    return [UIImage imageWithContentsOfFile:imagePath];
}

@end
