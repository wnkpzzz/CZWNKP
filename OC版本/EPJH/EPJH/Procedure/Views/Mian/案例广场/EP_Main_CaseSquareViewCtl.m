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

@interface EP_Main_CaseSquareViewCtl ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * tableItems;
@property (assign, nonatomic) NSInteger pageInt;


@end

@implementation EP_Main_CaseSquareViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadBaseConfig];
}

#pragma mark --- 基础配置

- (void)loadBaseConfig{
    
    self.navigationItem.title = @"案例广场";
    
    [self createTableView];

}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (void)createTableView {
    
    // UITableView
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = (APP_WIDTH - 60) * 0.5  + 80 + 80;
    self.tableView.backgroundColor = RGB(250, 250, 250);
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([EP_Cell_CaseSqe_Main class]) bundle:nil] forCellReuseIdentifier:[EP_Cell_CaseSqe_Main cellID]];
   
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
    
    WS(weakSelf);
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
