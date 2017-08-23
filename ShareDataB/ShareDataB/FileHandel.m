//
//  FileHandel.m
//  ShareDataB
//
//  Created by navchina on 2017/6/22.
//  Copyright © 2017年 navchina. All rights reserved.
//

#import "FileHandel.h"

@implementation FileHandel

+(FileHandel *)shareFileManager{

    static FileHandel *fileHandle;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        fileHandle = [[FileHandel alloc]init];
    });
    
    return fileHandle;
}

-(BOOL)fileUrlIsExsit{

    NSFileManager *fileM = [NSFileManager defaultManager];
    
    NSURL *url = [fileM containerURLForSecurityApplicationGroupIdentifier:@"group.com.shareDataA"];
    NSURL *fileUrl = [url URLByAppendingPathComponent:@"Library/Caches/contact.sqlite"];
   
    return [fileM fileExistsAtPath:[fileUrl path]];
    
}


@end
