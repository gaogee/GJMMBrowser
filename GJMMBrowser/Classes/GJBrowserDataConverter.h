//
//  GJBrowserDataConverter.h
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/29.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJBrowserTranslator.h"
#import "GJMultiMediaBrowserHelper.h"
#import "GJMultiMediaBrowserViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface GJBrowserDataConverter : NSObject
//present 函数构造
+(void)makePresentedDataWithResources:(NSArray *)resources elements:(id)elements index:(NSInteger)index result:(void(^)(GJBrowseTransitionParameter *transitionParameter ,GJBrowserTranslator *translator ,NSArray<GJMultiMediaResoucre *> *models))result;

//dismiss 函数构造
+ (void)makeDismissedDataWithElements:(id)elements index:(NSInteger)index result:(void(^)(CGRect firstVcImageFrame))result;
@end

NS_ASSUME_NONNULL_END
