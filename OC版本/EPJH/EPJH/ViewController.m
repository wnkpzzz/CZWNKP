//
//  ViewController.m
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "ViewController.h"
#import "TempTableViewCell.h"
#import "RootTableViewDataSource.h"


@interface ViewController ()<UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableItems;
@property (nonatomic, strong) RootTableViewDataSource *tableViewDataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self semaphoreTaskTest];

//    [self loadBaseConfig];
//    [self asynchronousTaskTest];
}

- (void)testDemo{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
         [self asynchronousTaskTest];
     });
}

/** 信号量测试 */
- (void)semaphoreTaskTest{
   
    //crate的value表示，最多几个资源可访问。
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(3);
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
   //任务A
   dispatch_async(quene, ^{
       dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
       NSLog(@"任务A准备开始 - 1");
       sleep(3);
       NSLog(@"任务A执行结束 - 1");
       dispatch_semaphore_signal(semaphore);
   });
   //任务B
   dispatch_async(quene, ^{
       dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
       NSLog(@"任务B准备开始 - 2");
       sleep(2);
       NSLog(@"任B执行结束 - 2");
       dispatch_semaphore_signal(semaphore);
   });
   //任务c
   dispatch_async(quene, ^{
       dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
       NSLog(@"任务C准备开始 - 3");
       sleep(4);
       NSLog(@"任C执行结束 - 3");
       dispatch_semaphore_signal(semaphore);
   });
}

/** 异步任务测试 */
- (void)asynchronousTaskTest{

    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // ****************** 任务A，异步执行1秒 ************************
    dispatch_group_enter(group);
    NSLog(@"任务A准备开始");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), queue, ^{
        NSLog(@"任务A准备结束-1");
        dispatch_group_leave(group);
        NSLog(@"任务A已经结束-1");
    });
    
    // ****************** 任务B，异步执行2秒 ************************
    dispatch_group_enter(group);
    NSLog(@"任务B准备开始");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), queue, ^{
        NSLog(@"任务B准备结束-2");
        dispatch_group_leave(group);
        NSLog(@"任务B已经结束-2");
    });
      
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);// 任务A,B同时执行完才会执行下面的任务C,根据需求可以不需要。

    // ****************** 任务C，异步执行3秒 ************************
    dispatch_group_enter(group);
    NSLog(@"任务C准备开始");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), queue, ^{
        NSLog(@"任务C准备结束-3");
        dispatch_group_leave(group);
        NSLog(@"任务C已经结束-3");
    });
     
    // ****************** 所有任务完成 ************************
    dispatch_group_notify(group, queue, ^{
        NSLog(@"所有任务全部完成");
    });
     
}

#pragma mark --- 基础配置

// 初始化配置
- (void)loadBaseConfig{
    
    self.tableItems = [NSMutableArray arrayWithCapacity:10];
    NSDictionary *dic = @{@"title":@"标题01",@"name":@"张三"};
    [self.tableItems addObject:dic];
    [self.tableItems addObject:dic];
    [self.tableItems addObject:dic];
    [self.tableItems addObject:dic];
    [self.tableItems addObject:dic];
    [self.tableItems addObject:dic];
    
    
    [self setUpDataSource];
    [self.view addSubview:self.tableView];
    
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,APP_WIDTH, APP_HEIGHT) style:UITableViewStylePlain];
        _tableView.rowHeight = 90;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TempTableViewCell class]) bundle:nil] forCellReuseIdentifier:[TempTableViewCell cellID]];
    }
    return _tableView;
}

- (void)setUpDataSource{
    
    TableViewCellConfigureBlock configureCell = ^(TempTableViewCell *cell, NSDictionary *item) {
        cell.dataDic = item;
    };
    
    self.tableViewDataSource = [[RootTableViewDataSource alloc] initWithItems:self.tableItems
                                                               cellIdentifier:[TempTableViewCell cellID]
                                                           configureCellBlock:configureCell];
    self.tableView.dataSource = self.tableViewDataSource;
    
    
}

@end
