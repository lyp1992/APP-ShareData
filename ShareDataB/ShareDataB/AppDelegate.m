//
//  AppDelegate.m
//  ShareDataB
//
//  Created by navchina on 2017/6/21.
//  Copyright © 2017年 navchina. All rights reserved.
//

#import "AppDelegate.h"
#import "MMWormhole.h"
#import "YPContactTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"%s",__func__);
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
//      NSLog(@"%s",__func__);
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
//     NSLog(@"%s",__func__);
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
//      NSLog(@"%s",__func__);
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

    NSMutableArray *muArray = [NSMutableArray array];
    if ([YPContactTool openData]) {
        
          muArray = (NSMutableArray *)[YPContactTool contacts];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"DataChange" object:nil];
    
    NSLog(@"muArray===%@",muArray);
       NSLog(@"%s",__func__);
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
       NSLog(@"%s",__func__);
}


@end
