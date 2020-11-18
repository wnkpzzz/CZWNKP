//
//  EP_Main_CaseSquareViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/11/5.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EP_Main_CaseSquareViewCtl.h"
#import "EP_Pop_CaseSqe_HeadView.h"
#import "EP_Pop_CaseSqe_SelectView.h"
#import "EP_Cell_CaseSqe_Main.h"

#import "EP_ViewModel_Home.h"

@interface EP_Main_CaseSquareViewCtl ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * tableItems;

@property (nonatomic, strong) EP_ViewModel_Home * homeViewModel;
@property (nonatomic, strong) EP_Pop_CaseSqe_HeadView * headView;

@property (nonatomic, strong) NSString * brandStr;
@property (nonatomic, strong) NSString * projectStr;
@property (nonatomic, assign) NSInteger pageInt;
@property (nonatomic, assign) BOOL isCollectFlag;

@end

@implementation EP_Main_CaseSquareViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadBaseConfig];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   
}

#pragma mark --- 基础配置

- (void)loadBaseConfig{
    
    self.navigationItem.title = @"案例广场";

    self.pageInt = 1;
    self.brandStr = @"";
    self.projectStr = @"";
    self.isCollectFlag = NO;
    self.homeViewModel = [[EP_ViewModel_Home alloc] init];
     
    [self createTableView];
     
}

#pragma mark - 懒加载
 
- (EP_Pop_CaseSqe_HeadView *)headView {
    
    if (!_headView) {
        _headView =  [EP_Pop_CaseSqe_HeadView initWithCustomView];
        _headView.frame = CGRectMake(0, 0, APP_WIDTH, 85);
    
    }
    return _headView;
}


// 获取主页列表数据
- (void)getAllDataWithBrand:(NSString *)brandId Project:(NSString *)proId{
 
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.homeViewModel requestCaseSquareWithBrand:brandId
                                           Project:proId
                                              Page:self.pageInt
                                        Completion:^(BOOL isSuccess, id  _Nonnull response, NSString * _Nonnull msgStr) {
       [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
       [weakSelf.tableView.mj_header endRefreshing];
       [weakSelf.tableView.mj_footer endRefreshing];
       
       if (isSuccess) {
           
           NSArray * listArr = response;
           if (weakSelf.pageInt == 1) {
               [weakSelf.tableItems removeAllObjects];
               [weakSelf.tableItems addObjectsFromArray:listArr];
           }else{
               [weakSelf.tableItems addObjectsFromArray:listArr];
           }
//    if (weakSelf.tableItems.count > 0) {  weakSelf.placeHolderView.hidden = YES; }else{ weakSelf.placeHolderView.hidden = NO; }
           [weakSelf.tableView reloadData];
           
       }else{
           [MBProgressHUD showError:msgStr];
       }
       
    }];
    
}

// 获得收藏列表
- (void)getCollectListData{
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (void)createTableView {
    
    // UITableView
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = (APP_WIDTH - 60) * 0.5  + 80 + 80;
    self.tableView.backgroundColor = RGB(250, 250, 250);
    self.tableView.tableHeaderView = self.headView;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([EP_Cell_CaseSqe_Main class]) bundle:nil] forCellReuseIdentifier:[EP_Cell_CaseSqe_Main cellID]];
    
    // 上下拉刷新
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageInt = 1;
        if (weakSelf.isCollectFlag) { [weakSelf getCollectListData]; }else{ [weakSelf getAllDataWithBrand:nil Project:nil]; }
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageInt = weakSelf.pageInt + 1;
        if (weakSelf.isCollectFlag) { [weakSelf getCollectListData]; }else{ [weakSelf getAllDataWithBrand:nil Project:nil]; }
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return self.tableItems.count;
}

- (NSInteger)tableView:(UITableView  *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EP_Cell_CaseSqe_Main *cell = [tableView dequeueReusableCellWithIdentifier:[EP_Cell_CaseSqe_Main cellID] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.collectClickBlock = ^(UITableViewCell *cell) {
        NSLog(@"收藏标签");
    };
    cell.popClickpBlock = ^(UITableViewCell *cell) {
        NSLog(@"跳转标签");
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
