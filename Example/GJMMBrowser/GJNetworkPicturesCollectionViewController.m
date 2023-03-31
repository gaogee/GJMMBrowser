//
//  GJNetworkPicturesCollectionViewController.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/27.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJNetworkPicturesCollectionViewController.h"
#import "GJMMBrowser.h"
#import <YYWebImage/YYWebImage.h>
@interface GJNetworkPicturesCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *resoucres;
@end

@implementation GJNetworkPicturesCollectionViewController

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
        [_collectionView registerClass:GJNetworkPictureCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(GJNetworkPictureCollectionViewCell.class)];
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
    GJNetworkPictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(GJNetworkPictureCollectionViewCell.class) forIndexPath:indexPath];
    [cell.imageView yy_setImageWithURL:[NSURL URLWithString:self.resoucres[indexPath.item]] placeholder:[UIImage imageNamed:@"default_icon"]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GJMMBrowser *mBrowser = [[GJMMBrowser alloc]init];
    mBrowser.placeholderImage = [UIImage imageNamed:@"default_icon"];
    mBrowser.resources = self.resoucres;
    mBrowser.elements = collectionView;
    mBrowser.currentPage = indexPath.row;
    [mBrowser openBrowser];
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


@implementation GJNetworkPictureCollectionViewCell
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
    }
    return _imageView;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}
@end
