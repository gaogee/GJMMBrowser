//
//  GJBrowserTranslator.h
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/24.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJBrowserPresentedAnimator.h"
#import "GJBrowserDismissedAnimator.h"
#import "GJBrowserTransitionDriver.h"
#import "GJBrowseTransitionParameter.h"
NS_ASSUME_NONNULL_BEGIN

@interface GJBrowserTranslator : NSObject<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) GJBrowseTransitionParameter *transitionParameter;
@end

NS_ASSUME_NONNULL_END
