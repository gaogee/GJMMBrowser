//
//  GJNetworkPicturesTableViewController.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/28.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJNetworkPicturesTableViewController.h"
#import "GJMMBrowser.h"
@interface GJNetworkPicturesTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *resoucres;
@end

@implementation GJNetworkPicturesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.tableView];
}
-(UITableView *)tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.bounds.size.height-[UIApplication sharedApplication].statusBarFrame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.alwaysBounceVertical = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:GJNetworkPicturesTableViewCell.class forCellReuseIdentifier:NSStringFromClass(GJNetworkPicturesTableViewCell.class)];
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resoucres.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GJNetworkPicturesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(GJNetworkPicturesTableViewCell.class) forIndexPath:indexPath];
    [cell.imgView yy_setImageWithURL:[NSURL URLWithString:self.resoucres[indexPath.item]] placeholder:[UIImage imageNamed:@"default_icon"]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GJMMBrowser *mBrowser = [[GJMMBrowser alloc]init];
    mBrowser.resources = self.resoucres;
    mBrowser.elements = tableView;
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

@implementation GJNetworkPicturesTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.imgView];
    }
    return self;
}
-(UIImageView *)imgView{
    if (!_imgView){
        _imgView = [UIImageView new];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.layer.cornerRadius = 10;
        _imgView.layer.masksToBounds = YES;
    }
    return _imgView;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(10, 10, self.bounds.size.width-10*2, self.bounds.size.height-10*2);
}
@end
