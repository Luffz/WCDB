# WCDB
WCDBDemo 

腾讯微信开源的一个数据库 WCDB 官方介绍读写效率比FMDB要快好几倍，api 相对于FMDB 更直白简洁，效率体验了一把确实如此 

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
    
    更多用法请参考 https://github.com/Tencent/wcdb
