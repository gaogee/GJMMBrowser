//
//  GJMultiMediaBrowserViewController.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/24.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJMultiMediaBrowserViewController.h"
#import "GJMultiMediaBrowserCollectionViewCell.h"
#import "GJBrowserDataConverter.h"
#import "GJMultiMediaBrowserNavBarView.h"
@interface GJMultiMediaBrowserViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,GJMultiMediaBrowserCollectionViewCellDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGPoint transitionImgViewCenter;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) GJMultiMediaBrowserCollectionViewCell * currentCell;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) GJMultiMediaBrowserNavBarView *navBarView;
@end

@implementation GJMultiMediaBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.navBarView];
    [self.view addSubview:self.footerContentView];
    self.translator.transitionParameter.navBarView = self.navBarView;
    self.translator.transitionParameter.footerContentView = self.footerContentView;
    self.navBarView.isShowBackbutton = self.isShowBackbutton;
    self.navBarView.isShowPageIndicator = self.isShowPageIndicator;
    if(!self.isShowBackbutton&&!self.isShowPageIndicator){
        self.navBarView.hidden = YES;
    }
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.translator.transitionParameter.browsingImageIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    UIPanGestureRecognizer *interactiveTransitionRecognizer;
    interactiveTransitionRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(interactiveTransitionRecognizerAction:)];
    [self.view addGestureRecognizer:interactiveTransitionRecognizer];
    
    [self.navBarView setPageCount:self.resoucreModels.count currentPage:self.translator.transitionParameter.browsingImageIndex];
}
-(GJMultiMediaBrowserNavBarView *)navBarView{
    if (!_navBarView){
        _navBarView = [[GJMultiMediaBrowserNavBarView alloc]initWithFrame:CGRectMake(0, 0, GJMMBScreen_W, GJMMNavH)];
        __weak typeof(self)weakSelf = self;
        [_navBarView setTapBackBtnBlock:^{
            [weakSelf closeBrowser];
        }];
    }
    return _navBarView;
}
-(void)setFooterContentView:(UIView *)footerContentView{
    _footerContentView = footerContentView;
    if (footerContentView){
        CGRect newFrame = CGRectMake(0, GJMMBScreen_H-_footerContentView.frame.size.height, _footerContentView.frame.size.width, _footerContentView.frame.size.height);
        [_footerContentView setFrame:newFrame];
    }
}
- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        [self.view addSubview:_imgView];
        [self.view bringSubviewToFront:self.navBarView];
        [self.view bringSubviewToFront:self.footerContentView];
    }
    return _imgView;
}
- (void)imageViewClick:(NSInteger)cellIndex{
    if (self.delegate && [self.delegate respondsToSelector:@selector(browserView:didSelectItem:index:)]) {
        [self.delegate browserView:self.collectionView didSelectItem:self.currentCell index:self.currentIndex];
    }
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, GJMMBScreen_W, GJMMBScreen_H) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:GJMultiMediaBrowserCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(GJMultiMediaBrowserCollectionViewCell.class)];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.resoucreModels.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    return size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GJMultiMediaBrowserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(GJMultiMediaBrowserCollectionViewCell.class) forIndexPath:indexPath];
    cell.placeholderImage = self.placeholderImage;
    [cell showWithModel:self.resoucreModels[indexPath.item]];
    cell.delegate = self;
    cell.cellIndex = indexPath.row;
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offset = _collectionView.contentOffset.x;
    NSInteger index = offset/scrollView.bounds.size.width;
    if (index == self.translator.transitionParameter.browsingImageIndex) {
        return;
    }
    [self setupBaseViewControllerProperty:index];
    [self.navBarView setPageCount:self.resoucreModels.count currentPage:self.translator.transitionParameter.browsingImageIndex];
    if (self.delegate && [self.delegate respondsToSelector:@selector(browserView:didScrollItem:index:)]) {
        [self.delegate browserView:self.collectionView didScrollItem:self.currentCell index:self.currentIndex];
    }
}
- (void)interactiveTransitionRecognizerAction:(UIPanGestureRecognizer *)gestureRecognizer{
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    CGFloat scale = 1 - (translation.y / GJMMBScreen_H);
    scale = scale < 0 ? 0 : scale;
    scale = scale > 1 ? 1 : scale;
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStatePossible:
            break;
        case UIGestureRecognizerStateBegan:{
            
            [self setupBaseViewControllerProperty:self.translator.transitionParameter.browsingImageIndex];
            self.collectionView.hidden = YES;
            self.imgView.hidden = NO;
            
            self.translator.transitionParameter.gestureRecognizer = gestureRecognizer;
            [self closeBrowser];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            _imgView.center = CGPointMake(self.transitionImgViewCenter.x + translation.x * scale, self.transitionImgViewCenter.y + translation.y);
            _imgView.transform = CGAffineTransformMakeScale(scale, scale);
            _navBarView.transform = CGAffineTransformMakeTranslation(0, _navBarView.frame.size.height*(scale-1)*8);
            _footerContentView.transform = CGAffineTransformMakeTranslation(0, _footerContentView.frame.size.height*(1-scale)*8);
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(browserView:draggingItem:index:)]) {
                [self.delegate browserView:self.collectionView draggingItem:self.currentCell index:self.currentIndex];
            }
            
            break;
        }
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            
            if (scale > 0.95f) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.imgView.center = self.transitionImgViewCenter;
                    self.imgView.transform = CGAffineTransformMakeScale(1, 1);
                    self.navBarView.transform = CGAffineTransformMakeTranslation(0, 0);
                    self.footerContentView.transform = CGAffineTransformMakeTranslation(0, 0);
                    
                } completion:^(BOOL finished) {
                    self.imgView.transform = CGAffineTransformIdentity;
                    self.navBarView.transform = CGAffineTransformIdentity;
                    self.footerContentView.transform = CGAffineTransformIdentity;
                }];
                self.collectionView.hidden = NO;
                self.imgView.hidden = YES;
            }else{
                self.navBarView.hidden = YES;
                self.footerContentView.hidden = YES;
            }
            self.translator.transitionParameter.transitionImage = _imgView.image;
            self.translator.transitionParameter.currentPanGestImageFrame = _imgView.frame;
            
            self.translator.transitionParameter.gestureRecognizer = nil;
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(browserView:didEndDraggingItem:index:)]) {
                [self.delegate browserView:self.collectionView didEndDraggingItem:self.currentCell index:self.currentIndex];
            }
        }
    }
}
/**关闭多媒体浏览器**/
-(void)closeBrowser{
    NSInteger cellIndex = self.translator.transitionParameter.browsingImageIndex;
    [GJBrowserDataConverter makeDismissedDataWithElements:self.elements index:cellIndex result:^(CGRect firstVcImageFrame) {
        self.translator.transitionParameter.firstVcImageFrame = firstVcImageFrame;
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}
#pragma mark - Private Method
- (void)setupBaseViewControllerProperty:(NSInteger)cellIndex{
    GJMultiMediaBrowserCollectionViewCell *cell = (GJMultiMediaBrowserCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:cellIndex inSection:0]];
    self.translator.transitionParameter.transitionImage = cell.zoomScrollView.zoomImageView.image;
    self.translator.transitionParameter.browsingImageIndex = cellIndex;
    
    self.imgView.frame = cell.zoomScrollView.zoomImageView.frame;
    self.imgView.image = cell.zoomScrollView.zoomImageView.image;
    self.imgView.hidden = YES;
    self.transitionImgViewCenter = _imgView.center;
}
-(GJMultiMediaBrowserCollectionViewCell *)currentCell{
    return (GJMultiMediaBrowserCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
}
-(NSInteger)currentIndex{
    return self.translator.transitionParameter.browsingImageIndex;
}
@end
