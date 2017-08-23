//
//  FileManagerTool.h
//  ShareDataA
//
//  Created by navchina on 2017/6/22.
//  Copyright © 2017年 navchina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManagerTool : NSObject

+(FileManagerTool *)shareManager;

-(NSURL *)remoteDataBase;

-(void)sendSynMessage;

@end
