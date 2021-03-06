//
//  EPHomeViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPHomeViewCtl.h"
#import "EPHomeHeadFileHandler.h"
#import "EP_Pro_DataBaseTestViewCtl.h"

#import "SqliteMainViewCtl.h"

@interface EPHomeViewCtl ()

@property (weak, nonatomic) IBOutlet UIView * headBgView;
@property (weak, nonatomic) IBOutlet UIView * centerBgView;
@property (nonatomic, strong) EPHomeCycleScrollView * headerContentView;
@property (nonatomic, strong) EPHomeCollectionView  * centerContentView;
@end

@implementation EPHomeViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadBaseConfig];
     
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark --- 基础配置

- (void)loadBaseConfig{
    
    [self.headBgView addSubview:self.headerContentView];
    [self.centerBgView addSubview:self.centerContentView];
    
    #ifdef DEBUG
        // 查看沙盒目录文件
        [[PAirSandbox sharedInstance] enableSwipe];
        [[SBWatcherManager shareManager] registWatcher];
    #endif
}

#pragma mark - 事件处理
- (IBAction)btnClickAction:(UIButton *)sender {
    
    if (sender.tag == 0) { // 个人中心
       
        EP_User_MainViewCtl * Vc = [[EP_User_MainViewCtl alloc] init];
        [self.navigationController pushViewController:Vc animated:YES];
        
    } else if (sender.tag == 1) { // 3D
         
        SqliteMainViewCtl * Vc = [[SqliteMainViewCtl alloc] init];
        [self.navigationController pushViewController:Vc animated:YES];
        
    } else if (sender.tag == 2) { //拍照
          
        EP_Files_CreateMainViewCtl * Vc = [[EP_Files_CreateMainViewCtl alloc] init]; 
        [self.navigationController pushViewController:Vc animated:YES];
     
    } else if (sender.tag == 3) { // 对比
        
        EP_Pro_DataBaseTestViewCtl * Vc = [[EP_Pro_DataBaseTestViewCtl alloc] init];
        [self.navigationController pushViewController:Vc animated:YES];

   
    }
}

#pragma mark - 懒加载

- (EPHomeCollectionView *)centerContentView {
    
    if (!_centerContentView) {
        WS(weakSelf);
        _centerContentView = [[EPHomeCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.centerBgView.width, self.centerBgView.height)];
        _centerContentView.btnClickBlock = ^(UIView * customView, NSInteger index) {
            
            NSLog(@"首页ContentView用户点击了第%ld个。",index);

            UIViewController * Vc ;
            
            switch (index) {
                case 0:
                    Vc = [[EP_Main_CaseSquareViewCtl alloc] init];
                    break;
                case 1:
                    Vc = [[EP_Files_QueryMainViewCtl alloc] init];
                    break;
                case 2:
                    Vc = [[EP_Main_PhotoPickerViewCtl alloc] init];
                    break;
                case 3:
                    Vc = [[EP_Main_OperationViewCtl alloc] init];
                    break;
                case 4:
                    Vc = [[EP_Files_ContrastCaseViewCtl alloc] init];
                    break;
                default:
                    break;
            }
            
            [weakSelf.navigationController pushViewController:Vc animated:YES];

        };
       
    }
    return _centerContentView;
}

- (EPHomeCycleScrollView *)headerContentView {
    
    if (!_headerContentView) {
        
        _headerContentView = [[EPHomeCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.headBgView.width, self.headBgView.height)];
        _headerContentView.btnClickBlock = ^(UIView * customView, NSInteger index) {
            
            NSLog(@"%ld点击了",index);
        };
        
    }
    return _headerContentView;
}

@end
