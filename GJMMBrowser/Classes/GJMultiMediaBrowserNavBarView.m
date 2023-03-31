//
//  GJMultiMediaBrowserNavBarView.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/30.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJMultiMediaBrowserNavBarView.h"
@interface GJMultiMediaBrowserNavBarView ()
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLb;
@end
@implementation GJMultiMediaBrowserNavBarView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = UIColor.clearColor;
        [self addSubview:self.backBtn];
        [self addSubview:self.titleLb];
    }
    return self;
}
-(UIButton *)backBtn{
    if (!_backBtn){
        _backBtn = [[UIButton alloc]init];
        UIImage *image = [UIImage imageNamed:@"gj_transition_back"];
        [_backBtn setImage:image forState:0];
        _backBtn.frame = CGRectMake(15, self.frame.size.height-image.size.height-15, image.size.width, image.size.height);
        [_backBtn addTarget:self action:@selector(backSelector) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
-(UILabel *)titleLb{
    if (!_titleLb){
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(_backBtn.frame.origin.x+_backBtn.frame.size.width,  _backBtn.frame.origin.y, self.frame.size.width-( _backBtn.frame.origin.x+_backBtn.frame.size.width)*2, _backBtn.frame.size.height)];
        _titleLb.font = [UIFont boldSystemFontOfSize:15];
        _titleLb.textColor = UIColor.whiteColor;
        _titleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLb;
}
-(void)setPageCount:(NSInteger)pageCount currentPage:(NSInteger)currentPage{
    self.titleLb.text = [NSString stringWithFormat:@"%ld/%ld",currentPage+1,pageCount];
}
- (void)backSelector{
    if (_tapBackBtnBlock) {
        _tapBackBtnBlock();
    }
}
-(void)setIsShowBackbutton:(BOOL)isShowBackbutton{
    _isShowBackbutton = isShowBackbutton;
    self.backBtn.hidden = !isShowBackbutton;
}
-(void)setIsShowPageIndicator:(BOOL)isShowPageIndicator{
    _isShowPageIndicator = isShowPageIndicator;
    self.titleLb.hidden = !isShowPageIndicator;
}
@end
