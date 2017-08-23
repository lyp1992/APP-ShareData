//
//  ViewController.m
//  ShareDataB
//
//  Created by navchina on 2017/6/21.
//  Copyright © 2017年 navchina. All rights reserved.
//

#import "ViewController.h"
#import "YPContact.h"
#import "YPContactTool.h"
#import "MMWormhole.h"
#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *contactArry;

@property (nonatomic, strong)MMWormhole *wormHole;

@end

@implementation ViewController


-(NSMutableArray *)contactArry{
    
    if (!_contactArry) {
//

        if (_contactArry == nil) {
            
            _contactArry = [NSMutableArray array];
        }
    }
    
    return _contactArry;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"contactArry===%@",self.contactArry);

}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    NSLog(@"%s",__func__);


    //注册一个通知
    [self setNotification];

    [self setUpUI];
   
    self.tableView = [[UITableView alloc]init];
    self.tableView.frame = CGRectMake(0, 150, KWidth, KHeight - 150);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.wormHole = [[MMWormhole alloc]initWithApplicationGroupIdentifier:@"group.com.shareDataA" optionalDirectory:@"wormhole"];

    [self.wormHole listenForMessageWithIdentifier:@"RemoteDataChange" listener:^(id  _Nullable messageObject) {

        NSLog(@"+++++");
        
    }];
    
}

-(void)setNotification{

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(remotoDataChange) name:@"DataChange" object:nil];
    
}

-(void)setUpUI{

    self.tableView = [[UITableView alloc]init];
    self.tableView.frame = CGRectMake(0, 150, KWidth, KHeight - 150);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

-(void)remotoDataChange{

    if ([YPContactTool openData]) {
        
        self.contactArry = (NSMutableArray *)[YPContactTool contacts];
        
    }else{
        
        NSLog(@"打开数据库失败");
    }
    
    //    NSUserDefaults *def = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.shareDataA"];
    //
    //    self.label.text =  [def valueForKey:@"key"];
    NSError *err = nil;
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.com.shareDataA"];
    containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/widget"];
    NSString *value = [NSString stringWithContentsOfURL:containerURL encoding:NSUTF8StringEncoding error:&err];
    
    self.label.text = value;

    [self.tableView reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.contactArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *ID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
    
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    YPContact *c = self.contactArry[indexPath.row];
    
    cell.textLabel.text = c.name;
    cell.detailTextLabel.text = c.iphone;
    
    return cell;
    
}

@end
