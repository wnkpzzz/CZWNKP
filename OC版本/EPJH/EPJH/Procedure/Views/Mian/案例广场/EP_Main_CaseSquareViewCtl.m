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

@interface EP_Main_CaseSquareViewCtl ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * tableItems;

@end

@implementation EP_Main_CaseSquareViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

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
    
//    WS(weakSelf);
//
//
//      YPAnLiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[YPAnLiTableViewCell cellID]];
//      cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//      YPCaseListModel * model = self.tableItems[indexPath.section];
//      cell.item = model;
//
//      cell.btnClickBlock = ^(UITableViewCell *cell) {
//          NSLog(@"收藏标签");
//          [weakSelf collectGetListAction:model];
//      };
//
//      cell.btnClickpPopBlock = ^(UITableViewCell *cell) {
//          NSLog(@"跳转标签");
//          YPCaseListModel * model = weakSelf.tableItems[indexPath.section];
//          YPMyCaseViewCtl * Vc = [[YPMyCaseViewCtl alloc] init];
//          Vc.model = model;
//          [weakSelf.navigationController pushViewController:Vc animated:YES];
//      };
//
//
//
//      return cell;
        
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
