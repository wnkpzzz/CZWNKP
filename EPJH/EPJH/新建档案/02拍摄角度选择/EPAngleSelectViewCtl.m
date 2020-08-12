//
//  EPAngleSelectViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/8/3.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPAngleSelectViewCtl.h"

@interface EPAngleSelectViewCtl ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EPAngleSelectViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"拍摄角度选择";
 
}

#pragma mark - 基础配置
- (void)loadBaseConfig{
    

    [self.tableView registerClass:[EPAngleHeaderCell class] forCellReuseIdentifier:[EPAngleHeaderCell cellID]];

}
 
#pragma mark - 事件处理
- (IBAction)btnClickAction:(UIButton *)sender {
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) { return 0; }
        
    return kWidth(10);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 2) { return nil; }
         
    UIView *view = [UIView new];
    view.backgroundColor = RGB(250, 250, 250);
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return nil;
}




@end
