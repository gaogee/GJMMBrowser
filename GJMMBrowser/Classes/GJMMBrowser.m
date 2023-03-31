//
//  GJMMBrowser.m
//  GJMMBrowser
//
//  Created by zhanggaoju on 2023/3/27.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJMMBrowser.h"
#import "GJBrowserTranslator.h"
#import "GJMultiMediaBrowserHelper.h"
#import "GJBrowserDataConverter.h"
@interface GJMMBrowser ()<GJMultiMediaBrowserViewControllerDelegate>
@property (nonatomic, strong) GJMultiMediaBrowserViewController *browserVc;
@end
@implementation GJMMBrowser

-(void)openBrowser{
    __weak typeof(self) weakSelf = self;
    [GJBrowserDataConverter makePresentedDataWithResources:self.resources elements:self.elements index:self.currentPage result:^(GJBrowseTransitionParameter * _Nonnull transitionParameter, GJBrowserTranslator * _Nonnull translator, NSArray<GJMultiMediaResoucre *> * _Nonnull models) {
        GJMultiMediaBrowserViewController *browserVc = [[GJMultiMediaBrowserViewController alloc] init];
        browserVc.resoucreModels = models;
        browserVc.translator = translator;
        browserVc.transitioningDelegate = translator;
        browserVc.delegate = self;
        browserVc.placeholderImage = self.placeholderImage;
        browserVc.isShowBackbutton = self.isShowBackbutton;
        browserVc.isShowPageIndicator = self.isShowPageIndicator;
        browserVc.elements = self.elements;
        browserVc.footerContentView = self.footerContentView;
        browserVc.modalPresentationStyle = UIModalPresentationFullScreen;
        self.browserVc = browserVc;
        [[GJMultiMediaBrowserHelper getCurrentViewController] presentViewController:browserVc animated:YES completion:nil];
    }];
}

-(void)closeBrowser{
    [self.browserVc closeBrowser];
}
-(void)browserView:(UIView *)browserView didSelectItem:(UIView *)itme index:(NSInteger)index{
    if (self.delegate && [self.delegate respondsToSelector:@selector(browserView:didSelectItem:index:)]) {
        [self.delegate browserView:browserView didSelectItem:itme index:index];
    }
}
-(void)browserView:(UIView *)browserView didScrollItem:(UIView *)itme index:(NSInteger)index{
    if (self.delegate && [self.delegate respondsToSelector:@selector(browserView:didScrollItem:index:)]) {
        [self.delegate browserView:browserView didScrollItem:itme index:index];
    }
}
-(void)browserView:(UIView *)browserView draggingItem:(UIView *)itme index:(NSInteger)index{
    if (self.delegate && [self.delegate respondsToSelector:@selector(browserView:draggingItem:index:)]) {
        [self.delegate browserView:browserView draggingItem:itme index:index];
    }
}
-(void)browserView:(UIView *)browserView didEndDraggingItem:(UIView *)itme index:(NSInteger)index{
    if (self.delegate && [self.delegate respondsToSelector:@selector(browserView:didEndDraggingItem:index:)]) {
        [self.delegate browserView:browserView didEndDraggingItem:itme index:index];
    }
}
@end
