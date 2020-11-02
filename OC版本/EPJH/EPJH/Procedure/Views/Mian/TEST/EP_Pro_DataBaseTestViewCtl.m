//
//  EP_Pro_DataBaseTestViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/9/18.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EP_Pro_DataBaseTestViewCtl.h"
#import "EPUserInfoModel.h"
#import "EPProjectModel.h"

#import "PersonVO.h"

@interface EP_Pro_DataBaseTestViewCtl ()
{
    FMDatabase *db;
}
// 模拟数据
@property (nonatomic,strong) NSMutableArray *myFrisDataArr;
@property (nonatomic,strong) NSMutableArray *myProsDataArr;
@property (nonatomic,strong) NSMutableArray *myImgsProDataArr;
@property (nonatomic,strong) NSMutableArray *resultFrisDataArr;
@property (nonatomic,strong) NSMutableArray *resultProsDataArr;
@property (nonatomic,strong) NSMutableArray *resultImgsProDataArr;

@property (nonatomic,strong) NSMutableArray<EPTakePictureModel *> *myTakePicDataArr;
 
//@property (nonatomic,strong) FMDatabase *db;

// 信号量控制线程同步
@property (nonatomic, strong) dispatch_semaphore_t semaphore;


@end

@implementation EP_Pro_DataBaseTestViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self testFMDB]; return;
    
    self.myFrisDataArr = [NSMutableArray arrayWithCapacity:10];
    self.myProsDataArr = [NSMutableArray arrayWithCapacity:10];
    self.myImgsProDataArr = [NSMutableArray arrayWithCapacity:10];
    self.resultFrisDataArr = [NSMutableArray arrayWithCapacity:10];
    self.resultProsDataArr = [NSMutableArray arrayWithCapacity:10];
    self.resultImgsProDataArr = [NSMutableArray arrayWithCapacity:10];
    self.myTakePicDataArr = [NSMutableArray arrayWithCapacity:10];


 
    [self getLocalFrisData];


}
 
