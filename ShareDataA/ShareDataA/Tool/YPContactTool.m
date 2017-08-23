//
//  YPContactTool.m
//  Sqlite
//
//  Created by 赖永鹏 on 16/8/18.
//  Copyright © 2016年 LYP. All rights reserved.
//

#import "YPContactTool.h"
#import <sqlite3.h>
#import "YPContact.h"
#import "FileManagerTool.h"

@implementation YPContactTool

/*
 打开数据库，第一次使用这个业务类
 创建表格
 */
static sqlite3 *_db;
+(void)initialize{

//    保存沙盒地址
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//    拼接文件名
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"contact.sqlite"];
   
    
    NSLog(@"%@",NSHomeDirectory());
    //    打开数据库
    if (sqlite3_open(filePath.UTF8String, &_db)== SQLITE_OK) {
        NSLog(@"打开成功");
        
    }else{
    
        NSLog(@"打开失败");
    }
//    创建失败
    NSString *sql = @"create table if not exists t_contact (id integer primary key autoincrement,name text,iphone text)";
    char *error;
    sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &error);
    
    if (error) {
        NSLog(@"创建表格失败%s",error);
        
    }else{
    
        NSLog(@"创建表格成功");
    }

}

+(BOOL)exectWithSql:(NSString *)sql{

    BOOL flag;
    char *error;
    sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &error);
    if (error) {
        
        flag = NO;
        NSLog(@"%s",error);
    }else{
    
        flag = YES;
    }
    return flag;
}

+(void)saveWithContact:(YPContact *)contact{

    NSString *sql = [NSString stringWithFormat:@"insert into t_contact (name,iphone) values ('%@','%@')",contact.name,contact.iphone];
    
    BOOL flag = [self exectWithSql:sql];
    if (flag) {
        
        [self shareData];
        NSLog(@"插入成功");
    }else{
    
        NSLog(@"插入失败");
    }
    
}


+(NSArray *)contacts{

    return [self contactWithSql:@"select *from t_contact"];

}

+(NSArray *)contactWithSql:(NSString *)sql{

    NSMutableArray *arrM = [NSMutableArray array];
//    准备查询,生成句柄，操作查询数据结果
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(_db, sql.UTF8String, -1, &stmt, NULL)==SQLITE_OK) {
        
        //执行句柄
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            NSString *name = [NSString stringWithUTF8String:sqlite3_column_text(stmt, 1)];
            NSString *phone = [NSString stringWithUTF8String:sqlite3_column_text(stmt, 2)];
            
            YPContact *c = [YPContact contactWithName:name withIphoneNumber:phone];
            [arrM addObject:c];
            
        }
        
    }
    
    [self shareData];
    return arrM;
}

+(void)shareData{

    NSError *err = nil;
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    //    拼接文件名
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"contact.sqlite"];
    NSLog(@"filePath===%@",filePath);
    NSLog(@"date====%f",-[[NSDate date] timeIntervalSinceNow]);
     NSFileManager *fielM = [NSFileManager defaultManager];
    
    FileManagerTool *fileTool = [FileManagerTool shareManager];
    NSURL *fileUrl = [fileTool remoteDataBase];
    
    NSLog(@"fileUrl==%@",fileUrl);
    if ([fielM fileExistsAtPath:[fileUrl path]]) {
        
        [fielM removeItemAtPath:[fileUrl path] error:nil];
    }
    
    BOOL result = [fielM copyItemAtPath:filePath toPath:[fileUrl path] error:&err];
    
    if (!result) {
        NSLog(@"%@",err);
    } else {
        
         NSLog(@"NSDate*****%f",-[[NSDate date] timeIntervalSinceNow]);
        NSLog(@"写入成功");
       
        [fileTool sendSynMessage];
    }

}

@end
