//
//  EPHomeViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPHomeViewCtl.h"
#import "EPHomeHeadFileHandler.h"
 

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
}

#pragma mark - 事件处理
- (IBAction)btnClickAction:(UIButton *)sender {
    
    if (sender.tag == 0) { // 个人中心
       
        EP_User_MainViewCtl * Vc = [[EP_User_MainViewCtl alloc] init];
        [self.navigationController pushViewController:Vc animated:YES];
        
    } else if (sender.tag == 1) { // 3D
        
    } else if (sender.tag == 2) { //拍照
          
        EP_Files_CreateMainViewCtl * Vc = [[EP_Files_CreateMainViewCtl alloc] init]; 
        [self.navigationController pushViewController:Vc animated:YES];
     
    } else if (sender.tag == 3) { // 对比
   
    }
}

#pragma mark - 懒加载

- (EPHomeCollectionView *)centerContentView {
    
    if (!_centerContentView) {
        
        _centerContentView = [[EPHomeCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.centerBgView.width, self.centerBgView.height)];
        _centerContentView.btnClickBlock = ^(UIView * customView, NSInteger index) {
            
            NSLog(@"%ld点击了",index);
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