// *******************************************************
- (void)testFMDB {
     
    UIButton *insert = [UIButton buttonWithType: UIButtonTypeCustom];
    insert.frame = CGRectMake(20, 80, self.view.frame.size.width-40, 40);
    [insert setTitle:@"insert db" forState:UIControlStateNormal];
    insert.titleLabel.font = [UIFont systemFontOfSize:15];
    insert.backgroundColor = [UIColor redColor];
    [insert addTarget:self action:@selector(handleInsert:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:insert];
    
    UIButton *delete = [UIButton buttonWithType: UIButtonTypeCustom];
    delete.frame = CGRectMake(20, CGRectGetMaxY(insert.frame)+10, self.view.frame.size.width-40, 40);
    [delete setTitle:@"delete db" forState:UIControlStateNormal];
    delete.titleLabel.font = [UIFont systemFontOfSize:15];
    delete.backgroundColor = [UIColor yellowColor];
    [delete addTarget:self action:@selector(handleDelete:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delete];
    
    UIButton *update = [UIButton buttonWithType: UIButtonTypeCustom];
    update.frame = CGRectMake(20, CGRectGetMaxY(delete.frame)+10, self.view.frame.size.width-40, 40);
    [update setTitle:@"update db" forState:UIControlStateNormal];
    update.titleLabel.font = [UIFont systemFontOfSize:15];
    update.backgroundColor = [UIColor blueColor];
    [update addTarget:self action:@selector(handleUpdate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:update];
    
    UIButton *query = [UIButton buttonWithType: UIButtonTypeCustom];
    query.frame = CGRectMake(20, CGRectGetMaxY(update.frame)+10, self.view.frame.size.width-40, 40);
    [query setTitle:@"query db" forState:UIControlStateNormal];
    query.titleLabel.font = [UIFont systemFontOfSize:15];
    query.backgroundColor = [UIColor purpleColor];
    [query addTarget:self action:@selector(handleQuery:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:query];
    
    UIButton *transaction = [UIButton buttonWithType: UIButtonTypeCustom];
    transaction.frame = CGRectMake(20, CGRectGetMaxY(query.frame)+10, self.view.frame.size.width-40, 40);
    [transaction setTitle:@"transaction db" forState:UIControlStateNormal];
    transaction.titleLabel.font = [UIFont systemFontOfSize:15];
    transaction.backgroundColor = [UIColor purpleColor];
    [transaction addTarget:self action:@selector(handleTransaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:transaction];
    
    UIButton *notransaction = [UIButton buttonWithType: UIButtonTypeCustom];
    notransaction.frame = CGRectMake(20, CGRectGetMaxY(transaction.frame)+10, self.view.frame.size.width-40, 40);
    [notransaction setTitle:@"notransaction db" forState:UIControlStateNormal];
    notransaction.titleLabel.font = [UIFont systemFontOfSize:15];
    notransaction.backgroundColor = [UIColor purpleColor];
    [notransaction addTarget:self action:@selector(handleNotransaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:notransaction];
    
    UIButton *mutilLine = [UIButton buttonWithType: UIButtonTypeCustom];
    mutilLine.frame = CGRectMake(20, CGRectGetMaxY(notransaction.frame)+10, self.view.frame.size.width-40, 40);
    [mutilLine setTitle:@"mutilLine db" forState:UIControlStateNormal];
    mutilLine.titleLabel.font = [UIFont systemFontOfSize:15];
    mutilLine.backgroundColor = [UIColor purpleColor];
    [mutilLine addTarget:self action:@selector(handleMutilLine:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mutilLine];
    
    UIButton *protectmutilLine = [UIButton buttonWithType: UIButtonTypeCustom];
    protectmutilLine.frame = CGRectMake(20, CGRectGetMaxY(mutilLine.frame)+10, self.view.frame.size.width-40, 40);
    [protectmutilLine setTitle:@"protectmutilLine db" forState:UIControlStateNormal];
    protectmutilLine.titleLabel.font = [UIFont systemFontOfSize:15];
    protectmutilLine.backgroundColor = [UIColor purpleColor];
    [protectmutilLine addTarget:self action:@selector(handleProtectMutilLine:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:protectmutilLine];
    
    
    [self initDataBase];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)initDataBase {
    //1.创建database路径
    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"test.db"];
    NSLog(@"!!!dbPath = %@",dbPath);
     //2.创建对应路径下数据库
    db = [FMDatabase databaseWithPath:dbPath];
    //3.在数据库中进行增删改查操作时，需要判断数据库是否open，如果open失败，可能是权限或者资源不足，数据库操作完成通常使用close关闭数据库
    [db open];
    if (![db open]) {
        NSLog(@"db open fail");
        return;
    }
    //4.数据库中创建表（可创建多张）
    NSString *sql = @"create table if not exists t_student ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'name' TEXT NOT NULL, 'phone' TEXT NOT NULL,'score' INTEGER NOT NULL)";
    //5.执行更新操作 此处database直接操作，不考虑多线程问题，多线程问题，用FMDatabaseQueue 每次数据库操作之后都会返回bool数值，YES，表示success，NO，表示fail,可以通过 @see lastError @see lastErrorCode @see lastErrorMessage
    BOOL result = [db executeUpdate:sql];
    if (result) {
        NSLog(@"create table success");
        
    }
    [db close];
}

- (void)handleInsert:(UIButton *)sender {
    [db open];
    //0.直接sql语句
//    BOOL result = [db executeUpdate:@"insert into 't_student' (ID,name,phone,score) values(110,'x1','11',83)"];
    //1.
//    BOOL result = [db executeUpdate:@"insert into 't_student'(ID,name,phone,score) values(?,?,?,?)",@111,@"x2",@"12",@23];
    //2.
//    BOOL result = [db executeUpdateWithFormat:@"insert into 't_student' (ID,name,phone,score) values(%d,%@,%@,%d)",112,@"x3",@"13",43];
    //3.
    BOOL result = [db executeUpdate:@"insert into 't_student'(ID,name,phone,score) values(?,?,?,?)" withArgumentsInArray:@[@113,@"x3",@"13",@53]];
    //4.
//    BOOL result = [db executeUpdate:@"insert into 't_student' (ID,name,phone,score) values(:ID,:name,:phone,:score)" withParameterDictionary:@{@"ID":@114,@"name":@"x4",@"phone":@"14",@"score":@89}];
    if (result) {
        NSLog(@"insert into 't_studet' success");
        [self showAlertWithTitle:@"insert  success" message:nil person:nil];
    } else {
        [self showAlertWithTitle:[db lastError].description message:nil person:nil];
    }
    [db close];
    
}
-(void)handleDelete:(UIButton *)sender {
    [db open];
    ///0.直接sql语句
//    BOOL result = [db executeUpdate:@"delete from 't_student' where ID = 110"];
    //1.
//    BOOL result = [db executeUpdate:@"delete from 't_student' where ID = ?",@(111)];
    //2.
//    BOOL result = [db executeUpdateWithFormat:@"delete from 't_student' where ID = %d",112];
    //3.
    BOOL result = [db executeUpdate:@"delete from 't_student' where ID = ?" withArgumentsInArray:@[@113]];
    //4.
//    BOOL result = [db executeUpdate:@"delete from 't_student' where :ID = ?" withParameterDictionary:@{@"ID":@"114"}];
    if (result) {
        NSLog(@"delete from 't_student' success");
        [self showAlertWithTitle:@"delete  success" message:nil person:nil];
    } else {
        [self showAlertWithTitle:[db lastError].description message:nil person:nil];
    }
    [db close];
    
}
-(void)handleUpdate:(UIButton *)sender {
    [db open];
    //0.直接sql语句
//    BOOL result = [db executeUpdate:@"update 't_student' set ID = 110 where name = 'x1'"];
    //1.
//    BOOL result = [db executeUpdate:@"update 't_student' set ID = ? where name = ?",@111,@"x2" ];
    //2.
//    BOOL result = [db executeUpdateWithFormat:@"update 't_student' set ID = %d where name = %@",113,@"x3" ];
    //3.
    BOOL result = [db executeUpdate:@"update 't_student' set ID = ? where name = ?" withArgumentsInArray:@[@113,@"x3"]];
    //4.
//    BOOL result = [db executeUpdate:@"update 't_student' set :ID = ? where :name = ?" withParameterDictionary:@{@"ID":@114,@"name":@"x4"}];
    if (result) {
        NSLog(@"update 't_student' success");
        [self showAlertWithTitle:@"update  success" message:nil person:nil];
    } else {
        [self showAlertWithTitle:[db lastError].description message:nil person:nil];
    }
    [db close];
}
-(void)handleQuery:(UIButton *)sender {
    [db open];
    //0.直接sql语句
//    FMResultSet *result = [db executeQuery:@"select * from 't_student' where ID = 110"];
    //1.
//    FMResultSet *result = [db executeQuery:@"select *from 't_student' where ID = ?",@111];
    //2.
//    FMResultSet *result = [db executeQueryWithFormat:@"select * from 't_student' where ID = %d",112];
    //3.
    FMResultSet *result = [db executeQuery:@"select * from 't_student' where ID = ?" withArgumentsInArray:@[@113]];
    //4
//    FMResultSet *result = [db executeQuery:@"select * from 't_sutdent' where ID = ?" withParameterDictionary:@{@"ID":@114}];
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        PersonVO *person = [PersonVO new];
        person.ID = [result intForColumn:@"ID"];
        person.name = [result stringForColumn:@"name"];
        person.phone = [result stringForColumn:@"phone"];
        person.score = [result intForColumn:@"score"];
        [arr addObject:person];
        NSLog(@"从数据库查询到的人员 %@",person.name);
        [self showAlertWithTitle:@"query  success" message:nil person:person];
        
    }
}
/**
 transaction:事务 开启一个事务执行多个任务，效率高
 1.fmdb 封装transaction 方法，操作简单
 - (BOOL)beginTransaction;
 - (BOOL)beginDeferredTransaction;
 - (BOOL)beginImmediateTransaction;
 - (BOOL)beginExclusiveTransaction;
 - (BOOL)commit;
 - (BOOL)rollback;
 等等
 */
- (void)handleTransaction:(UIButton *)sender {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [documentPath stringByAppendingPathComponent:@"test1.db"];
    FMDatabase *db = [[FMDatabase alloc]initWithPath:dbPath];
    [db open];
    if (![db open]) {
        return;
    }
    BOOL result = [db executeUpdate:@"create table if not exists text1 (name text,age,integer,ID integer)"];
    if (result) {
        NSLog(@"create table success");
    }
    //1.开启事务
    [db beginTransaction];
    NSDate *begin = [NSDate date];
    BOOL rollBack = NO;
    @try {
       //2.在事务中执行任务
        for (int i = 0; i< 500; i++) {
            NSString *name = [NSString stringWithFormat:@"text_%d",i];
            NSInteger age = i;
            NSInteger ID = i *1000;
            
            BOOL result = [db executeUpdate:@"insert into text1(name,age,ID) values(:name,:age,:ID)" withParameterDictionary:@{@"name":name,@"age":[NSNumber numberWithInteger:age],@"ID":@(ID)}];
            if (result) {
                NSLog(@"在事务中insert success");
            }
        }
    }
    @catch(NSException *exception) {
        //3.在事务中执行任务失败，退回开启事务之前的状态
        rollBack = YES;
        [db rollback];
    }
    @finally {
        //4. 在事务中执行任务成功之后
        rollBack = NO;
        [db commit];
    }
    NSDate *end = [NSDate date];
    NSTimeInterval time = [end timeIntervalSinceDate:begin];
    NSLog(@"事务中执行插入任务 所需要的时间 = %f",time);
    
}
-(void)handleNotransaction:(UIButton *)sender {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [documentPath stringByAppendingPathComponent:@"test1.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    [db open];
    if (![db open]) {
        return;
    }
    BOOL result = [db executeUpdate:@"create table if not exists text2('ID' INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,age INTRGER)"];
    if (!result) {
        [db close];
    }
    NSDate *begin = [NSDate date];
    for (int i = 0; i< 500; i++) {
        NSString *name = [NSString stringWithFormat:@"text_%d",i];
        NSInteger age = i;
        NSInteger ID = i *1000;
        
        BOOL result = [db executeUpdate:@"insert into text2(name,age,ID) values(:name,:age,:ID)" withParameterDictionary:@{@"name":name,@"age":[NSNumber numberWithInteger:age],@"ID":@(ID)}];
        if (result) {
            NSLog(@"不在事务中insert success");
        }
    }
    NSDate *end = [NSDate date];
    NSTimeInterval time = [end timeIntervalSinceDate:begin];
    NSLog(@"事务中执行插入任务 所需要的时间 = %f",time);
}
/**
 在多条线程中不允许使用同一个FMDataBase实例对象，如果使用可能会造成数据丢失或者混乱，为了保证数据库操作时线程安全，引入FMDataBaseQueue
 */

- (void)handleMutilLine:(UIButton *)sender {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [documentPath stringByAppendingPathComponent:@"test2.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    [db open];
    if (![db open]) {
        return;
    }
    BOOL result = [db executeUpdate:@"create table if not exists text3('ID' INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,age INTRGER)"];
    if (!result) {
        return;
    }
    NSLog(@"create table = %@",[NSThread currentThread]);
    //测试开启多个线程操作数据库
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_async(group, queue, ^{
        BOOL result = [db executeUpdate:@"insert into text3(ID,name,age) values(:ID,:name,:age)" withParameterDictionary:@{@"ID":@10,@"name":@"10",@"age":@10}];
        if (result) {
            NSLog(@"在group insert 10 success");
        }
        NSLog(@"current thread = %@",[NSThread currentThread]);
        
    });
    dispatch_group_async(group, queue, ^{
        BOOL result = [db executeUpdate:@"insert into text3(ID,name,age) values(:ID,:name,:age)" withParameterDictionary:@{@"ID":@11,@"name":@"11",@"age":@11}];
        if (result) {
            NSLog(@"在group insert 11 success");
        }
        NSLog(@"current thread = %@",[NSThread currentThread]);
        
    });
    dispatch_group_async(group, queue, ^{
        BOOL result = [db executeUpdate:@"insert into text3(ID,name,age) values(:ID,:name,:age)" withParameterDictionary:@{@"ID":@12,@"name":@"12",@"age":@12}];
        if (result) {
            NSLog(@"在group insert 12 success");
        }
        NSLog(@"current thread = %@",[NSThread currentThread]);
        
    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"done");
        NSLog(@"current thread = %@",[NSThread currentThread]);
        BOOL result = [db executeQuery:@"select * from text3 where ID = ?",@(10)];
        if (result) {
            NSLog(@"query 10 success");
        }
        BOOL result2 = [db executeQuery:@"select * from text3 where ID = ?",@(11)];
        if (result2) {
            NSLog(@"query 11 success");
        }
        BOOL result3 = [db executeQuery:@"select * from text3 where ID = ?",@(12)];
        if (result3) {
            NSLog(@"query 12 success");
        }
        
    });
    
}
-(void)handleProtectMutilLine:(UIButton *)sender {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [documentPath stringByAppendingPathComponent:@"test4.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    FMDatabaseQueue *dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    [db open];
    if (![db open]) {
        return;
    }
    [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = [db executeUpdate:@"create table if not exists text4('ID' INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,age INTRGER)"];
        if (!result) {
            return;
        }
        NSLog(@"create table = %@",[NSThread currentThread]);
    }];
    [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        //测试开启多个线程操作数据库
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        dispatch_group_async(group, queue, ^{
            BOOL result = [db executeUpdate:@"insert into text4(ID,name,age) values(:ID,:name,:age)" withParameterDictionary:@{@"ID":@10,@"name":@"10",@"age":@10}];
            if (result) {
                NSLog(@"在group insert 10 success");
            }
            NSLog(@"current thread = %@",[NSThread currentThread]);
            
        });
        dispatch_group_async(group, queue, ^{
            BOOL result = [db executeUpdate:@"insert into text4(ID,name,age) values(:ID,:name,:age)" withParameterDictionary:@{@"ID":@11,@"name":@"11",@"age":@11}];
            if (result) {
                NSLog(@"在group insert 11 success");
            }
            NSLog(@"current thread = %@",[NSThread currentThread]);
            
        });
        dispatch_group_async(group, queue, ^{
            BOOL result = [db executeUpdate:@"insert into text4(ID,name,age) values(:ID,:name,:age)" withParameterDictionary:@{@"ID":@12,@"name":@"12",@"age":@12}];
            if (result) {
                NSLog(@"在group insert 12 success");
            }
            NSLog(@"current thread = %@",[NSThread currentThread]);
            
        });
        dispatch_group_notify(group, queue, ^{
            NSLog(@"done");
            NSLog(@"current thread = %@",[NSThread currentThread]);
            BOOL result = [db executeQuery:@"select * from text4 where ID = ?",@(10)];
            if (result) {
                NSLog(@"query 10 success");
            }
            BOOL result2 = [db executeQuery:@"select * from text4 where ID = ?",@(11)];
            if (result2) {
                NSLog(@"query 11 success");
            }
            BOOL result3 = [db executeQuery:@"select * from text4 where ID = ?",@(12)];
            if (result3) {
                NSLog(@"query 12 success");
            }
            
        });
    }];
    
    
    
    
}
-(void)showAlertWithTitle:(NSString *)title
                  message:(NSString *)message
                   person:(PersonVO *)person
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"sure" style:UIAlertActionStyleDefault handler:nil];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = person.name ? person.name : @"other";
    }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// *******************************************************


// 模拟得到批量用户+项目+图片数据
- (void)getLocalFrisData{
  
     for (int i = 0; i < 1; i++) {
        long idNum = 2016 + i;
        EPUserInfoModel *userModel=  [[EPUserInfoModel alloc] init];
        userModel.bindUserId = KUID;
        userModel.uid = [NSString stringWithFormat:@"%ld%@",idNum,[AppUtils getNowTimeCuo]];
        userModel.createTime = [AppUtils getNowTimeCuo];
        userModel.timeFormat = [AppUtils timestampChangeTime:[AppUtils getNowTimeCuo] WithFormat:@"yyyy-MM-dd"];
        userModel.realName = [NSString stringWithFormat:@"userName%d",i];     //姓名
        userModel.age = [NSString stringWithFormat:@"%d",arc4random()];     //年龄
        userModel.sex = (arc4random()%2==1)?@"1":@"0";            // 1-男， 0-女
        userModel.headImg = @"";
        userModel.province = (arc4random()%2==1)?@"河南省":@"广东省";     //省份
        userModel.city  = (arc4random()%2==1)?@"南阳市":@"深圳市";     //工作城市
        userModel.addr  = (arc4random()%2==1)?@"南石医院":@"南山区大族科技中心"; //工作地点
        userModel.isCollect = (arc4random()%2==1)?@"1":@"0";  // 1-收藏， 0-未收藏
         
        for (int i = 0; i < 3; i++) {
            long idNum = 3016 + i;
            NSString * proID =  [NSString stringWithFormat:@"%ld%@",idNum,[AppUtils getNowTimeCuo]];
            EPProjectModel *proInfo = [self getProjectInfoWithFriID:userModel.uid ProID:proID];
            [self.myProsDataArr addObject:proInfo];
        }
          
        [self.myFrisDataArr addObject:userModel];
     }
}

- (EPProjectModel *)getProjectInfoWithFriID:(NSString *)friID ProID:(NSString *)proID{

    EPProjectModel *proInfo=  [[EPProjectModel alloc] init];
    proInfo.bindUserId = KUID;
    proInfo.customerId = friID;
    proInfo.projectId  = proID;
    proInfo.createTime = [AppUtils getNowTimeCuo];
 
    proInfo.subCateName = (arc4random()%2==1)?@"术前":@"术后";
    proInfo.cateName = (arc4random()%2==1)?@"眼部":@"鼻部";
    proInfo.project = (arc4random()%2==1)?@"内眼角":@"鼻尖整形";
    proInfo.material = (arc4random()%2==1)?@"激光祛皱皮":@"玻尿酸";

 
    for (int i = 0; i < 1; i++) {
        
        long idNum = 4016 + i;
        NSString * imgID =  [NSString stringWithFormat:@"%ld%@",idNum,[AppUtils getNowTimeCuo]];
        EPImageModel *imgInfo = [self getImageProInfoWithFriID:proInfo.customerId ProID:proInfo.projectId ImgID:imgID];
        [self.myImgsProDataArr addObject:imgInfo];
        
        EPTakePictureModel * picModel = [[EPTakePictureModel alloc] init];
        picModel.cameraImage =kImage(@"launch_0");
        picModel.cameraImgStr = [NSString stringWithFormat:@"16%@",[AppUtils getNowTimeCuo]];
        [self.myTakePicDataArr addObject:picModel];
    }
  
    return proInfo;

}

- (EPImageModel *)getImageProInfoWithFriID:(NSString *)friID  ProID:(NSString *)proID ImgID:(NSString *)imgID{

    EPImageModel *imgInfo = [[EPImageModel alloc] init];
    imgInfo.bindUserId = KUID;
    imgInfo.customerId = friID;
    imgInfo.projectId  = proID;
    imgInfo.imageId    = imgID;
    imgInfo.createTime = [AppUtils getNowTimeCuo];
    imgInfo.timeFormat = [AppUtils timestampChangeTime:[AppUtils getNowTimeCuo] WithFormat:@"yyyy-MM-dd"];

    return imgInfo;

}

// 批量插入多条数据到用户+项目+图片表中，需要保证全部成功/失败。
// 1、使用用数据库的事务功能，来保证同时执行成功。
// 2、自己做开关标记，记录失败，回滚。
// 备注:考虑到事务需要SQL语句，这里使用框架的模型转换SQL的形式，使用信号量+标记开关来控制数据。
- (IBAction)moniInserUserListAction:(id)sender {
      
    [[SqliteLogicHandler sharedInstance] createFilesWithType:CreateFilesTypeNew Fri:self.myFrisDataArr.firstObject Pro:self.myProsDataArr.firstObject Img:self.myImgsProDataArr Pic:self.myTakePicDataArr complete:^(BOOL isSucess) {
        
            if (isSucess) {
                NSLog(@"一键保存数据_成功");
            }else{
                NSLog(@"一键保存数据_失败");
            }
    }];
    
    
 
    
    
}

- (IBAction)moniQueryUserListAction:(id)sender {
    
    [self.resultFrisDataArr removeAllObjects];
    [self.resultProsDataArr removeAllObjects];
    [self.resultImgsProDataArr removeAllObjects];
    
    // 使用信号量保证串行队列+异步操作
    self.semaphore = dispatch_semaphore_create(1);
    
    WS(weakSelf);
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    [[SqliteManager sharedInstance] queryUserTableWithUID:KUID accurateInfo:nil fuzzyInfo:nil otherSQLDict:nil complete:^(BOOL success, id  _Nonnull obj) {
       
        if (success) {
         
            NSArray * dataArr = obj;
            NSArray * sortDataArr = [[dataArr reverseObjectEnumerator] allObjects];
            NSLog(@"%@====KK",sortDataArr );
            if (sortDataArr && sortDataArr.count > 0) {
                [weakSelf.resultFrisDataArr addObjectsFromArray:sortDataArr];
            }
        }
        
        dispatch_semaphore_signal(weakSelf.semaphore);

    }];
}

- (IBAction)moniQueryUserProInfoAction:(id)sender {
    
    WS(weakSelf);
    EPUserInfoModel * userModel = self.resultFrisDataArr.firstObject;
    NSDictionary *accurateInfo = @{@"customerId":userModel.uid};
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    [[SqliteManager sharedInstance] queryProjectTableWithUID:KUID accurateInfo:accurateInfo fuzzyInfo:nil otherSQLDict:nil complete:^(BOOL success, id  _Nonnull obj) {
      dispatch_semaphore_signal(weakSelf.semaphore);

        if (success) {
          
            NSArray * dataArr = obj;
            NSArray * sortDataArr = [[dataArr reverseObjectEnumerator] allObjects];
            NSLog(@"%@====PP",sortDataArr );
            if (sortDataArr && sortDataArr.count > 0) {
                [weakSelf.resultProsDataArr addObjectsFromArray:sortDataArr];
            }
        }

    }];
    
    for (EPProjectModel * proModel in weakSelf.resultProsDataArr) {
     
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        NSDictionary *accurateInfo = @{@"projectId":proModel.projectId};
        [[SqliteManager sharedInstance] queryImageTableWithUID:KUID accurateInfo:accurateInfo fuzzyInfo:nil otherSQLDict:nil complete:^(BOOL success, id  _Nonnull obj) {
            dispatch_semaphore_signal(weakSelf.semaphore);

            NSArray * dataArr = obj;
            NSArray * sortDataArr = [[dataArr reverseObjectEnumerator] allObjects];
            NSLog(@"%@====KK",sortDataArr );
            if (sortDataArr && sortDataArr.count > 0) {
                [weakSelf.resultImgsProDataArr addObjectsFromArray:sortDataArr];
                [proModel.cameraArr addObjectsFromArray:sortDataArr];
            }
        }];
                 

    }
 
}

 
//- (void)seruofhasdihfkasodhiyf{
//
//    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *filePath = [[path lastObject] stringByAppendingPathComponent:@"10001/Fris/fri_10001.sqlite"];
//
//    //创建数据库
//    _db = [FMDatabase databaseWithPath:filePath];
//
//    //打开数据库
//    if ([_db open]) {
//        NSLog(@"打开数据库成功");
//    }else{
//        NSLog(@"打开数据库失败");
//    }
//
//    /*
//     *查询数据库
//     */
//    NSMutableArray *array = [[NSMutableArray alloc]init];
//
//    NSString *sql = @"select * FROM fri_10001 where sex = 1 and userName like '%1%' order by id asc limit 0,10 ";
//    FMResultSet *rs = [_db executeQuery:sql];
//    while ([rs next]) {
//
////        YHUserInfo *model = [[YHUserInfo alloc] init];
////        model.uid = [rs stringForColumn:@"uid"];
////        model.accessToken = [rs stringForColumn:@"accessToken"];
////        model.taxAccount = [rs stringForColumn:@"taxAccount"];
////        model.mobilephone = [rs stringForColumn:@"mobilephone"];
////
////        [array addObject:model];
//
//    }
//
//    NSLog(@"%@=====KK",array);
//
//
//}



// 更新我的好友表
- (IBAction)updateMyFriTable:(id)sender {
    
    [[SqliteManager sharedInstance] updateUsersListWithUID:KUID datalist:self.myFrisDataArr complete:^(BOOL success, id  _Nonnull obj) {
 
        if (success) {
            NSLog(@"更新多个好友信息成功");
        }else{
            NSLog(@"更新多个好友信息失败%@",obj);
        }
    }];
}
// 查询多个好友
- (IBAction)selectMoreFrisInfo:(id)sender {
    
    NSArray *uidsArray = @[@"2016",@"2018",@"2020",@"2025"];

    [[SqliteManager sharedInstance] queryUserTableWithUIDs:uidsArray complete:^(NSArray * _Nonnull successUserInfos, NSArray * _Nonnull failUids) {
   
        if (successUserInfos.count) {
            NSLog(@"查询多个好友结果%@",successUserInfos);
        }
        if (failUids.count) {
            NSLog(@"%@ not find in database",failUids);
        }
    }];
}
// 条件查询好友
- (IBAction)conditionSelectMyFriTable:(id)sender {
    
    NSDictionary *accurateInfo = @{@"sex":@"男",@"city":@""};//查找动态内容包含性别女的搜索内容

    [[SqliteManager sharedInstance] queryUserTableWithUID:KUID accurateInfo:accurateInfo fuzzyInfo:nil otherSQLDict:nil complete:^(BOOL success, id  _Nonnull obj) {
    
         if (success) {
         NSLog(@"模糊查询好友,搜索结果为\n%@",obj);
         }else{
         NSLog(@"模糊查询好友表失败");
         }
     }];
    
 
    
}
// 模糊查询好友
- (IBAction)vagueSelectMyFriTable:(id)sender {
    
    NSDictionary *fuzzyInfo = @{@"sex":@"男",@"city":@""};//查找动态内容包含性别女的搜索内容

    [[SqliteManager sharedInstance] queryUserTableWithUID:KUID accurateInfo:nil fuzzyInfo:fuzzyInfo otherSQLDict:nil complete:^(BOOL success, id  _Nonnull obj) {
   
        if (success) {
        NSLog(@"模糊查询好友,搜索结果为\n%@",obj);
        }else{
        NSLog(@"模糊查询好友表失败");
        }
    }];
}



@end
