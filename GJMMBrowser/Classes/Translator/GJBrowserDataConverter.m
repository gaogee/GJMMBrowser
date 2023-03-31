//
//  GJBrowserDataConverter.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/29.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJBrowserDataConverter.h"

@implementation GJBrowserDataConverter

+(void)makePresentedDataWithResources:(NSArray *)resources elements:(id)elements index:(NSInteger)index result:(void(^)(GJBrowseTransitionParameter *transitionParameter ,GJBrowserTranslator *translator ,NSArray<GJMultiMediaResoucre *> *models))result{
    //模型构造
    __block NSArray<GJMultiMediaResoucre *> *_models;
    __block CGRect _formFrame = CGRectZero;
    __block UIImage *_firstImage;
    __block CGFloat _cornerRadius = 0.0f;
    [self makeModelsWithResources:resources result:^(NSArray<GJMultiMediaResoucre *> *models) {
        _models = models;
    }];
    //数据构造
    [self makeDataWithElements:elements index:index result:^(CGRect formFrame, UIImage *firstImage, CGFloat cornerRadius) {
        _formFrame = formFrame;
        _firstImage = firstImage;
        _cornerRadius = cornerRadius;
    }];
    
    //参数构造
    GJBrowseTransitionParameter *_transitionParameter = [[GJBrowseTransitionParameter alloc] init];
    _transitionParameter.browsingImageIndex = index;
    _transitionParameter.firstVcImageFrame = _formFrame;
    _transitionParameter.transitionImage = _firstImage;
    _transitionParameter.firstVcImageCornerRadius = _cornerRadius;
    //动画构造
    GJBrowserTranslator *_translator = [[GJBrowserTranslator alloc]init];
    _translator.transitionParameter = _transitionParameter;
    
    result(_transitionParameter,_translator,_models);
}
//present 模型构造
+(void)makeModelsWithResources:(NSArray *)resources result:(void(^)(NSArray<GJMultiMediaResoucre *> *models))result{
    NSMutableArray *models = [NSMutableArray new];
    [resources enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger i, BOOL * _Nonnull stop) {
        GJMultiMediaResoucre *model = [[GJMultiMediaResoucre alloc] init];
        if ([obj isKindOfClass:NSString.class]){
            if([obj containsString:@"http"]){
                model.imgUrl = obj;
            }
        }else if ([obj isKindOfClass:UIImage.class]){
            model.image = obj;
        }
        [models addObject:model];
    }];
    result(models);
}
//present 数据构造
+ (void)makeDataWithElements:(id)elements index:(NSInteger)index result:(void(^)(CGRect formFrame, UIImage * firstImage, CGFloat cornerRadius))result{
    __block UIImage * firstImage = [UIImage new];
    __block CGFloat cornerRadius = 0;
    __block CGRect frame = CGRectZero;
    __block UIImageView *imageView;
    if([elements isKindOfClass:NSArray.class]){
        NSArray *formViews = elements;
        UIView *fromView = formViews[index];
        if ([fromView isKindOfClass:UIImageView.class]){
            UIImageView *imageView = (UIImageView *)fromView;
            frame = [imageView.superview convertRect:fromView.frame toView:GJMBWindow];
            firstImage = imageView.image;
            cornerRadius = imageView.layer.cornerRadius;
        }else  if ([fromView isKindOfClass:UIButton.class]){
            UIButton *button = (UIButton *)fromView;
            frame = [button.superview convertRect:fromView.frame toView:GJMBWindow];
            firstImage = button.imageView.image;
            cornerRadius = button.layer.cornerRadius;
        }
    }else if([elements isKindOfClass:UIView.class]){
        UIView* formView = elements;
        UIView *newView;
        if ([formView isKindOfClass:UICollectionView.class]){
            UICollectionViewCell *cell = (UICollectionViewCell *)[(UICollectionView *)formView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
            newView = cell;
        }else if ([formView isKindOfClass:UITableView.class]){
            UITableViewCell *cell = (UITableViewCell *)[(UITableView *)formView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
            newView = cell;
        }else if ([formView isKindOfClass:UIScrollView.class]||[formView isKindOfClass:UIView.class]){
            UIView *subView = formView.subviews[index];
            if ([subView isKindOfClass:UIImageView.class]){
                imageView = (UIImageView *)subView;
                newView = nil;
            }else{
                newView = subView;
            }
        }else{
            
        }
        if(newView){
            [newView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"accessibilityIdentifier:%@",obj.accessibilityIdentifier);
                if([obj isKindOfClass:UIImageView.class]){
                    if (obj) {
                        imageView = obj;
                        *stop = YES;
                    }
                }
            }];
        }
        frame = [imageView.superview convertRect:imageView.frame toView:GJMBWindow];
        firstImage = imageView.image;
        cornerRadius = imageView.layer.cornerRadius;
    }
    result(frame, firstImage, cornerRadius);
}

