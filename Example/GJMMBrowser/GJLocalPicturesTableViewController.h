//
//  GJLocalPicturesTableViewController.h
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/28.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GJLocalPicturesTableViewCell;
@interface GJLocalPicturesTableViewController : UIViewController

@end

@interface GJLocalPicturesTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *imgView;
@end
NS_ASSUME_NONNULL_END
