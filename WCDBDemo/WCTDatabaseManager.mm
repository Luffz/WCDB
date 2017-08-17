//
//  WCTDatabaseManager.m
//  ZZChainDemo
//
//  Created by cooper Cher on 2017/8/17.
//  Copyright © 2017年 Celnet Technology Co.,Ltd. All rights reserved.
//

#import "WCTDatabaseManager.h"
#import "ZZFileManager.h"

NSString *const AcquiescencePath = @"APPDB/ZZDB.db";

static WCTDatabaseManager *manager = nil;


@interface WCTDatabaseManager()

@property(nonatomic, strong)WCTDatabase *database;

@end

@implementation WCTDatabaseManager

+ (instancetype)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WCTDatabaseManager alloc] init];
    });
    return manager;
}


- (NSString *)acquiescencePath{
    return [[[ZZFileManager share] filePathWithType:ZZFilePathDocument] stringByAppendingString:AcquiescencePath];
}

- (BOOL)createDBwithPath:(NSString *)path table:(NSString *)table elementClass:(Class)cls{
    if (self.database) {
        self.database = nil;
    }
    WCTDatabase *database;
    if (path && path.absolutePath) {
       database  = [[WCTDatabase alloc] initWithPath:path];
    }else{
       database  = [[WCTDatabase alloc] initWithPath:[self acquiescencePath]];
    }
    self.database = database;
    if ([database isTableExists:table]) {
        return YES;
    }else{
        return [database createTableAndIndexesOfName:table withClass:cls];;
    }
}

- (BOOL)insertObject:(id)obj table:(NSString *)table{
    if (!self.database) return NO;
    return [self.database insertObject:obj into:table];
}

- (BOOL)updateRowsInTable:(NSString *)table onProperty:(const WCTProperty &)property withObject:(id)obj{
    if (!self.database) return NO;
    return [self.database updateAllRowsInTable:table onProperty:property withObject:obj];
}

- (NSArray *)getObjectsOfClass:(id)obj fromTable:(NSString *)table{
    if (!self.database) return nil;
    return [self getObjectsOfClass:obj fromTable:obj];
}


@end