//dismiss 函数构造
+ (void)makeDismissedDataWithElements:(id)elements index:(NSInteger)index result:(void(^)(CGRect firstVcImageFrame))result{
    if([elements isKindOfClass:NSArray.class]){
        NSArray *formViews = elements;
        if (formViews.count) {
            UIView *formView = formViews[index];
            CGRect frame = [formView.superview convertRect:formView.frame toView:GJMBWindow];
            result(frame);
        }
    }else if([elements isKindOfClass:UIView.class]){
        UIView *formView = elements;
        __block CGRect frame = CGRectZero;
    
        if([formView isKindOfClass:UICollectionView.class]){
            [UIView animateWithDuration:0 animations:^{
                [(UICollectionView *)formView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            } completion:^(BOOL finished) {
                UICollectionViewCell * cell = (UICollectionViewCell *)[(UICollectionView *)formView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
                [cell.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if([obj isKindOfClass:UIImageView.class]){
                        frame = [obj.superview convertRect:obj.frame toView:GJMBWindow];
                    }
                }];
                result(frame);
            }];
        }else if([formView isKindOfClass:UITableView.class]){
            [UIView animateWithDuration:0 animations:^{
                [(UITableView *)formView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
            } completion:^(BOOL finished) {
                UITableViewCell * cell = (UITableViewCell *)[(UITableView *)formView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
                [cell.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if([obj isKindOfClass:UIImageView.class]){
                        frame = [obj.superview convertRect:obj.frame toView:GJMBWindow];
                    }
                }];
                result(frame);
            }];
        }else if([formView isKindOfClass:UIScrollView.class]){
            UIScrollView *scrollView = (UIScrollView *)formView;
            UIView *subView = scrollView.subviews[index];
            __block UIImageView *imageView;
            [UIView animateWithDuration:0 animations:^{
                if ([subView isKindOfClass:UIImageView.class]){
                    imageView = (UIImageView *)subView;
                }else{
                    [subView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if([obj isKindOfClass:UIImageView.class]){
                            imageView = (UIImageView *)obj;
                            *stop = YES;
                        }
                    }];
                    CGRect f = scrollView.frame;
                    f.origin.y = scrollView.contentOffset.y;
                    CGRect r = imageView.frame;
                    if(!CGRectIntersectsRect(f, r)) {
                        CGFloat newContentOffsetY = 0.0f;
                        if(imageView.frame.origin.y>scrollView.contentOffset.y){
                            newContentOffsetY =imageView.bounds.size.height+imageView.frame.origin.y-scrollView.frame.size.height;
                        }else{
                            newContentOffsetY = imageView.frame.origin.y;
                        }
                        [scrollView setContentOffset:CGPointMake(0, newContentOffsetY) animated:NO];
                    }
                }
                frame = [imageView.superview convertRect:imageView.frame toView:GJMBWindow];
            } completion:^(BOOL finished) {
                result(frame);
            }];
        }else if([formView isKindOfClass:UIView.class]){
            UIView *subView = formView.subviews[index];
            __block UIImageView *imageView;
            if ([subView isKindOfClass:UIImageView.class]){
                imageView = (UIImageView *)subView;
            }else{
                [subView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if([obj isKindOfClass:UIImageView.class]){
                        imageView = obj;
                        *stop = YES;
                    }
                }];
            }
            frame = [imageView.superview convertRect:imageView.frame toView:GJMBWindow];
            result(frame);
        }
    }
}
@end

