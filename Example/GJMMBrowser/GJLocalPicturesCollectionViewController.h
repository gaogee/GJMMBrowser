//
//  GJLocalPicturesCollectionViewController.h
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/27.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GJLocalPicturesCollectionViewCell;
NS_ASSUME_NONNULL_BEGIN

@interface GJLocalPicturesCollectionViewController : UIViewController

@end
@interface GJLocalPicturesCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView * imageView;
@end
NS_ASSUME_NONNULL_END
