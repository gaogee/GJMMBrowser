//
//  GJLocalPicturesTableViewController.m
//  GJMMBrowser_Example
//
//  Created by zhanggaoju on 2023/3/28.
//  Copyright © 2023 gaogee. All rights reserved.
//

#import "GJLocalPicturesTableViewController.h"
#import "GJMMBrowser.h"
@interface GJLocalPicturesTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *resoucres;
@end

@implementation GJLocalPicturesTableViewController

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
        [_tableView registerClass:GJLocalPicturesTableViewCell.class forCellReuseIdentifier:NSStringFromClass(GJLocalPicturesTableViewCell.class)];
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resoucres.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GJLocalPicturesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(GJLocalPicturesTableViewCell.class) forIndexPath:indexPath];
    cell.imgView.image = self.resoucres[indexPath.row];
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
    if(!_resoucres){
        _resoucres = @[[UIImage imageNamed:@"test01"],[UIImage imageNamed:@"test02"],[UIImage imageNamed:@"test03"],[UIImage imageNamed:@"test04"],
                       [UIImage imageNamed:@"test05"],[UIImage imageNamed:@"test06"],[UIImage imageNamed:@"test07"],[UIImage imageNamed:@"test08"],
                       [UIImage imageNamed:@"test09"],[UIImage imageNamed:@"test10"],[UIImage imageNamed:@"test11"],[UIImage imageNamed:@"test12"]];
    }
    return _resoucres;
}
@end

@implementation GJLocalPicturesTableViewCell
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
