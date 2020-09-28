//
//  EP_Files_AngleSelectViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/9/17.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EP_Files_AngleSelectViewCtl.h"
 
@interface EP_Files_AngleSelectViewCtl ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger partsIndex;     // 部位节点索引，面部，身体，四肢。。。

// 用户案例档案数据初始化
@property (nonatomic, strong) EPUserInfoModel * userModel; // 档案病人Model信息
@property (nonatomic, strong) EPProjectModel  * projectModel;   // 档案项目Model信息
@property (nonatomic, strong) NSMutableArray<EPTakePictureModel *> *takeCameraArr;  // 拍摄的照片信息数组
@property (nonatomic, copy)   NSString  * timeStampStr;   // 档案创建过程中唯一标定时间戳

@end

@implementation EP_Files_AngleSelectViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"拍摄角度选择";
 
    [self loadBaseConfig];
}

#pragma mark - 基础配置
- (void)loadBaseConfig{
        
    [self initWithProjectInfo];
    [self createTableView];     // 初始化TableView
    [self loadDefaultImageWithList:nil]; // 加载默认图片

}

- (void)initWithProjectInfo{
    
    // 项目创建-初始化项目信息
    self.projectModel = [[EPProjectModel alloc] init];
    self.projectModel.cameraArr = [NSMutableArray arrayWithCapacity:12];
    self.projectModel.userInfo = [[EPUserInfoModel alloc] init];
    self.projectModel.bindUserId = KUID;
    self.projectModel.subCateId = kShuQianID;
    self.projectModel.subCateName = kTimeArray[0];
    self.projectModel.cateId = kMianBuID;
    self.projectModel.cateName = kPartsNameArr[0];
    self.takeCameraArr = [NSMutableArray arrayWithCapacity:10];

    // 项目创建-初始化时间戳信息,ID唯一标识只用
    self.timeStampStr = [AppUtils getNowTimeCuo];
}
 
#pragma mark - 事件处理

/** 下一步点击事件处理 */
- (IBAction)submitAction:(UIButton *)sender {
    
    // 将案例信息，拍摄图片信息，时间戳流转到下一界面。
    EP_Files_ProSelectViewCtl * Vc = [[EP_Files_ProSelectViewCtl alloc] init];
    Vc.projectModel  = [self.projectModel mutableCopy];
    Vc.takeCameraArr = self.takeCameraArr;
    Vc.timeStampStr  = self.timeStampStr;
    [self.navigationController pushViewController:Vc animated:YES];
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

/** 时间节点按钮事件 */
- (void)headerViewSelectWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
            self.projectModel.subCateName = kTimeArray[0];
            self.projectModel.subCateId = kShuQianID;
            break;
        case 1:
            self.projectModel.subCateName = kTimeArray[1];
            self.projectModel.subCateId = kShuHouID;
            break;
        case 2:
            self.projectModel.subCateName = kTimeArray[2];
            self.projectModel.subCateId = kFuZhenID;
            break;
        default:
            break;
    }
    [self resetDefaultImage];
    [self.tableView reloadData];
}

/** 拍摄部位按钮事件 */
- (void)selectViewSelectWithIndex:(NSInteger)index{
    
    self.partsIndex = index;
    self.projectModel.cateId = kPartsIDArr[index];
    self.projectModel.cateName = kPartsNameArr[index];
    [self resetDefaultImage];
    [self.tableView reloadData];
}

/** 各个部位图片按钮事件 */
- (void)bottomViewSelectWithIndex:(NSInteger)index{
     
    WS(weakSelf);
    EPCasePhotographyViewCtl *Vc = [[EPCasePhotographyViewCtl alloc] init];
    [Vc reloadDataWithModel:[self.projectModel mutableCopy]
                 pictureArr:self.takeCameraArr
                  indexSign:index
                  timeStamp:self.timeStampStr];
    Vc.saveClickBlock = ^(EPProjectModel * proModel, NSArray<EPTakePictureModel *> * takeCasePicArr) {
         [weakSelf updateForModel:proModel array:takeCasePicArr];
    };
    Vc.modalPresentationStyle = UIModalPresentationFullScreen;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:Vc animated:YES completion:nil];
    });
}

#pragma mark - 业务逻辑处理

/** 拍照界面数据回传 */
- (void)updateForModel:(EPProjectModel *)projectModel array:(NSArray<EPTakePictureModel *> *)takeCasePicArr{

    self.projectModel = projectModel;
    
    // 第二次补充拍摄（第二次补充拍摄的内容个数 >= 第一次拍摄的内容个数）
    NSMutableArray *newTakeCasePicArr = [NSMutableArray arrayWithCapacity:12];
    [newTakeCasePicArr addObjectsFromArray:takeCasePicArr];

    [self.takeCameraArr removeAllObjects];
    [self.takeCameraArr addObjectsFromArray:newTakeCasePicArr];
    [self.tableView reloadData];
}

