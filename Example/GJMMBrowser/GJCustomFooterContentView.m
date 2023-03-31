//
//  GJCustomFooterContentView.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/30.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJCustomFooterContentView.h"

@implementation GJCustomFooterContentView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.8];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, self.frame.size.width-30, self.frame.size.height-30-30)];
        title.text = @"雨中的西湖，别有一番景象。只见细雨落在西湖里，像数不清的银色丝线连起了天空和湖水，发出了沙沙的声音，像是谁在快乐的演唱。雨中的西湖，别有一番景象。只见细雨落在西湖里，像数不清的银色丝线连起了天空和湖水，发出了沙沙的声音，像是谁在快乐的演唱;柳树姑娘在轻风细雨中不停摇摆，仿佛在欢乐地跳舞。";
        title.numberOfLines = 0;
        title.textColor = UIColor.whiteColor;
        title.font = [UIFont systemFontOfSize:15];
        title.backgroundColor = [UIColor clearColor];
        [self addSubview:title];
    }
    return self;
}

@end
