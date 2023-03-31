//
//  GJBrowseTransitionParameter.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/27.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJBrowseTransitionParameter.h"
#import "GJMultiMediaBrowserHelper.h"
@implementation GJBrowseTransitionParameter
- (void)setTransitionImage:(UIImage *)transitionImage{
    _transitionImage = transitionImage;
    _secondVcImageFrame = [self backScreenImageViewRectWithImage:transitionImage];
}
- (void)setbrowsingImageIndex:(NSInteger)browsingImageIndex{
    _browsingImageIndex = browsingImageIndex;
}

//返回imageView在window上全屏显示时的frame
- (CGRect)backScreenImageViewRectWithImage:(UIImage *)image{
    CGSize size = image.size;
    CGSize newSize;
    newSize.width = GJMMBScreen_W;
    newSize.height = newSize.width / size.width * size.height;
    
    CGFloat imageY = (GJMMBScreen_H - newSize.height) * 0.5;
    
    if (imageY < 0) {
        imageY = 0;
    }
    CGRect rect =  CGRectMake(0, imageY, newSize.width, newSize.height);
    
    return rect;
}
@end
