//
//  GJGIFViewController.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/31.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJGIFViewController.h"
#import "GJMMBrowser.h"
@interface GJGIFViewController ()
@property (nonatomic, strong) NSArray *resoucres;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation GJGIFViewController

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
        UIImageView *cellView = [[UIImageView alloc]init];
        cellView.layer.cornerRadius = 10;
        cellView.layer.masksToBounds = YES;
        cellView.contentMode = UIViewContentModeScaleAspectFill;
        cellView.tag = index;
        cellView.image = resoucres[index];
        int row = index / totalColumns;
        int col = index % totalColumns;
        CGFloat cellX = verticalMargin + col * (cellW + verticalMargin);
        CGFloat cellY = row * (cellH + transverseMargin);
        cellView.frame = CGRectMake(cellX, cellY, cellW, cellH);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellViewTapClick:)];
        cellView.userInteractionEnabled = YES;
        [cellView addGestureRecognizer:tap];
        
        [self.scrollView addSubview:cellView];
    }
}
-(void)cellViewTapClick:(UIGestureRecognizer *)sender{
    GJMMBrowser *mBrowser = [[GJMMBrowser alloc]init];
    mBrowser.resources = self.resoucres;
    mBrowser.elements = self.scrollView;
    mBrowser.currentPage = sender.view.tag;
    [mBrowser openBrowser];
}

-(NSArray *)resoucres{
    if(!_resoucres){
        _resoucres = @[[UIImage imageNamed:@"test01"],[UIImage gj_animatedGIFNamed:@"test20"],[UIImage imageNamed:@"test02"],
                       [UIImage imageNamed:@"test03"],[UIImage imageNamed:@"test04"],[UIImage gj_animatedGIFNamed:@"test21"],
                       [UIImage imageNamed:@"test05"],[UIImage imageNamed:@"test06"],[UIImage imageNamed:@"test07"],
                       [UIImage imageNamed:@"test08"],[UIImage gj_animatedGIFNamed:@"test22"],[UIImage imageNamed:@"test09"],
                       [UIImage imageNamed:@"test10"],[UIImage imageNamed:@"test11"],[UIImage imageNamed:@"test12"]];
    }
    return _resoucres;
}
@end
