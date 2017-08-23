//
//  ViewController.m
//  ShareDataA
//
//  Created by navchina on 2017/6/21.
//  Copyright © 2017年 navchina. All rights reserved.
//

#import "ViewController.h"
#import "YPContact.h"
#import "YPContactTool.h"
#import "FileManagerTool.h"
#import "MMWormhole.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *contactArry;

@property (nonatomic, strong)MMWormhole *wormHole;

@end

@implementation ViewController


-(NSMutableArray *)contactArry{

    if (!_contactArry) {
        
        _contactArry = (NSMutableArray *)[YPContactTool contacts];
        
        if (_contactArry == nil) {
            
            _contactArry = [NSMutableArray array];
        }
    }

    return _contactArry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
//    self.wormHole = [[MMWormhole alloc]initWithApplicationGroupIdentifier:@"group.com.shareDataA" optionalDirectory:@"wormhole"];
//    
//    小数据的共享。
//    NSUserDefaults *def = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.shareDataA"];
//    
//    [def setValue:@"shareData" forKey:@"key"];
    NSError *err = nil;
    NSURL *containerUrl = [[NSFileManager defaultManager]containerURLForSecurityApplicationGroupIdentifier:@"group.com.shareDataA"];
    containerUrl = [containerUrl URLByAppendingPathComponent:@"Library/Caches/widget"];
    NSString *value = @"asdfasdfasf";
    BOOL result = [value writeToURL:containerUrl atomically:YES encoding:NSUTF8StringEncoding error:&err];

    if (!result) {
        NSLog(@"====%@",err);
    } else {
        NSLog(@"save value:%@ success.",value);
    }
    
    
//    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//    //    拼接文件名
//    NSString *filePath = [cachePath stringByAppendingPathComponent:@"Flight.db3"];
//    NSLog(@"filePath===%@",filePath);
//
//    NSFileManager *fielM = [NSFileManager defaultManager];
//    
//    FileManagerTool *fileTool = [FileManagerTool shareManager];
//    NSURL *fileUrl = [fileTool remoteDataBase];
//    
//   
//    if ([fielM fileExistsAtPath:[fileUrl path]]) {
//        
//        [fielM removeItemAtPath:[fileUrl path] error:nil];
//    }
//    
//     NSLog(@"fileUrl==%@",fileUrl);
//    NSDate *date = [NSDate date];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        NSError *err = nil;
//        BOOL result = [fielM copyItemAtPath:filePath toPath:[fileUrl path] error:&err];
//        NSLog(@"=====%f",-[date timeIntervalSinceNow]);
//        
//        if (!result) {
//            NSLog(@"%@",err);
//        } else {
//            
//            NSLog(@"写入成功");
//            
//            //        [fileTool sendSynMessage];
//        }
//    });

    
}
- (IBAction)deleteData:(id)sender {
    
    FileManagerTool *fileTool = [FileManagerTool shareManager];
    NSFileManager *fileM = [NSFileManager defaultManager];
    if ([fileM fileExistsAtPath:[[fileTool remoteDataBase] path]]) {
        
        [fileM removeItemAtPath:[[fileTool remoteDataBase] path] error:nil];
        NSLog(@"移除成功");
        [fileTool sendSynMessage];
    }
    
}

- (IBAction)itemAddClick:(id)sender {
    
    NSArray *nameArr = @[@"啦啦啦",@"哈哈哈",@"m么么",@"嘻嘻"];
    
    NSString *name = [NSString stringWithFormat:@"%@%d",nameArr[arc4random_uniform(4)],arc4random_uniform(200)];
    
    NSString *phone = [NSString stringWithFormat:@"%d",arc4random_uniform(10000)+10000];
    YPContact *c = [YPContact contactWithName:name withIphoneNumber:phone];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.contactArry.count inSection:0];
    [self.contactArry addObject:c];
    
    //    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    //    存储到数据库
    [YPContactTool saveWithContact:c];
    
    [self.wormHole passMessageObject:@{@"titleString":name} identifier:@"RemoteDataChange"];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.contactArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *ID = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    YPContact *c = self.contactArry[indexPath.row];
    
    cell.textLabel.text = c.name;
    cell.detailTextLabel.text = c.iphone;
    return cell;
}


@end
