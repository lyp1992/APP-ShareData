//
//  YPContact.m
//  Sqlite
//
//  Created by 赖永鹏 on 16/8/18.
//  Copyright © 2016年 LYP. All rights reserved.
//

#import "YPContact.h"

@implementation YPContact

+(instancetype)contactWithName:(NSString *)name withIphoneNumber:(NSString *)iphone{

    YPContact *c = [[self alloc] init];
    c.name = name;
    c.iphone = iphone;
    
    return c;
    
}

@end
