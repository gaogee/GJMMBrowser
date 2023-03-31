//
//  GJNetworkPicturesViewController.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/28.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJNetworkPicturesViewController.h"
#import "GJMMBrowser.h"
@interface GJNetworkPicturesViewController ()
@property (nonatomic, strong) NSArray *resoucres;
@end

@implementation GJNetworkPicturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GJNetworkPicturesView *v = [[GJNetworkPicturesView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.bounds.size.height+[UIApplication sharedApplication].statusBarFrame.size.height, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.bounds.size.height-[UIApplication sharedApplication].statusBarFrame.size.height)];
    v.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:v];
    v.resoucres = self.resoucres;
}
-(NSArray *)resoucres{
    if (!_resoucres) {
        _resoucres = @[@"https://img2.baidu.com/it/u=388167114,1937204950&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500",
                       @"https://img2.baidu.com/it/u=1900846961,549963898&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500",
                       @"https://hbimg.b0.upaiyun.com/7f1496b955d84bf4517b0f5c3aaa8eb7fb4c7ee244a3f-1GXJEn_fw658",
                       @"https://lmg.jj20.com/up/allimg/4k/s/02/2109251J1516427-0-lp.jpg",
                       @"https://lmg.jj20.com/up/allimg/4k/s/02/210924205029B91-0-lp.jpg",
                       @"https://img9.51tietu.net/pic/2019-091202/0taxjnzlv4w0taxjnzlv4w.jpg",
                       @"https://img9.51tietu.net/pic/2019-091117/5a2vmmi3q2h5a2vmmi3q2h.jpg",
                       @"https://hbimg.huaban.com/83010edad8c799f432ca3bd000c8db42dcf402654c184-ap0v9V_fw658",
                       @"https://img2.baidu.com/it/u=2017977177,3686712174&fm=253&fmt=auto&app=120&f=JPEG?w=1280&h=800",
                       @"https://img2.baidu.com/it/u=3780423750,3646253537&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1082"];
    }
    return _resoucres;
}

@end

@implementation GJNetworkPicturesView
-(void)setResoucres:(NSArray *)resoucres{
    _resoucres = resoucres;
    //    总列数
    int totalColumns = 3;
    //    竖直间隙
    CGFloat verticalMargin = 10;
    //    水平间隙
    CGFloat transverseMargin = 10;
    //    每一格的尺寸
    CGFloat cellW = (self.frame.size.width-(totalColumns+1)*verticalMargin)/totalColumns;
    CGFloat cellH = cellW;
    
    //根据格子个数创建对应的框框
    for(int index = 0; index< resoucres.count; index++) {
        UIImageView *cellView = [[UIImageView alloc]init];
        cellView.layer.cornerRadius = 10;
        cellView.layer.masksToBounds = YES;
        cellView.contentMode = UIViewContentModeScaleAspectFill;
        cellView.tag = index;
        [cellView yy_setImageWithURL:[NSURL URLWithString:self.resoucres[index]] placeholder:[UIImage imageNamed:@"default_icon"]];
        int row = index / totalColumns;
        int col = index % totalColumns;
        CGFloat cellX = verticalMargin + col * (cellW + verticalMargin);
        CGFloat cellY = row * (cellH + transverseMargin);
        cellView.frame = CGRectMake(cellX, cellY, cellW, cellH);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellViewTapClick:)];
        cellView.userInteractionEnabled = YES;
        [cellView addGestureRecognizer:tap];
        
        [self addSubview:cellView];
    }
}
-(void)cellViewTapClick:(UIGestureRecognizer *)sender{
    GJMMBrowser *mBrowser = [[GJMMBrowser alloc]init];
    mBrowser.resources = self.resoucres;
    mBrowser.elements = self;
    mBrowser.currentPage = sender.view.tag;
    [mBrowser openBrowser];
}
@end
