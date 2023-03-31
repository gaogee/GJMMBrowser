//
//  UIColor+GJ.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/28.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "UIColor+GJ.h"

@implementation UIColor (GJ)
+ (UIColor *)colorFromHexString:(NSString *)hexString{
    return [self colorFromHexString:hexString alpha:1];
}

+ (UIColor *)colorFromHexString:(NSString*)hexString alpha:(CGFloat)alpha {
    hexString= [[hexString uppercaseString] substringFromIndex:1];
    CGFloat valueArray[3];
    NSArray *strArray=[NSArray arrayWithObjects:[hexString substringWithRange:NSMakeRange(0, 2)],[hexString substringWithRange:NSMakeRange(2, 2)],[hexString substringWithRange:NSMakeRange(4, 2)] ,nil];
    for( int i=0;i<strArray.count;i++){
        hexString=strArray[i];
        CGFloat value=([hexString characterAtIndex:0]>'9'?[hexString characterAtIndex:0]-'A'+10:[hexString characterAtIndex:0]-'0')*16.0f+([hexString characterAtIndex:1]>'9'?[hexString characterAtIndex:1]-'A'+10:[hexString characterAtIndex:1]-'0');
        valueArray[i]=value;
    }
    return [UIColor colorWithRed:valueArray[0]/255 green:valueArray[1]/255 blue:valueArray[2]/255 alpha:alpha];
}
@end
