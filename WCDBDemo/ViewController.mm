//
//  ViewController.m
//  WCDBDemo
//
//  Created by cooper Cher on 2017/8/15.
//  Copyright © 2017年 Celnet Technology Co.,Ltd. All rights reserved.
//

#import "ViewController.h"

#import <WCDB/WCDB.h>
#import "Message.h"

#import "WCTDatabaseManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
#pragma mark  更多用法请参考 https://github.com/Tencent/wcdb
    
    [self wcdb];
    [self wcdbManager];
    
}


- (void)wcdb{
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/DB/WC.db"];
    
    WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
    BOOL result = [database createTableAndIndexesOfName:@"message"
                                              withClass:Message.class];
    
    Message *message = [[Message alloc] init];
    message.mes_id = @"1213";
    message.title = @"Hello, WCDB!";
    message.time = [NSDate date];
    for (NSInteger i = 0; i<100000; i++) {
        BOOL result1 = [database insertObject:message
                                         into:@"message"];
    }
    
    //Update
    //UPDATE message SET content="Hello, Wechat!";
    Message *message2 = [[Message alloc] init];
    message.title = @"Hello, Wechat!";
    BOOL result3 = [database updateRowsInTable:@"message" onProperty:Message.title withObject:message orderBy:Message.mes_id.order() limit:20];
    
    
    //Retrieve
    //SELECT * FROM message ORDER BY localID
    NSArray<Message *> *messages = [database getObjectsOfClass:Message.class
                                                     fromTable:@"message"
                                                       orderBy:Message.mes_id.order()];
    NSLog(@"messages:%@",messages);
}

- (void)wcdbManager{
    
    WCTDatabaseManager *manager = [WCTDatabaseManager share];
    [manager createDBwithPath:nil table:@"message" elementClass:Message.class];
    
    Message *message = [[Message alloc] init];
    message.mes_id = @"12133";
    message.title = @"Hello, WCDB!";
    message.time = [NSDate date];
    for (NSInteger i = 0; i<100; i++) {
        BOOL result1 = [manager insertObject:message table:@"message"];
    }
    
    Message *message2 = [[Message alloc] init];
    message.title = @"Hello, Wechat!";
    BOOL result3 = [manager updateRowsInTable:@"message" onProperty:Message.title withObject:message];
    
    
    //Retrieve
    //SELECT * FROM message ORDER BY localID
    NSArray<Message *> *messages = [manager getObjectsOfClass:Message.class
                                                     fromTable:@"message"];
    NSLog(@"managerMessages:%@",messages);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
