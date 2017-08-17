//
//  WCTDatabaseManager.h
//  ZZChainDemo
//
//  Created by cooper Cher on 2017/8/17.
//  Copyright © 2017年 Celnet Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>

@interface WCTDatabaseManager : NSObject

+ (instancetype)share;

- (BOOL)createDBwithPath:(NSString *)path table:(NSString *)table elementClass:(Class)cls;

- (BOOL)insertObject:(id)obj table:(NSString *)table;

- (BOOL)updateRowsInTable:(NSString *)table onProperty:(const WCTProperty &)property withObject:(id)obj;

- (NSArray *)getObjectsOfClass:(id)obj fromTable:(NSString *)table;

@end
