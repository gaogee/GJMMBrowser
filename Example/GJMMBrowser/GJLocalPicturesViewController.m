//
//  GJLocalPicturesViewController.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/28.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJLocalPicturesViewController.h"
#import "GJMMBrowser.h"
@interface GJLocalPicturesViewController ()
@property (nonatomic, strong) NSArray *resoucres;
@end

@implementation GJLocalPicturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GJLocalPicturesView *v = [[GJLocalPicturesView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.bounds.size.height+[UIApplication sharedApplication].statusBarFrame.size.height, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.bounds.size.height-[UIApplication sharedApplication].statusBarFrame.size.height)];
    v.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:v];
    v.resoucres = self.resoucres;
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

@implementation GJLocalPicturesView
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
        cellView.image = resoucres[index];
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
