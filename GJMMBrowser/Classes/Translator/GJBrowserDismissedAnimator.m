//
//  GJBrowserDismissedAnimator.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/24.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJBrowserDismissedAnimator.h"
#import "GJMultiMediaBrowserHelper.h"
@implementation GJBrowserDismissedAnimator
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return .4;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *containerView = [transitionContext containerView];
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [containerView addSubview:toViewController.view];
    
    UIView *bgView = [[UIView alloc] initWithFrame:containerView.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 1;
    [containerView addSubview:bgView];
    
    CGRect fromFrame = self.transitionParameter.secondVcImageFrame;
    CGRect toFrame = self.transitionParameter.firstVcImageFrame;
    
    UIView *transitionImgView = [[UIImageView alloc] initWithImage:self.transitionParameter.transitionImage];
    transitionImgView.layer.masksToBounds = YES;
    transitionImgView.contentMode = UIViewContentModeScaleAspectFill;
    transitionImgView.frame = fromFrame;
    [containerView addSubview:transitionImgView];
    
    UIView *navBarView = self.transitionParameter.navBarView;
    [containerView addSubview:navBarView];
    
    UIView *footerContentView = self.transitionParameter.footerContentView;
    [containerView addSubview:footerContentView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        CGRect imageFrame = toFrame;
        if (imageFrame.size.width == 0 && imageFrame.size.height == 0) {
            CGFloat defaultWidth = 5;
            imageFrame = CGRectMake((GJMMBScreen_W - defaultWidth) * 0.5, (GJMMBScreen_H - defaultWidth) * 0.5, defaultWidth, defaultWidth);
        }
        
        transitionImgView.frame = imageFrame;
        transitionImgView.layer.cornerRadius = 20;
        bgView.alpha = 0;
        navBarView.transform = CGAffineTransformMakeTranslation(0, -navBarView.bounds.size.height);
        footerContentView.transform = CGAffineTransformMakeTranslation(0, footerContentView.bounds.size.height);
        
    }completion:^(BOOL finished) {
        [navBarView removeFromSuperview];
        [footerContentView removeFromSuperview];
        [bgView removeFromSuperview];
        [transitionImgView removeFromSuperview];
        
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
