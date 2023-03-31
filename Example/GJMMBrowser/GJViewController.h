//
//  GJViewController.h
//  GJMultiMediaBrowser
//
//  Created by gaogee on 03/24/2023.
//  Copyright (c) 2023 gaogee. All rights reserved.
//

@import UIKit;
@class GJTestTableViewCell;
@class GJTestTableHeaderView;
@interface GJViewController : UIViewController

@end

@interface GJTestTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel * titleLb;
@property (nonatomic, strong) UIView * line;
@end

@interface GJTestTableHeaderView: UIView
@property (nonatomic, strong) UILabel * titleLb;
@end
