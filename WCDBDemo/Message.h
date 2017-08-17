//
//  Message.h
//  ZZChainDemo
//
//  Created by cooper Cher on 2017/8/16.
//  Copyright © 2017年 Celnet Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>

@interface Message : NSObject<WCTTableCoding>

@property(nonatomic,copy)NSString *mes_id;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSDate *time;

WCDB_PROPERTY(mes_id)
WCDB_PROPERTY(title)
WCDB_PROPERTY(time)

@end
