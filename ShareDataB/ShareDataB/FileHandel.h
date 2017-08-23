//
//  FileHandel.h
//  ShareDataB
//
//  Created by navchina on 2017/6/22.
//  Copyright © 2017年 navchina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHandel : NSObject

+(FileHandel *)shareFileManager;

-(BOOL)fileUrlIsExsit;


@end
