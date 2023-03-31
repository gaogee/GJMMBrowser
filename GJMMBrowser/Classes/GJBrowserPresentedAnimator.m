//
//  GJBrowserPresentedAnimator.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/24.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJBrowserPresentedAnimator.h"
@implementation GJBrowserPresentedAnimator

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return .4;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = [transitionContext containerView];
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    toView.hidden = YES;
    [containerView addSubview:toView];
    
    UIView *bgView = [[UIView alloc] initWithFrame:containerView.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0;
    [containerView addSubview:bgView];
    
    CGRect fromFrame = self.transitionParameter.firstVcImageFrame;
    CGRect toFrame = self.transitionParameter.secondVcImageFrame;
    
    UIImageView *transitionImgView = [[UIImageView alloc] initWithImage:self.transitionParameter.transitionImage];
    transitionImgView.layer.masksToBounds = YES;
    transitionImgView.contentMode = UIViewContentModeScaleAspectFill;
    transitionImgView.frame = fromFrame;
    [containerView addSubview:transitionImgView];
    
    UIView *navBarView = self.transitionParameter.navBarView;
    [containerView addSubview:navBarView];
    
    UIView *footerContentView = self.transitionParameter.footerContentView;
    [containerView addSubview:footerContentView];
    
    navBarView.transform = CGAffineTransformMakeTranslation(0, -navBarView.bounds.size.height);
    footerContentView.transform = CGAffineTransformMakeTranslation(0, footerContentView.bounds.size.height);
   
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        transitionImgView.frame = toFrame;
        bgView.alpha = 1;
        navBarView.transform = CGAffineTransformIdentity;
        footerContentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        toView.hidden = NO;
        [bgView removeFromSuperview];
        [transitionImgView removeFromSuperview];
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
