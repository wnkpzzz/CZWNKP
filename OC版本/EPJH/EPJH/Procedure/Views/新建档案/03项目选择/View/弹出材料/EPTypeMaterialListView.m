//
//  EPTypeMaterialListView.m
//  EPJH
//
//  Created by Hans on 2020/8/26.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPTypeMaterialListView.h"
#import "EPTypeMaterialListTableViewCell.h"

@interface EPTypeMaterialListView ()<UITableViewDelegate,UITableViewDataSource>

/** 背景蒙版 */
@property (weak, nonatomic) IBOutlet UIView * maskBgView;

/** Block数据返回 */
@property (copy, nonatomic) typeMaterialListResultBlock completeBlock;


@property (copy, nonatomic) NSArray * tableItems;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EPTypeMaterialListView

//选择展示回调
+ (void)showTypeMaterialListWithDataArr:(NSArray *)dataArr resultBlock:(typeMaterialListResultBlock)complete{
     
    EPTypeMaterialListView *popView = [EPTypeMaterialListView initWithCustomView];
    popView.completeBlock = complete;
    popView.tableItems = dataArr;
}
 
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     
    [self loadBaseConfig];
}

- (void)loadBaseConfig {
      
    self.tableItems = [NSMutableArray arrayWithCapacity:10];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.tableView registerClass:[EPTypeMaterialListTableViewCell class] forCellReuseIdentifier:[EPTypeMaterialListTableViewCell cellID]];
    
    self.maskBgView.alpha = 0.3;
    self.maskBgView.backgroundColor = RGB(0, 0, 0);

    self.frame = CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT);
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
}

- (IBAction)btnClickAction:(UIButton *)sender {
    
    [self dismissPopView];

    if (sender.tag == 0)      {   }
    else if (sender.tag == 1) {   }
 
    
}

#pragma mark

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableItems.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     
//    EPTypeMaterialListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[EPTypeMaterialListTableViewCell cellID] forIndexPath:indexPath];
    
    
    EPTypeMaterialListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[EPTypeMaterialListTableViewCell cellID]];
    if (!cell) {
        cell = [[EPTypeMaterialListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[EPTypeMaterialListTableViewCell cellID]];
    }
    
    EPTypeListClassifyModel * model = self.tableItems[indexPath.row];
    cell.dataModel = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EPTypeListClassifyModel * model = self.tableItems[indexPath.row];
    model.isSelected = !model.isSelected;
    [self.tableView reloadData];
}

 
@end
