//
//  EP_Pop_CaseSqe_SelectView.m
//  EPJH
//
//  Created by Hans on 2020/11/5.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EP_Pop_CaseSqe_SelectView.h"
#import "EP_Cell_CaseSqe_Pop.h"


@interface EP_Pop_CaseSqe_SelectView ()<UITableViewDataSource,UITableViewDelegate>

/** 背景蒙版 */
@property (weak, nonatomic) IBOutlet UIView * maskBgView;

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint; // 控制视图左右位移

@property (nonatomic,strong) NSMutableArray * popLeftItems; // 弹出视图数据源

@end

@implementation EP_Pop_CaseSqe_SelectView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self loadBaseConfig];
}

- (void)loadBaseConfig {
    
    self.maskBgView.backgroundColor = RGB(0, 0, 0);
    self.maskBgView.alpha = 0.3;
    
    self.frame = CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT);
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    
    
    
    
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.rowHeight = 50;
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([EP_Cell_CaseSqe_Pop class]) bundle:nil] forCellReuseIdentifier:[EP_Cell_CaseSqe_Pop cellID]];
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.rowHeight = 50;
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([EP_Cell_CaseSqe_Pop class]) bundle:nil] forCellReuseIdentifier:[EP_Cell_CaseSqe_Pop cellID]];
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return 1;
}

- (NSInteger)tableView:(UITableView  *)tableView numberOfRowsInSection:(NSInteger)section {
    
     if (tableView == self.leftTableView) {
        return self.popLeftItems.count;
    }else{
        
//        if (self.popLeftItems.count > 0) {
//            YPProjectModel * model = self.popLeftItems[self.selectIndexL];
//            NSArray * cateViewsList = model.cateViews;
//            return cateViewsList.count;
//        }

        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WS(weakSelf);
    if (tableView == self.leftTableView) {
        
        EP_Cell_CaseSqe_Pop * cell = [tableView dequeueReusableCellWithIdentifier:[EP_Cell_CaseSqe_Pop cellID]];
       
//        YPProjectModel * model = self.popLeftItems[indexPath.row];
//        cell.infoLab.text = model.name;
//
//        if (self.selectIndexL == indexPath.row) { cell.infoLab.textColor = kMainBlueColor; }else{cell.infoLab.textColor = kMainTextColor; }
//
        return cell;
        
    }else{
        
        EP_Cell_CaseSqe_Pop * cell = [tableView dequeueReusableCellWithIdentifier:[EP_Cell_CaseSqe_Pop cellID]];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
//        if (self.popLeftItems.count > 0) {
//
//            YPProjectModel * model = self.popLeftItems[self.selectIndexL];
//            NSArray * listArr = [NSArray modelArrayWithClass:[YPProjectModel class] json: model.cateViews];
//            YPProjectModel * modelTwo = listArr[indexPath.row];
//            cell.infoLab.text = modelTwo.name;
//
//        }
        
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
//    if (tableView == self.leftTableView) {
//
//        self.selectIndexL = indexPath.row;
//        [self.leftTableView reloadData];
//        [self.rightTableView reloadData];
//
//
//    }
//    if (tableView == self.rightTableView) {
//
//        [self dismissPopView];
//        self.selectIndexR = indexPath.row;
//        [self screenAnLiAction];
//
//    }
}




@end
