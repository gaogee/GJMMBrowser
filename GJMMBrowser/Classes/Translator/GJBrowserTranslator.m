//
//  GJBrowserTranslator.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/24.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJBrowserTranslator.h"
@interface GJBrowserTranslator ()
@property (nonatomic, strong) GJBrowserPresentedAnimator *presentedAnimator;
@property (nonatomic, strong) GJBrowserDismissedAnimator *dismissedAnimator;
@property (nonatomic, strong) GJBrowserTransitionDriver *transitionDriver;
@end
@implementation GJBrowserTranslator
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.presentedAnimator;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self.dismissedAnimator;
}
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    return nil;
}
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.transitionParameter.gestureRecognizer?self.transitionDriver:nil;
}
-(GJBrowserPresentedAnimator *)presentedAnimator{
    if (!_presentedAnimator){
        _presentedAnimator = [[GJBrowserPresentedAnimator alloc] init];
    }
    return _presentedAnimator;
}
-(GJBrowserDismissedAnimator *)dismissedAnimator{
    if (!_dismissedAnimator){
        _dismissedAnimator = [[GJBrowserDismissedAnimator alloc] init];
    }
    return _dismissedAnimator;
}

-(GJBrowserTransitionDriver *)transitionDriver{
    if (!_transitionDriver){
        _transitionDriver = [[GJBrowserTransitionDriver alloc] initWithTransitionParameter:self.transitionParameter];
    }
    return _transitionDriver;
}
-(void)setTransitionParameter:(GJBrowseTransitionParameter *)transitionParameter{
    _transitionParameter = transitionParameter;
    self.presentedAnimator.transitionParameter = transitionParameter;
    self.dismissedAnimator.transitionParameter = transitionParameter;
}
@end
