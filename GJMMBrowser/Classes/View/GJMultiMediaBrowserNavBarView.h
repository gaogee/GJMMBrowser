//
//  GJMultiMediaBrowserNavBarView.h
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/30.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GJMultiMediaBrowserNavBarView : UIView
/**是否展示顶部返回按钮**/
@property (nonatomic, assign) BOOL isShowBackbutton;
/**是否展示页码指示器**/
@property (nonatomic, assign) BOOL isShowPageIndicator;
-(void)setPageCount:(NSInteger)pageCount currentPage:(NSInteger)currentPage;
@property (nonatomic,copy)   void (^tapBackBtnBlock)(void);
@end

NS_ASSUME_NONNULL_END
