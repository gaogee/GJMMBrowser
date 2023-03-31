//
//  GJViewController.m
//  GJMultiMediaBrowser
//
//  Created by gaogee on 03/24/2023.
//  Copyright (c) 2023 gaogee. All rights reserved.
//

#import "GJViewController.h"
#import "UIColor+GJ.h"
@interface GJViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *list;
@end

@implementation GJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.tableView];
}

-(UITableView *)tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.bounds.size.height-[UIApplication sharedApplication].statusBarFrame.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.alwaysBounceVertical = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = UIView.new;
        _tableView.tableFooterView = UIView.new;
        _tableView.sectionFooterHeight = 0;
        [_tableView registerClass:GJTestTableViewCell.class forCellReuseIdentifier:NSStringFromClass(GJTestTableViewCell.class)];
        
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.list.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *list  = (NSArray *)self.list[section][@"cell"];
    return list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *list  = (NSArray *)self.list[indexPath.section][@"cell"];
    GJTestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(GJTestTableViewCell.class) forIndexPath:indexPath];
    cell.titleLb.text = list[indexPath.row][@"title"];
    cell.backgroundColor = UIColor.whiteColor;
    cell.line.hidden = indexPath.section < self.list.count-1&&indexPath.row == list.count-1?YES:NO;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *list  = (NSArray *)self.list[indexPath.section][@"cell"];
    Class class = NSClassFromString(list[indexPath.row][@"router"]);
    UIViewController *vc = [class new];
    vc.title = list[indexPath.row][@"title"];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.navigationController pushViewController:vc animated:YES];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    GJTestTableHeaderView *header = [[GJTestTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
    header.titleLb.text = self.list[section][@"header"][@"title"];
    header.backgroundColor = self.list[section][@"header"][@"bgColor"];
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55;
}
-(NSArray *)list{
    if(!_list){
        _list = @[
            @{@"header":@{@"title":@"用例: 传入超父/父视图",@"bgColor":[UIColor colorFromHexString:@"#E6E6E6"]},
              @"cell": @[@{@"title":@"传入View父视图--本地图片",@"router":@"GJLocalPicturesViewController"},
                         @{@"title":@"传入View父视图--网络图片",@"router":@"GJNetworkPicturesViewController"},
                         @{@"title":@"传入ScrollView父视图--本地图片",@"router":@"GJLocalPicturesScrollViewController"},
                         @{@"title":@"传入ScrollView父视图--网络图片",@"router":@"GJNetworkPicturesScrollViewController"},
                         @{@"title":@"传入CollectionView超父视图--本地图片",@"router":@"GJLocalPicturesCollectionViewController"},
                         @{@"title":@"传入CollectionView超父视图--网络图片",@"router":@"GJNetworkPicturesCollectionViewController"},
                         @{@"title":@"传入TableView超父视图--本地图片",@"router":@"GJLocalPicturesTableViewController"},
                         @{@"title":@"传入TableView超父视图--网络图片",@"router":@"GJNetworkPicturesTableViewController"}]
            },
            @{@"header":@{@"title":@"用例: 传入图片视图数组",@"bgColor":[UIColor colorFromHexString:@"#E6E6E6"]},
              @"cell": @[@{@"title":@"传入imageView视图数组--本地图片",@"router":@"GJLocalPicturesImageViewArrayController"},
                         @{@"title":@"传入imageView视图数组--网络图片",@"router":@"GJNetworkPicturesImageViewArrayController"},
                         @{@"title":@"传入button视图数组--本地图片",@"router":@"GJLocalPicturesButtonArrayController"},
                         @{@"title":@"传入button视图数组--网络图片",@"router":@"GJNetworkPicturesButtonArrayController"},
                        ]
            },
            @{@"header":@{@"title":@"用例: GIF图片浏览",@"bgColor":[UIColor colorFromHexString:@"#E6E6E6"]},
              @"cell": @[@{@"title":@"GIF图片浏览",@"router":@"GJGIFViewController"},
                        ]
            },
            @{@"header":@{@"title":@"用例: 自定义用法",@"bgColor":[UIColor colorFromHexString:@"#E6E6E6"]},
              @"cell": @[@{@"title":@"浏览器的底部视图+导航+代理",@"router":@"GJCustomBrowserViewController"},
                        ]
            }

        ];
    }
    return _list;
}
@end


@implementation GJTestTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.titleLb];
        [self addSubview:self.line];
    }
    return self;
}
-(UILabel *)titleLb{
    if (!_titleLb){
        _titleLb = [[UILabel alloc]init];
        _titleLb.backgroundColor = [UIColor clearColor];
        _titleLb.textColor = [UIColor blackColor];
        _titleLb.font = [UIFont systemFontOfSize:16];
    }
    return _titleLb;
}
-(UIView *)line{
    if (!_line){
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor colorFromHexString:@"#E6E6E6"];
    }
    return _line;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLb.frame = CGRectMake(15, 0, self.bounds.size.width-15*2, self.bounds.size.height);
    self.line.frame =  CGRectMake(15, self.bounds.size.height-1, self.bounds.size.width-15*2, 1);
}
@end


@implementation GJTestTableHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.titleLb];
    }
    return self;
}
-(UILabel *)titleLb{
    if (!_titleLb){
        _titleLb = [[UILabel alloc]init];
        _titleLb.backgroundColor = [UIColor clearColor];
        _titleLb.textColor = [UIColor blackColor];
        _titleLb.font = [UIFont boldSystemFontOfSize:16];
    }
    return _titleLb;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLb.frame = CGRectMake(15, 0, self.bounds.size.width-15*2, self.bounds.size.height);
}
@end
