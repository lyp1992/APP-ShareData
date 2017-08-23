//
//  YPContact.h
//  Sqlite
//
//  Created by 赖永鹏 on 16/8/18.
//  Copyright © 2016年 LYP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPContact : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *iphone;

+(instancetype)contactWithName:(NSString *)name withIphoneNumber:(NSString *)iphone;

@end
