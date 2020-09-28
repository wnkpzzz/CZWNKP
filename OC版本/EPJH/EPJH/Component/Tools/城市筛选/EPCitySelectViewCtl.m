//
//  EPCitySelectViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/9/28.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPCitySelectViewCtl.h"
#import "EPCityProvinceModel.h"

@interface EPCitySelectViewCtl ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSString * parentId;
@property (nonatomic, copy) NSString * titleName;
@property (nonatomic, assign) EPCitySelectType citySelectType;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tableItems;

@end

@implementation EPCitySelectViewCtl

- (instancetype)initWithCitySelectType:(EPCitySelectType)type parentId:(NSString *)parentId titleName:(NSString *)titleName{
    
    if (self = [super init]) {
           self.citySelectType = type;
           self.parentId = parentId;
           if ( titleName && titleName.length > 0 ) {
               self.navigationItem.title = titleName;
               self.titleName = titleName;
           }else{ self.navigationItem.title = @"所在地";}
           
           [self getLocalCityProvinceData];
       }
       
       return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];

    // 当界面是省份的时候，返回按钮需要做校验，返回空值回去。方便处理、
    if (self.citySelectType == EPCitySelectTypeProvince) {

        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_common_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    }
}
 
- (void)getLocalCityProvinceData{
     
    WS(weakSelf);
    
      
    if (self.citySelectType == EPCitySelectTypeProvince) {
         
        NSDictionary * response = [AppUtils readLocalFileWithName:@"ProvinceCity"];
        NSArray * listArr = [NSArray modelArrayWithClass:[EPCityProvinceModel class] json:response[@"cateViews"]];
        weakSelf.tableItems = listArr;
        [weakSelf.tableView reloadData];
          
    }else{
          
        NSDictionary * response = [AppUtils readLocalFileWithName:@"ProvinceCity"];
        NSArray * listArr = response[@"cateViews"];

        for (int i = 0; i < listArr.count ; i ++) {
            
          NSDictionary * dataDic = listArr[i];
          NSString * idStr = [NSString stringWithFormat:@"%@",dataDic[@"id"]];
          
          if ([idStr isEqualToString:self.parentId]) {
              NSArray * listArr = [NSArray modelArrayWithClass:[EPCityProvinceModel class] json:dataDic[@"cateViews"]];
              self.tableItems = listArr;
              [self.tableView reloadData];
          }
        }
    }
}

- (void)backAction{
     
    if (self.addressCompleted) {
        NSString *province = @"";
        NSString *city = @"";
        self.addressCompleted(province, city);
        
        NSArray *vcs = self.navigationController.childViewControllers;
        [self.navigationController popToViewController:vcs[vcs.count - 2] animated:YES];
    }
    
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tableItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    EPCityProvinceModel * model =  self.tableItems[indexPath.row];
    cell.textLabel.text = model.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WS(weakSelf);
    EPCityProvinceModel * model =  self.tableItems[indexPath.row];
    switch (self.citySelectType) {
            
        case EPCitySelectTypeProvince: {
          
            EPCitySelectViewCtl *city = [[EPCitySelectViewCtl alloc] initWithCitySelectType:EPCitySelectTypeCity parentId:model.id titleName:model.name];
            [city setAddressCompleted:^(NSString *province, NSString *city) {
                if (weakSelf.addressCompleted) {
                    weakSelf.addressCompleted(province, city);
                    NSArray *vcs = self.navigationController.childViewControllers;
                    [weakSelf.navigationController popToViewController:vcs[vcs.count - 3] animated:YES];
                }
            }];
            [self.navigationController pushViewController:city animated:YES];

            
            break;
        }
        case EPCitySelectTypeCity: {
            if (self.addressCompleted) {
                NSString *province = self.titleName;
                NSString *city = model.name;
                self.addressCompleted(province, city);
            }
        }
            break;
    }
    
}

#pragma mark - 懒加载

- (UITableView *)tableView{
    if (!_tableView ) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - Nav_Height);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellID];
    }
    return _tableView;
}

@end
