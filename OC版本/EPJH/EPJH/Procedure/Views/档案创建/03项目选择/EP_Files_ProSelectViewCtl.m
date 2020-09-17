//
//  EP_Files_ProSelectViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/9/17.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EP_Files_ProSelectViewCtl.h"

@interface EP_Files_ProSelectViewCtl ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (nonatomic,strong) EPTypeListClassifyModel * localDataModel;

@property (nonatomic,assign) NSUInteger thirdClassifyNum;   //现在选择的第三分类
@property (nonatomic,assign) NSUInteger fourthClassifyNum;  //现在选择的第四分类

@end

@implementation EP_Files_ProSelectViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"项目选择";
    [self loadBaseConfig];
}

#pragma mark - 基础配置
- (void)loadBaseConfig{

    
    [self loadLocalData];
    [self createTableView];
}

- (void)loadLocalData{
    

        // 拉取本地数据
        NSDictionary * testDataDic = [AppUtils readLocalFileWithName:@"ProChoose"];
        NSArray * testData = testDataDic[@"datas"];
        
        EPTypeListClassifyModel * model = [[EPTypeListClassifyModel alloc] init];
        model.name = @"";
        model.imageChooseUrl = @"";
        model.imageUrl = @"";
        model.parentId = [NSString stringWithFormat:@"%d",1];
        model.tag = [NSString stringWithFormat:@"%d",1];
        model.isSelected = NO;
        
        NSMutableArray * oneArr = [NSMutableArray arrayWithCapacity:10];  // 第一模块数组
        
        for (int z = 0; z < testData.count; z++) {
            
            NSDictionary * dic = testData[z];
            NSArray * projectArr = dic[@"project"];

            EPTypeListClassifyModel * modelOne = [[EPTypeListClassifyModel alloc] init];
            modelOne.name = dic[@"part"];
            modelOne.imageUrl = [NSString stringWithFormat:@"proSelect_no_%d",z];
            modelOne.imageChooseUrl = [NSString stringWithFormat:@"proSelect_%d",z];
            modelOne.parentId = [NSString stringWithFormat:@"%d",z];
            modelOne.tag = [NSString stringWithFormat:@"%d",z];
    //        if (z == 0) {  modelOne.isSelected = YES;  }else{   modelOne.isSelected = NO;  }  // 默认选择第一个 ZCZ1225
            [oneArr addObject:modelOne];
            
            NSMutableArray * towArr = [NSMutableArray arrayWithCapacity:10]; // 第二模块数组
            
            for (int y = 0; y < projectArr.count ; y++) {
                
                NSDictionary * proDic = projectArr[y];
                NSMutableArray * threeArr = [NSMutableArray arrayWithCapacity:10]; // 第三模块数组

                EPTypeListClassifyModel * modelTwo = [[EPTypeListClassifyModel alloc] init];
                modelTwo.name = proDic[@"name"];
                modelTwo.imageChooseUrl = @"";
                modelTwo.imageUrl = @"";
                modelTwo.parentId = [NSString stringWithFormat:@"%d",y];
                modelTwo.tag = [NSString stringWithFormat:@"%d",y];
    //            if (y == 0 && z == 0) { modelTwo.isSelected = YES;  }else{  modelTwo.isSelected = NO;  }  // 默认选择第一个 ZCZ1225

                NSArray * materialArr = proDic[@"material"];
                if (materialArr && materialArr.count > 0) {
                    for (int x = 0; x < materialArr.count ; x++) {
                        NSString * materialStr = materialArr[x];
                        EPTypeListClassifyModel * modelThree = [[EPTypeListClassifyModel alloc] init];
                        modelThree.name = materialStr;
                        modelThree.imageChooseUrl = @"";
                        modelThree.imageUrl = @"";
                        modelThree.parentId = [NSString stringWithFormat:@"%d",x];
                        modelThree.tag = [NSString stringWithFormat:@"%d",x];
                        modelThree.isSelected = NO;
                        [threeArr addObject:modelThree];
                    }
                    modelTwo.cateViews = threeArr;
                }
                
                
                [towArr addObject:modelTwo];
            }
            modelOne.cateViews = towArr;
        }
        
        model.cateViews = oneArr;
        self.localDataModel = model;
}

#pragma mark - 事件处理

