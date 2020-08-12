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
@property (nonatomic, assign) NSInteger partsIndex;                     // 节点索引

@end

@implementation EPAngleSelectViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"拍摄角度选择";
 
    [self loadBaseConfig];
}

#pragma mark - 基础配置
- (void)loadBaseConfig{
    
    // 检测弹框提醒
    [self checkReminderAction];
    // 初始化TableView
    [self createTableView];
     
    // 在这里初始化项目Model
    self.proModel = [[EPProjectModel alloc] init];
    self.proModel.cameraArr = [NSMutableArray arrayWithCapacity:12];
    self.proModel.userInfo = [[EPUserInfoModel alloc] init];
    self.proModel.bindUserId = KUID;
    self.proModel.subCateId = kShuQianID;
    self.proModel.subCateName = kTimeArray[0];
    self.proModel.cateId = kMianBuID;
    self.proModel.cateName = kPartsNameArr[0];
    
    
}
 
#pragma mark - 事件处理
/** 点击事件处理 */
- (IBAction)btnClickAction:(UIButton *)sender {
    
}

/** 检测弹框提醒 */
- (void)checkReminderAction{
    
    NSString * tipsFlag = [NSUSERDEFAULTS valueForKey:kTipsFlag];
    
    if (tipsFlag && tipsFlag.length > 0 && [tipsFlag isEqualToString:@"YES"]) {


    }else{
       
        //显示弹出框列表选择
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                              message:@"为确保拍摄品质与速度，请在正式使用之前，多次模拟练习，熟悉流程与方法。"
                                                       preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* submitAction = [UIAlertAction actionWithTitle:@"不再提示" style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * action) {
                                                                    //响应事件
                                                [NSUSERDEFAULTS setValue:@"YES" forKey:kTipsFlag];
                                                                }];

        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"忽略" style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction * action) {
                                                        //响应事件
                                                    }];
        [alert addAction:cancelAction];
        [alert addAction:submitAction];

        // 单独适配iPad
        UIPopoverPresentationController *popoverPresentationController = [alert popoverPresentationController];
        if (popoverPresentationController) {
           popoverPresentationController.sourceRect = CGRectMake(0, APP_HEIGHT, APP_WIDTH, APP_HEIGHT);
           popoverPresentationController.sourceView = self.view;
        }
        alert.modalPresentationStyle = UIModalPresentationFullScreen;
        dispatch_async(dispatch_get_main_queue(), ^{
           [self presentViewController:alert animated:YES completion:nil];
        });
    }
}



#pragma mark - 事件处理

/** 时间节点点击回调 */
- (void)headerViewSelectWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
            self.proModel.subCateName = kTimeArray[0];
            self.proModel.subCateId = kShuQianID;
            break;
        case 1:
            self.proModel.subCateName = kTimeArray[1];
            self.proModel.subCateId = kShuHouID;
            break;
        case 2:
            self.proModel.subCateName = kTimeArray[2];
            self.proModel.subCateId = kFuZhenID;
            break;
        default:
            break;
    }
    [self resetDefaultImage];
    [self.tableView reloadData];
}

/** 部位选择点击回调 */
- (void)selectViewSelectWithIndex:(NSInteger)index{
    
    self.partsIndex = index;
    self.proModel.cateId = kPartsIDArr[index];
    self.proModel.cateName = kPartsNameArr[index];
    [self resetDefaultImage];
    [self.tableView reloadData];
}

/** 底部视图点击回调 */
- (void)bottomViewSelectWithIndex:(NSInteger)index{
    
//    [self checkIsHaveOpenCameraJurisdiction];
//
//    YPCameraController *cameraVC = [[YPCameraController alloc] init];
//    [cameraVC reloadDataWithModel:[_model mutableCopy] photoArr:[self.photoArr mutableCopy] nowIndex:index];
//    WS(weakSelf);
//    // 数据回传
//    cameraVC.saveClickBlock = ^(EPProjectModel *proModel,NSArray *photoArr) {
//        [weakSelf updateForModel:proModel array:photoArr];
//    };
//    cameraVC.modalPresentationStyle = UIModalPresentationFullScreen;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self presentViewController:cameraVC animated:YES completion:nil];
//    });
}

/** 重置默认图片 */
- (void)resetDefaultImage{
    
//    [self.photoArr removeAllObjects];
//    // 旧用户更新数据
//    if (_userModel.uid.length > 0 && ![_model.subCateId isEqualToString:kShuQianID]) {
//        [self loadImgDataForDataBase];  // 从数据库查询数据
//    }else{
//        [self loadDefaultImageWithList:nil];  //
//    }
}

#pragma mark - UITableViewDataSource

- (void)createTableView{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 200;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[EPAngleHeaderCell class] forCellReuseIdentifier:[EPAngleHeaderCell cellID]];
    [self.tableView registerClass:[EPAngleSelectCell class] forCellReuseIdentifier:[EPAngleSelectCell cellID]];
    [self.tableView registerClass:[EPAngleBottomCell class] forCellReuseIdentifier:[EPAngleBottomCell cellID]];

}

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
   
    WS(weakself)
    if (indexPath.section == 0) {
       EPAngleHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:[EPAngleHeaderCell cellID] forIndexPath:indexPath];
           
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
       return cell;
    }else if(indexPath.section == 1){
        
        EPAngleSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:[EPAngleSelectCell cellID] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
        
    }else{
    
       EPAngleBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:[EPAngleBottomCell cellID] forIndexPath:indexPath];
       cell.selectionStyle = UITableViewCellSelectionStyleNone;

       return cell;
    }


}

 


@end
