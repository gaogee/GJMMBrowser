//
//  GJMultiMediaBrowserZoomScrollView.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/24.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJMultiMediaBrowserZoomScrollView.h"
@interface GJMultiMediaBrowserZoomScrollView ()<UIScrollViewDelegate>
@property (nonatomic,assign)BOOL isSingleTap;
@end
@implementation GJMultiMediaBrowserZoomScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        _isSingleTap = NO;
        self.minimumZoomScale = 1.0f;
        self.maximumZoomScale = 3.0f;
        
        _zoomImageView = [[UIImageView alloc]init];
        _zoomImageView.userInteractionEnabled = YES;
        _zoomImageView.contentMode = UIViewContentModeScaleAspectFit;
        _zoomImageView.clipsToBounds = YES;
        [self addSubview:_zoomImageView];
    }
    return self;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _zoomImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGRect rect = _zoomImageView.frame;
    rect.origin.x = 0;
    rect.origin.y = 0;
    if (rect.size.width < self.frame.size.width) {
        rect.origin.x = floorf((self.frame.size.width - rect.size.width) / 2.0);
    }
    if (rect.size.height < self.frame.size.height) {
        rect.origin.y = floorf((self.frame.size.height - rect.size.height) / 2.0);
    }
    _zoomImageView.frame = rect;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    if(touch.tapCount == 1){
        [self performSelector:@selector(singleTapClick) withObject:nil afterDelay:0.2];
    }else if(touch.tapCount == 2){
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        if(!_isSingleTap){
            CGPoint touchPoint = [touch locationInView:_zoomImageView];
            [self zoomDoubleTapWithPoint:touchPoint];
        }
    }
}
- (void)zoomDoubleTapWithPoint:(CGPoint)touchPoint{
    if(self.zoomScale > self.minimumZoomScale){
        [self setZoomScale:self.minimumZoomScale animated:YES];
    }else{
        CGFloat width = self.bounds.size.width / self.maximumZoomScale;
        CGFloat height = self.bounds.size.height / self.maximumZoomScale;
        [self zoomToRect:CGRectMake(touchPoint.x - width / 2, touchPoint.y - height / 2, width, height) animated:YES];
    }
}
- (void)singleTapClick{
    _isSingleTap = YES;
    if (_tapZoomImageViewBlock) {
        _tapZoomImageViewBlock();
    }
}
@end