- (void)oneCellSelectWithIndex:(NSInteger)index And:(BOOL)isSelected And:(BOOL)showSubList{
    
    if (showSubList) {
        self.thirdClassifyNum = index;
        [self.tableView reloadData];
    
    }else{
        
        if (isSelected) {
          
            self.thirdClassifyNum = index;
          
            //选择第三级后 默认设置第一个
            EPTypeListClassifyModel * thirdModel = self.localDataModel.cateViews[index];
            if (thirdModel.cateViews.count>0) {
                EPTypeListClassifyModel * fourthModel = thirdModel.cateViews[0];
                fourthModel.isSelected = YES;
            }
            [self.tableView reloadData];
          
        }else{
          
          //当第三级变为未选时 下级全部变为未选
          EPTypeListClassifyModel * thirdModel = self.localDataModel.cateViews[index];
          for (EPTypeListClassifyModel * fourthModel in thirdModel.cateViews) {
             
              fourthModel.isSelected = NO;
              for (EPTypeListClassifyModel *fifthModel in fourthModel.cateViews) {
                  fifthModel.isSelected = NO;
              }
          }
        }
//        [self.tableView reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)twoCellSelectWithIndex:(NSInteger)index And:(BOOL)isSelected {
    
    if (isSelected) {
        
        //第四级已选状态
        EPTypeListClassifyModel * thirdModel = self.localDataModel.cateViews[self.thirdClassifyNum];
        EPTypeListClassifyModel * fourModel = thirdModel.cateViews[index];

        if (fourModel.cateViews.count>0) {

            [EPTypeMaterialListView showTypeMaterialListWithDataArr:fourModel.cateViews resultBlock:^(NSArray *listArray) {
            fourModel.cateViews = listArray;
            //  [weakSelf.tableView reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];

            }];
        }

        // [self.tableView reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];

        }else{

        //当第四级变为未选时 下级全部变为未选
        EPTypeListClassifyModel * thirdModel = self.localDataModel.cateViews[self.thirdClassifyNum];
        EPTypeListClassifyModel * fourModel = thirdModel.cateViews[index];

        for (EPTypeListClassifyModel * fifthModel in fourModel.cateViews) {
            fifthModel.isSelected = NO;
        }

        // [self.tableView reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (void)createTableView{
    
    self.tableView.delegate     = self;
    self.tableView.dataSource   = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:[EPBodyPartTableViewCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[EPBodyPartTableViewCell cellID]];
    [self.tableView registerClass:[EPSurgeryDetailTableViewCell class] forCellReuseIdentifier:[EPSurgeryDetailTableViewCell cellID]];

 
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.section == 0) {
//
//        return 210;
//    }else if(indexPath.section == 1){
//
//        return 210;
//
//    }else{
//        return 200;
//    }
//
    
   if (indexPath.section == 0) {
       
//       if (KRealValue(210)<210) {
//           return 210;
//       }else{
//           return KRealValue(210);
//       }
       return 210;
   }else if(indexPath.section == 1){
       
       EPTypeListClassifyModel * model =self.localDataModel.cateViews[self.thirdClassifyNum];

       NSUInteger countNum = 0;
       if (model.cateViews.count%3) {
           countNum = (model.cateViews.count/3+1);
       }else{
           countNum = model.cateViews.count/3;
       }

       if (countNum == 0) {
           countNum = 1;
       }else if (countNum>3) {
           countNum = 3;
       }

       int oneCountHeight  = 0;
       if (countNum<2) {
           oneCountHeight = 56;
       }else{
           oneCountHeight = 67;
       }

//       if(KRealValue(countNum*oneCountHeight)<countNum*oneCountHeight) {
//           return countNum*oneCountHeight;
//       }else{
//           return KRealValue(countNum*oneCountHeight);
//       }
       
       return countNum*oneCountHeight;

       
   }else{
       return 200;
       
   }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10.f;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section != 2) {
        return 10.f;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = RGB(250, 250, 250);
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = RGB(250, 250, 250);
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    WS(weakSelf);
    if (indexPath.section == 0) {

        EPBodyPartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[EPBodyPartTableViewCell cellID] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.listData = self.localDataModel.cateViews;
        cell.backSelectItemBlock = ^(NSInteger index, BOOL isSelected, BOOL isShowSubList) {
            [weakSelf oneCellSelectWithIndex:index And:isSelected And:isShowSubList];
        };
        return cell;
         
    }
    else if(indexPath.section == 1){

        EPSurgeryTypeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[EPSurgeryTypeTableViewCell cellID]];
        if (!cell) {
            cell = [[EPSurgeryTypeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[EPSurgeryTypeTableViewCell cellID]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
      
        if (self.localDataModel.cateViews.count > 0 ) {
            EPTypeListClassifyModel * classifyModel = self.localDataModel.cateViews[self.thirdClassifyNum];
            cell.listData = classifyModel.cateViews;
        }
        cell.backSelectItemBlock = ^(NSInteger index, BOOL isSelected) {
            [weakSelf twoCellSelectWithIndex:index And:isSelected];
        };
        return cell;
 
        
    }
    else{
        
        EPSurgeryDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[EPSurgeryDetailTableViewCell cellID] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.showRemark = YES;
//        cell.timeLabel.text = _model.subCateName;
        cell.partLabel.text = @"部位:";
        cell.surgetyTypeLabel.text = @"项目:";
        cell.materialsLabel.text = @"材料:";
//        cell.remarkTextView.text = self.remarkStr;
        
       
        //设置列表
        for (EPTypeListClassifyModel * thridModel in self.localDataModel.cateViews) {
            if (thridModel.isSelected) {
              cell.partLabel.text = [NSString stringWithFormat:@"%@ %@",cell.partLabel.text,thridModel.name];
            }
                for (EPTypeListClassifyModel * fourthModel in thridModel.cateViews) {
                  if (fourthModel.isSelected) {
                      cell.surgetyTypeLabel.text = [NSString stringWithFormat:@"%@ %@",cell.surgetyTypeLabel.text,fourthModel.name];
                  }

                      for (EPTypeListClassifyModel * fifthModel in fourthModel.cateViews) {
                          if (fifthModel.isSelected) {
                              cell.materialsLabel.text = [NSString stringWithFormat:@"%@ %@",cell.materialsLabel.text,fifthModel.name];
                          }
                      }
                }
        }
        
        return cell;
    }
   
}

@end