/** 重置默认图片 */
- (void)resetDefaultImage{
    
    [self.takeCameraArr removeAllObjects];
    // 旧用户更新数据
    if (self.userModel.uid.length > 0 && ![self.projectModel.subCateId isEqualToString:kShuQianID]) {
        [self loadImgDataForDataBase];  // 从数据库查询数据
    }else{
        [self loadDefaultImageWithList:nil];
    }
}

/** 加载角度图片(list:对比图数组) */
- (void)loadDefaultImageWithList:(NSMutableArray *)listArrays{
    
    [self.projectModel.cameraArr removeAllObjects]; // 清空
       [self.takeCameraArr removeAllObjects]; // 清空
       NSMutableArray *sortIdList = [NSMutableArray arrayWithCapacity:12];   // 部位ID数组
       NSMutableArray *sortNameList = [NSMutableArray arrayWithCapacity:12]; // 部位名称数组
       NSMutableArray *myImgList = [NSMutableArray arrayWithCapacity:12];    // 本次拍照数组
       [sortIdList addObjectsFromArray:kPartsImgsPoIDArr[self.partsIndex]];
       [sortNameList addObjectsFromArray:kPartsImgsPoNameArr[self.partsIndex]];
       
    if (!listArrays) {
           listArrays = [NSMutableArray arrayWithCapacity:12]; // 对比图数组
           [myImgList addObjectsFromArray:kDefaultTempImageArray[self.partsIndex]];
           [listArrays addObjectsFromArray:kDefaultTempImageArray[self.partsIndex]];
           // 删除非默认数据
           [myImgList removeObjectsInRange:NSMakeRange([kPartsCountArr[self.partsIndex] intValue], 12 - [kPartsCountArr[self.partsIndex] intValue])];
           [listArrays removeObjectsInRange:NSMakeRange([kPartsCountArr[self.partsIndex] intValue], 12 - [kPartsCountArr[self.partsIndex] intValue])];
       }else{
           for (int i = 0; i < listArrays.count; i++) {
               [myImgList addObject:kDefaultTempImageArray[self.partsIndex][i]];
               if ([[listArrays objectAtIndex:i] isEqualToString:@"占位数据"]) {
                   [listArrays replaceObjectAtIndex:i withObject:kDefaultTempImageArray[self.partsIndex][i]];
               }
           }
       }
       // 默认显示的展示图
       for (int i = 0; i < listArrays.count; i++) {
           EPImageModel *modelPic = [EPImageModel new];
           modelPic.subCateId = self.projectModel.subCateId;
           modelPic.subCateName = self.projectModel.subCateName;
           modelPic.cateId = self.projectModel.cateId;
           modelPic.cateName = self.projectModel.cateName;
           modelPic.sort = i;
           modelPic.sortId = sortIdList[i];
           modelPic.sortName = sortNameList[i];
           modelPic.isPaiZhaoFlag = @"NO";
           modelPic.cameraImgStr = myImgList[i];
           modelPic.tempImgStr = listArrays[i];
           modelPic.composeImgStr = @"";
           [self.projectModel.cameraArr addObject:modelPic];
           
           EPTakePictureModel *photoModel = [EPTakePictureModel new];
           photoModel.partsIndex = self.partsIndex;
           photoModel.index = i;
           if ([listArrays[i] rangeOfString:@"jpg"].location == NSNotFound) {
               
               photoModel.defaultImage = [[SqliteManager sharedInstance] getImageFromSandboxWith:listArrays[i] isCacheImg:NO isOriginal:NO];
           }
           photoModel.title = kPartsImgsPoNameArr[self.partsIndex][i];
           [self.takeCameraArr addObject:photoModel];
       }
}

/** 从数据库查询用户已有的数据 */
- (void)loadImgDataForDataBase{
    
     
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
    [self.tableView registerNib:[UINib nibWithNibName:[EPAngleHeaderCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[EPAngleHeaderCell cellID]];
    [self.tableView registerNib:[UINib nibWithNibName:[EPAngleSelectCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[EPAngleSelectCell cellID]];
    [self.tableView registerNib:[UINib nibWithNibName:[EPAngleBottomCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[EPAngleBottomCell cellID]];
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
        cell.clickBlock = ^(NSInteger selectIndex) { [weakself headerViewSelectWithIndex:selectIndex]; };
        return cell;
    }else if(indexPath.section == 1){
        
        EPAngleSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:[EPAngleSelectCell cellID] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectBlock = ^(NSInteger selectIndex) { [weakself selectViewSelectWithIndex:selectIndex]; };
        cell.refreshFoldBlock = ^{ [weakself.tableView reloadData]; };
             
        return cell;
    }else{
        
        EPAngleBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:[EPAngleBottomCell cellID] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([self.projectModel.subCateId isEqualToString:kShuQianID]) { cell.isShowAdd = YES; }else{ cell.isShowAdd = NO; }
        cell.dataArray = self.takeCameraArr;
        cell.angleSelectBlock = ^(NSInteger selectIndex) {  [weakself bottomViewSelectWithIndex:selectIndex]; };
        return cell;
    }
}

@end
