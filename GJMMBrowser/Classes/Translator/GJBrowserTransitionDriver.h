//
//  GJBrowserTransitionDriver.h
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/24.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJBrowseTransitionParameter.h"
NS_ASSUME_NONNULL_BEGIN

@interface GJBrowserTransitionDriver : UIPercentDrivenInteractiveTransition
- (instancetype)initWithTransitionParameter:(GJBrowseTransitionParameter*)transitionParameter;
@end

NS_ASSUME_NONNULL_END
