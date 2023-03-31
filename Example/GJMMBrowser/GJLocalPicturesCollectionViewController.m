//
//  GJLocalPicturesCollectionViewController.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/27.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJLocalPicturesCollectionViewController.h"
#import "GJMMBrowser.h"
#import "GJCustomFooterContentView.h"
@interface GJLocalPicturesCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,GJMultiMediaBrowserDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *resoucres;
@property (nonatomic, strong) GJMMBrowser *mBrowser;
@end

@implementation GJLocalPicturesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.collectionView];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.bounds.size.height-[UIApplication sharedApplication].statusBarFrame.size.height) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:GJLocalPicturesCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(GJLocalPicturesCollectionViewCell.class)];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.resoucres.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake((self.view.bounds.size.width-10*3)/2, (self.view.bounds.size.width-10*3)/2);
    return size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GJLocalPicturesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(GJLocalPicturesCollectionViewCell.class) forIndexPath:indexPath];
    cell.imageView.image = self.resoucres[indexPath.item];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.mBrowser = [[GJMMBrowser alloc]init];
    self.mBrowser.delegate = self;
    self.mBrowser.isShowPageIndicator = YES;
    self.mBrowser.isShowBackbutton = YES;
    GJCustomFooterContentView *customView = [[GJCustomFooterContentView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    self.mBrowser.footerContentView = customView;
    self.mBrowser.resources = self.resoucres;
    self.mBrowser.elements = collectionView;
    self.mBrowser.currentPage = indexPath.row;
    [self.mBrowser openBrowser];
}
-(NSArray *)resoucres{
    if(!_resoucres){
        _resoucres = @[[UIImage imageNamed:@"test01"],[UIImage imageNamed:@"test02"],[UIImage imageNamed:@"test03"],[UIImage imageNamed:@"test04"],
                       [UIImage imageNamed:@"test05"],[UIImage imageNamed:@"test06"],[UIImage imageNamed:@"test07"],[UIImage imageNamed:@"test08"],
                       [UIImage imageNamed:@"test09"],[UIImage imageNamed:@"test10"],[UIImage imageNamed:@"test11"],[UIImage imageNamed:@"test12"]];
    }
    return _resoucres;
}
#pragma make -- GJMultimBrowserDelegate
-(void)browserView:(UIView *)browserView didSelectItem:(UIView *)itme index:(NSInteger)index{
    NSLog(@"[browser]点击了第%ld个",index);
}
-(void)browserView:(UIView *)browserView didScrollItem:(UIView *)itme index:(NSInteger)index{
    NSLog(@"[browser]滚动到第%ld个",index);
}
-(void)browserView:(UIView *)browserView draggingItem:(UIView *)itme index:(NSInteger)index{
    NSLog(@"[browser]正在拖拽第%ld个",index);
}
-(void)browserView:(UIView *)browserView didEndDraggingItem:(UIView *)itme index:(NSInteger)index{
    NSLog(@"[browser]结束拖拽第%ld个",index);
}
-(void)dealloc{
    NSLog(@"%s",__func__);
}
@end


@implementation GJLocalPicturesCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.imageView];
    }
    return self;
}
-(UIImageView *)imageView{
    if (!_imageView){
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.cornerRadius = 10;
        _imageView.layer.masksToBounds = YES;
        _imageView.accessibilityIdentifier = @"browserImageViewID";
    }
    return _imageView;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}
@end
