//
//  EP_Files_FillInDataViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/9/17.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EP_Files_FillInDataViewCtl.h"
#import "EPCitySelectViewCtl.h" // 城市筛选

@interface EP_Files_FillInDataViewCtl ()

//姓名
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
//性别
@property (weak, nonatomic) IBOutlet UIView *sexView;
@property (weak, nonatomic) IBOutlet UITextField *sexTF;
//所在地
@property (weak, nonatomic) IBOutlet UIView *locationView;
@property (weak, nonatomic) IBOutlet UITextField *locationTF;
//省份
@property (nonatomic,copy) NSString *province;
//城市
@property (nonatomic,copy) NSString *city;
//详细地址
@property (weak, nonatomic) IBOutlet UITextField *addressTF;

@end

@implementation EP_Files_FillInDataViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"项目选择";
    [self loadBaseConfig];
}

#pragma mark - 基础配置

- (void)loadBaseConfig{
 
    self.province = @"";
    self.city = @"";
    self.sexTF.text = @"女";
    
    [self initWithUserInfo];
    
    
    //设置点击事件
    NSArray *tapViews = @[self.sexView, self.locationView];
    for (UIView *tapView in tapViews) {
        [tapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewDidTap:)]];
    }
}
 
- (void)initWithUserInfo{
    
    // 病人创建-初始化信息
    self.userModel = [[EPUserInfoModel alloc] init];
    self.userModel.bindUserId = KUID;
    self.userModel.age = @"";
    self.userModel.medicalHistory = [kJWBSIDArray componentsJoinedByString:@","];
    self.userModel.physiologicalCondition = [kJWBSIDArray componentsJoinedByString:@","];
 
    self.userModel.uid = [NSString stringWithFormat:@"%@%@",@"12",self.timeStampStr];
    self.userModel.createTime = [AppUtils getNowTimeCuo];
    self.userModel.timeFormat = [AppUtils timestampChangeTime:self.timeStampStr WithFormat:@"yyyy-MM-dd"];

    self.userModel.realName = [NSString stringWithFormat:@"%@%@",@"PK",self.timeStampStr];
    self.userModel.sex = @"男";
    self.userModel.headImg = @"";
    self.userModel.province = @"广东省";
    self.userModel.city  = @"深圳市";
    self.userModel.addr  = @"深南大道9988号。";
}

#pragma mark - 事件处理

- (void)tapViewDidTap:(UITapGestureRecognizer *)tap {
    
    [self.view endEditing:YES];
    UIView *tapView = tap.view;

    WS(weakSelf);
    if (tapView == self.sexView) {
        
        [BRStringPickerView showStringPickerWithTitle:nil dataSource:kSexArray defaultSelValue:self.sexTF.text resultBlock:^(id selectValue) {
            weakSelf.sexTF.text = selectValue;
        }];
         
    }else if (tapView == self.locationView) {

        EPCitySelectViewCtl *address = [[EPCitySelectViewCtl alloc] initWithCitySelectType:EPCitySelectTypeProvince parentId:@"" titleName:@""];
        WS(weakSelf);
        [address setAddressCompleted:^(NSString *province, NSString *city) {
            
            weakSelf.locationTF.text = [NSString stringWithFormat:@"%@ %@", province, city];
            weakSelf.province = province;
            weakSelf.city = city;
            
            if (province.length == 0) {
                weakSelf.locationTF.placeholder = @"所在地";
                weakSelf.locationTF.text = @"";
            }
        }];
        [self.navigationController pushViewController:address animated:YES];
        
    }
    
}

- (IBAction)submitAction:(id)sender {
    
//    //任务A
//    [[SqliteManager sharedInstance] updateOneUserWithUID:KUID dataModel:self.userModel updateItems:nil complete:^(BOOL success, id  _Nonnull obj) {
//
//        if (success) {
//
//            [AppJump goHomeVC];
//
//        }
//
//    }];
    
 
    
}

@end
