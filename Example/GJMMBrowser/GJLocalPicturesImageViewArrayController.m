//
//  GJLocalPicturesImageViewArrayController.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/29.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJLocalPicturesImageViewArrayController.h"
#import "GJMMBrowser.h"
@interface GJLocalPicturesImageViewArrayController ()
@property (nonatomic, strong) NSArray *resoucres;
@property (nonatomic, strong) NSMutableArray<UIImageView *> *viewArray;
@end

@implementation GJLocalPicturesImageViewArrayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatImageViewsWithResoucres:self.resoucres];
}
-(void)creatImageViewsWithResoucres:(NSArray *)resoucres{
    self.viewArray = [NSMutableArray array];
    _resoucres = resoucres;
    //    总列数
    int totalColumns = 5;
    //    竖直间隙
    CGFloat verticalMargin = 10;
    //    水平间隙
    CGFloat transverseMargin = 10;
    //    每一格的尺寸
    CGFloat cellW = (self.view.frame.size.width-(totalColumns+1)*verticalMargin)/totalColumns;
    CGFloat cellH = cellW;
    CGFloat topH = self.navigationController.navigationBar.bounds.size.height+[UIApplication sharedApplication].statusBarFrame.size.height;
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
        cellView.frame = CGRectMake(cellX, topH+cellY, cellW, cellH);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellViewTapClick:)];
        cellView.userInteractionEnabled = YES;
        [cellView addGestureRecognizer:tap];
        
        [self.view addSubview:cellView];
        [self.viewArray addObject:cellView];
    }
}
-(void)cellViewTapClick:(UIGestureRecognizer *)sender{
    GJMMBrowser *mBrowser = [[GJMMBrowser alloc]init];
    mBrowser.resources = self.resoucres;
    mBrowser.elements = self.viewArray;
    mBrowser.currentPage = sender.view.tag;
    [mBrowser openBrowser];
}

-(NSArray *)resoucres{
    if(!_resoucres){
        _resoucres = @[[UIImage imageNamed:@"test01"],[UIImage imageNamed:@"test02"],[UIImage imageNamed:@"test03"],[UIImage imageNamed:@"test04"],
                       [UIImage imageNamed:@"test05"],[UIImage imageNamed:@"test06"],[UIImage imageNamed:@"test07"],[UIImage imageNamed:@"test08"],
                       [UIImage imageNamed:@"test09"],[UIImage imageNamed:@"test10"],[UIImage imageNamed:@"test11"],[UIImage imageNamed:@"test12"]];
    }
    return _resoucres;
}
@end
