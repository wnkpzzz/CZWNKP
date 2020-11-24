//
//  SqliteMainViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/11/23.
//  Copyright © 2020 Hans3D. All rights reserved.
//

#import "SqliteMainViewCtl.h"
#import "FMDatabase.h"

@interface SqliteMainViewCtl ()

@property (nonatomic, strong) FMDatabase * db;
@property (nonatomic,copy) NSString * docPath;      //沙盒地址（数据库地址）

@end

@implementation SqliteMainViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self loadBaseConfig];
  
}

- (void)loadBaseConfig {
     
    //1.获取数据库文件的路径
    _docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",_docPath);
     
    
}

//新建数据库
- (IBAction)createSQLiteMethod:(id)sender {
    NSLog(@"新建数据库");
  
    //设置数据库名称
    NSString *fileName = [_docPath stringByAppendingPathComponent:@"epjh.sqlite"];
    //2.获取数据库
    _db = [FMDatabase databaseWithPath:fileName];
    if ([_db open]) {
        NSLog(@"打开数据库成功");
    } else {
        NSLog(@"打开数据库失败");
    }
}

//删除数据库
- (IBAction)deleteSQLiteMethod:(id)sender {
    
    //设置数据库名称
    NSString *fileName = [_docPath stringByAppendingPathComponent:@"epjh.sqlite"];

    NSError *removeErr = nil;
    if (![[NSFileManager defaultManager] removeItemAtPath:fileName error:&removeErr] ) {
        NSLog(@"删除文件失败! %@", removeErr);
    }
    NSLog(@"删除数据库成功");
}

//新建表1
- (IBAction)createTable1Method:(id)sender {
    NSLog(@"新建表");
   
//    NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY AUTOINCREMENT,bindUserId text DEFAULT NULL,customerId text DEFAULT NULL,projectId text DEFAULT NULL,createTime text DEFAULT NULL,timeFormat text DEFAULT NULL,subCateId text DEFAULT NULL,subCateName text DEFAULT NULL,cateId text DEFAULT NULL,cateName text DEFAULT NULL,cameraArr text DEFAULT NULL,position text DEFAULT NULL,subSubCateId text DEFAULT NULL,project text DEFAULT NULL,subSubSubCateId text DEFAULT NULL,material text DEFAULT NULL,subSubSubSubCateId text DEFAULT NULL,remark  text DEFAULT NULL);",@"project_tab"];
    
    NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY AUTOINCREMENT,bindUserId text DEFAULT NULL,customerId text DEFAULT NULL,projectId text DEFAULT NULL);",@"project_tab"];
 
    //3.创建表
    BOOL result = [_db executeUpdate:sqlStr];

    if (result) {
        NSLog(@"创建表成功");
    } else {
        NSLog(@"创建表失败");
    }
}

//添加一条数据到数据表1
- (IBAction)addOneDataToTable1Method:(id)sender {
    NSLog(@"添加一条数据到数据表");
    
//    NSString *sqlStr = @"INSERT INTO project_tab(bindUserId,customerId,projectId,createTime,timeFormat,subCateId,subCateName,cateId,cateName,cameraArr,position,subSubCateId,project,subSubSubCateId,material,subSubSubSubCateId,remark) VALUES  (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",@"1",@"2",@"3",@"1",@"2",@"3",@"1",@"2",@"3",@"1",@"2",@"3",@"1",@"2",@"3",@"1",@"2";
    
    BOOL result = [_db executeUpdate:@"INSERT INTO project_tab (bindUserId, customerId, projectId) VALUES (?,?,?)",@"1",@"2",@"3"];
    
    if (result) {
        NSLog(@"插入成功");
    } else {
        NSLog(@"插入失败");
    }
}
 
//添加多条数据到数据表1
- (IBAction)addMoreDataToTable1Method:(id)sender {
    NSLog(@"添加多条数据到数据表");
 
}

//删除一条数据从数据表1
- (IBAction)deleteOneDataToTable1Method:(id)sender {
    NSLog(@"删除数据");
    
    //1.不确定的参数用？来占位 （后面参数必须是oc对象,需要将int包装成OC对象）
        int idNum = 11;
        BOOL result = [_db executeUpdate:@"delete from project_tab where id = ?",@(idNum)];
    //2.不确定的参数用%@，%d等来占位
//    BOOL result = [_db executeUpdateWithFormat:@"delete from t_student where name = %@",@"王子涵"];
    if (result) {
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败");
    }
}

@end








//BOOL result = [_db executeUpdate:@"INSERT INTO project_tab (bindUserId,customerId,sex) VALUES  (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)","1","2","3","1","2","3","1","2","3","1","2","3","1","2","3","1","2",@3,"1","2","3","1","2","3","1","2"];

//    NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (_id integer PRIMARY KEY AUTOINCREMENT,bindUserId  text DEFAULT NULL,customerId text DEFAULT NULL,projectId text DEFAULT NULL,createTime text DEFAULT NULL,timeFormat text DEFAULT NULL,subCateId text DEFAULT NULL,subCateName text DEFAULT NULL,cateId text DEFAULT NULL,cateName text DEFAULT NULL,cameraArr text DEFAULT NULL,position text DEFAULT NULL,subSubCateId text DEFAULT NULL,project text DEFAULT NULL,subSubSubCateId text DEFAULT NULL,material text DEFAULT NULL,subSubSubSubCateId text DEFAULT NULL,remark  text DEFAULT NULL,userInfo_id long DEFAULT NULL,realName text DEFAULT NULL,sex text DEFAULT NULL,age  text DEFAULT NULL,phone  text DEFAULT NULL,province text DEFAULT NULL,city text DEFAULT NULL,addr text DEFAULT NULL,isSelected text DEFAULT NULL);",@"project_tab"];
  
