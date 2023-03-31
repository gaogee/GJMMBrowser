//
//  GJLocalPicturesViewController.h
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/28.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GJLocalPicturesView;
@interface GJLocalPicturesViewController : UIViewController

@end

@interface GJLocalPicturesView : UIView
@property (nonatomic, strong) NSArray *resoucres;
@end
NS_ASSUME_NONNULL_END
