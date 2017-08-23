//
//  FileManagerTool.m
//  ShareDataA
//
//  Created by navchina on 2017/6/22.
//  Copyright © 2017年 navchina. All rights reserved.
//

#import "FileManagerTool.h"

#import "MMWormhole.h"

@interface FileManagerTool ()

@property (nonatomic, strong)MMWormhole *wormHole;

@end

@implementation FileManagerTool


+(FileManagerTool *)shareManager{

    static FileManagerTool *fileMagager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        fileMagager = [[FileManagerTool alloc]init];
        
    });
    return fileMagager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.wormHole = [[MMWormhole alloc]initWithApplicationGroupIdentifier:@"group.com.shareDataA" optionalDirectory:@"Library/Caches/contact.sqlite"];

    }
    return self;
}

-(NSURL *)remoteDataBase{

    NSFileManager *fielM = [NSFileManager defaultManager];
    
    NSURL *url = [fielM containerURLForSecurityApplicationGroupIdentifier:@"group.com.shareDataA"];
    NSURL *fileUrl = [url URLByAppendingPathComponent:@"Library/Caches/contact.sqlite"];
    
    return fileUrl;
}

-(void)sendSynMessage{

    [self.wormHole passMessageObject:@{@"titleString":@"valueTitle"} identifier:@"RemoteDataChange"];
    
}

@end
