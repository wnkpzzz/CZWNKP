//
//  ViewController.m
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "ViewController.h"
#import "TempTableViewCell.h"
#import "RootTableViewDataSource.h"


@interface ViewController ()<UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableItems;
@property (nonatomic, strong) RootTableViewDataSource *tableViewDataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    [self loadBaseConfig];
}

#pragma mark --- 基础配置

// 初始化配置
- (void)loadBaseConfig{
    
    self.tableItems = [NSMutableArray arrayWithCapacity:10];
    NSDictionary *dic = @{@"title":@"标题01",@"name":@"张三"};
    [self.tableItems addObject:dic];
    [self.tableItems addObject:dic];
    [self.tableItems addObject:dic];
    [self.tableItems addObject:dic];
    [self.tableItems addObject:dic];
    [self.tableItems addObject:dic];
    
    
    [self setUpDataSource];
    [self.view addSubview:self.tableView];
    
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,APP_WIDTH, APP_HEIGHT) style:UITableViewStylePlain];
        _tableView.rowHeight = 90;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TempTableViewCell class]) bundle:nil] forCellReuseIdentifier:[TempTableViewCell cellID]];
    }
    return _tableView;
}

- (void)setUpDataSource{
    
    TableViewCellConfigureBlock configureCell = ^(TempTableViewCell *cell, NSDictionary *item) {
        cell.dataDic = item;
    };
    
    self.tableViewDataSource = [[RootTableViewDataSource alloc] initWithItems:self.tableItems
                                                               cellIdentifier:[TempTableViewCell cellID]
                                                           configureCellBlock:configureCell];
    self.tableView.dataSource = self.tableViewDataSource;
    
    
}

@end
