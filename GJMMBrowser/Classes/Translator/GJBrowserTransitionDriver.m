//
//  GJBrowserTransitionDriver.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/24.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJBrowserTransitionDriver.h"
#import "GJMultiMediaBrowserHelper.h"
@interface GJBrowserTransitionDriver ()

@property (nonatomic, strong) GJBrowseTransitionParameter *transitionParameter;

@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *gestureRecognizer;

@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIView *fromView;

@property(nonatomic, strong) UIView *blackbgView;

@end

@implementation GJBrowserTransitionDriver

- (instancetype)initWithTransitionParameter:(GJBrowseTransitionParameter *)transitionParameter{
    self = [super init];
    if (self){
        _transitionParameter = transitionParameter;
        _gestureRecognizer = transitionParameter.gestureRecognizer;
        [_gestureRecognizer addTarget:self action:@selector(gestureRecognizeDidUpdate:)];
    }
    return self;
}

- (CGFloat)percentForGesture:(UIPanGestureRecognizer *)gesture{
    CGPoint translation = [gesture translationInView:gesture.view];
    CGFloat scale = 1 - (translation.y / GJMMBScreen_H);
    scale = scale < 0 ? 0 : scale;
    scale = scale > 1 ? 1 : scale;
    return scale;
}

- (void)gestureRecognizeDidUpdate:(UIPanGestureRecognizer *)gestureRecognizer{
    CGFloat scrale = [self percentForGesture:gestureRecognizer];
    switch (gestureRecognizer.state){
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
            
            [self updateInteractiveTransition:[self percentForGesture:gestureRecognizer]];
            [self updateInterPercent:[self percentForGesture:gestureRecognizer]];
            
            break;
        case UIGestureRecognizerStateEnded:
            
            if (scrale > 0.95f){
                
                [self cancelInteractiveTransition];
                [self interPercentCancel];
            }
            else{
                [self finishInteractiveTransition];
                [self interPercentFinish:scrale];
            }
            break;
        default:
            [self cancelInteractiveTransition];
            [self interPercentCancel];
            break;
    }
}

- (void)beginInterPercent{
    id<UIViewControllerContextTransitioning> transitionContext = self.transitionContext;
    UIView *containerView = [transitionContext containerView];
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    [containerView addSubview:toView];
    
    _blackbgView = [[UIView alloc] initWithFrame:containerView.bounds];
    _blackbgView.backgroundColor = [UIColor blackColor];
    [containerView addSubview:_blackbgView];
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    fromView.backgroundColor = [UIColor clearColor];
    [containerView addSubview:fromView];
}

- (void)updateInterPercent:(CGFloat)scale{
    _blackbgView.alpha = scale * scale * scale;
}

- (void)interPercentCancel{
    id<UIViewControllerContextTransitioning> transitionContext = self.transitionContext;
    UIView *containerView = [transitionContext containerView];
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    fromView.backgroundColor = [UIColor blackColor];
    [containerView addSubview:fromView];
    
    [_blackbgView removeFromSuperview];
    _blackbgView = nil;
    
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
}
- (void)interPercentFinish:(CGFloat)scale{
    id<UIViewControllerContextTransitioning> transitionContext = self.transitionContext;
    UIView *containerView = [transitionContext containerView];
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    [containerView addSubview:toView];
    
    UIView *bgView = [[UIView alloc] initWithFrame:containerView.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = scale;
    [containerView addSubview:bgView];
   
    CGRect fromFrame = self.transitionParameter.currentPanGestImageFrame;
    CGRect toFrame = self.transitionParameter.firstVcImageFrame;
    
    UIImageView *transitionImgView = [[UIImageView alloc] initWithImage:self.transitionParameter.transitionImage];
    transitionImgView.layer.masksToBounds = YES;
    transitionImgView.contentMode = UIViewContentModeScaleAspectFill;
    transitionImgView.frame = fromFrame;
    [containerView addSubview:transitionImgView];
    
    [UIView animateWithDuration:.5 animations:^{
        transitionImgView.frame = toFrame;
        transitionImgView.layer.cornerRadius = 20;
        bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.blackbgView removeFromSuperview];
        self.blackbgView = nil;
        
        [bgView removeFromSuperview];
        [transitionImgView removeFromSuperview];
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    [self beginInterPercent];
}
- (void)dealloc{
    [self.gestureRecognizer removeTarget:self action:@selector(gestureRecognizeDidUpdate:)];
}
@end
