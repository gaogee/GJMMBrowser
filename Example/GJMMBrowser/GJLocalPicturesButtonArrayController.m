//
//  GJLocalPicturesButtonArrayController.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/29.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJLocalPicturesButtonArrayController.h"
#import "GJMMBrowser.h"
@interface GJLocalPicturesButtonArrayController ()
@property (nonatomic, strong) NSArray *resoucres;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray<UIButton *> *viewArray;
@end

@implementation GJLocalPicturesButtonArrayController

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
    int totalColumns = 3;
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
        [cellView setImage:resoucres[index] forState:0];
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
    if(!_resoucres){
        _resoucres = @[[UIImage imageNamed:@"test01"],[UIImage imageNamed:@"test02"],
                                    [UIImage imageNamed:@"test03"],[UIImage imageNamed:@"test04"],
                                    [UIImage imageNamed:@"test05"],[UIImage imageNamed:@"test06"],[UIImage imageNamed:@"test07"],
                                    [UIImage imageNamed:@"test08"],[UIImage imageNamed:@"test09"],
                                    [UIImage imageNamed:@"test10"],[UIImage imageNamed:@"test11"],[UIImage imageNamed:@"test12"]];
    }
    return _resoucres;
}
@end
