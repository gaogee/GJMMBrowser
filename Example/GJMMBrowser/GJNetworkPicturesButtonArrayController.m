//
//  GJNetworkPicturesButtonArrayController.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/29.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJNetworkPicturesButtonArrayController.h"
#import "GJMMBrowser.h"
@interface GJNetworkPicturesButtonArrayController ()
@property (nonatomic, strong) NSArray *resoucres;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray<UIButton *> *viewArray;
@end

@implementation GJNetworkPicturesButtonArrayController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    [self creatImageViewsWithResoucres:self.resoucres];
}

-(UIScrollView *)scrollView{
    if (!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.bounds.size.height+[UIApplication sharedApplication].statusBarFrame.size.height, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.bounds.size.height-[UIApplication sharedApplication].statusBarFrame.size.height)];
        _scrollView.backgroundColor = UIColor.whiteColor;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.alwaysBounceVertical = YES;
    }
    return _scrollView;
}
-(void)creatImageViewsWithResoucres:(NSArray *)resoucres{
    self.viewArray = [NSMutableArray array];
    _resoucres = resoucres;
    //    总列数
    int totalColumns = 2;
    //    竖直间隙
    CGFloat verticalMargin = 10;
    //    水平间隙
    CGFloat transverseMargin = 10;
    //    每一格的尺寸
    CGFloat cellW = (self.scrollView.frame.size.width-(totalColumns+1)*verticalMargin)/totalColumns;
    CGFloat cellH = cellW;
    [self.scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, resoucres.count/totalColumns*(cellH+verticalMargin))];
    //根据格子个数创建对应的框框
    for(int index = 0; index< resoucres.count; index++) {
        UIButton *cellView = [[UIButton alloc]init];
        cellView.layer.cornerRadius = 10;
        cellView.layer.masksToBounds = YES;
        cellView.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cellView.tag = index;
        [cellView yy_setImageWithURL:[NSURL URLWithString:self.resoucres[index]] forState:0 placeholder:[UIImage imageNamed:@"default_icon"]];
        int row = index / totalColumns;
        int col = index % totalColumns;
        CGFloat cellX = verticalMargin + col * (cellW + verticalMargin);
        CGFloat cellY = row * (cellH + transverseMargin);
        cellView.frame = CGRectMake(cellX, cellY, cellW, cellH);
        
        [cellView addTarget:self action:@selector(cellViewTapClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:cellView];
        [self.viewArray addObject:cellView];
    }
}
-(void)cellViewTapClick:(UIButton *)sender{
    GJMMBrowser *mBrowser = [[GJMMBrowser alloc]init];
    mBrowser.resources = self.resoucres;
    mBrowser.elements = self.viewArray;
    mBrowser.currentPage = sender.tag;
    [mBrowser openBrowser];
}

-(NSArray *)resoucres{
    if (!_resoucres) {
        _resoucres = @[@"https://img2.baidu.com/it/u=388167114,1937204950&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500",
                       @"https://img2.baidu.com/it/u=1900846961,549963898&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500",
                       @"https://hbimg.b0.upaiyun.com/7f1496b955d84bf4517b0f5c3aaa8eb7fb4c7ee244a3f-1GXJEn_fw658",
                       @"https://hbimg.huaban.com/83010edad8c799f432ca3bd000c8db42dcf402654c184-ap0v9V_fw658",
                       @"https://img2.baidu.com/it/u=2017977177,3686712174&fm=253&fmt=auto&app=120&f=JPEG?w=1280&h=800",
                       @"https://img2.baidu.com/it/u=3780423750,3646253537&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1082"];
    }
    return _resoucres;
}

@end
