//
//  YPContactTool.h
//  Sqlite
//
//  Created by 赖永鹏 on 16/8/18.
//  Copyright © 2016年 LYP. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YPContact;
@interface YPContactTool : NSObject

//存
/**
 
 存储联系人
 contact：联系人
 **/

+(void)saveWithContact:(YPContact *)contact;

//取
/**
 
 获取联系人
 sql查询的语句
 **/

+(NSArray *)contactWithSql:(NSString *)sql;

+(NSArray *)contacts;

@end
