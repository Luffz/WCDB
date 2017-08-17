//
//  Message.m
//  ZZChainDemo
//
//  Created by cooper Cher on 2017/8/16.
//  Copyright © 2017年 Celnet Technology Co.,Ltd. All rights reserved.
//

#import "Message.h"

@implementation Message

WCDB_IMPLEMENTATION(Message)
WCDB_SYNTHESIZE(Message, mes_id)
WCDB_SYNTHESIZE(Message, title)
WCDB_SYNTHESIZE(Message, time)


WCDB_PRIMARY(Message, mes_id)

@end


