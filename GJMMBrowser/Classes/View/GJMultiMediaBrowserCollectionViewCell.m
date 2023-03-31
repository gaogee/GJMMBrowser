//
//  GJMultiMediaBrowserCollectionViewCell.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/24.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJMultiMediaBrowserCollectionViewCell.h"
#import "GJMultiMediaBrowserHelper.h"
#import <YYWebImage/YYWebImage.h>
@interface GJMultiMediaBrowserCollectionViewCell ()

@property (nonatomic, strong) GJMultiMediaResoucre *model;
@end
@implementation GJMultiMediaBrowserCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.zoomScrollView];
    }
    return self;
}

- (GJMultiMediaBrowserZoomScrollView *)zoomScrollView {
    if (!_zoomScrollView) {
        _zoomScrollView = [[GJMultiMediaBrowserZoomScrollView alloc]initWithFrame:CGRectMake(0, 0, GJMMBScreen_W, GJMMBScreen_H)];
        _zoomScrollView.backgroundColor = [UIColor clearColor];
        _zoomScrollView.zoomScale = 1.0f;
        
        __weak typeof(self)weakSelf = self;
        [_zoomScrollView setTapZoomImageViewBlock:^{
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(imageViewClick:)]) {
                [weakSelf.delegate imageViewClick:weakSelf.cellIndex];
            }
        }];
    }
    return _zoomScrollView;
}

#pragma mark - Public methods
- (void)showWithModel:(GJMultiMediaResoucre *)model {
    self.model = model;
    
    UIImageView *imageView = _zoomScrollView.zoomImageView;
    imageView.image = self.placeholderImage;
    [self setPictureImage:self.placeholderImage];
    
    if (model.image){
        imageView.image = model.image;
        [self setPictureImage:model.image];
        
    }
    
    if(model.imgUrl.length){
        [imageView yy_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholder:self.placeholderImage options:YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            if(!error){
               [self setPictureImage:image];
           }
        }];
    }
    
    if (model.imgUrl_thumb.length){
        [imageView yy_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholder:self.placeholderImage options:YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            if(!error){
               [self setPictureImage:image];
           }
        }];
    }
}
- (void)setPictureImage:(UIImage *)image{
    CGSize size = [self backImageSize:image];
    // 将scrollview的contentSize设置成缩放前
    _zoomScrollView.contentSize = CGSizeMake(size.width, size.height);
    _zoomScrollView.contentOffset = CGPointMake(0, 0);
    
    CGFloat imageY = (_zoomScrollView.frame.size.height - size.height) * 0.5;
    imageY = imageY > 0 ? imageY: 0;
    _zoomScrollView.zoomImageView.frame = CGRectMake(0, imageY, _zoomScrollView.frame.size.width, size.height);
}

- (CGSize)backImageSize:(UIImage *)image{
    CGSize size = image.size;
    CGSize newSize;
    newSize.width = GJMMBScreen_W;
    if(size.height){
        newSize.height = newSize.width / size.width * size.height;
    }else{
        newSize = self.placeholderImage.size;
    }
    return newSize;
}
-(UIImage *)placeholderImage{
    if (!_placeholderImage){
        _placeholderImage = [UIImage imageNamed:@"gj_transition_default_graph"];
    }
    return _placeholderImage;
}
@end
