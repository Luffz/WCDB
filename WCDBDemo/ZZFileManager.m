//
//  ZZFileManager.m
//  ZZChainDemo
//
//  Created by cooper Cher on 2017/8/17.
//  Copyright © 2017年 Celnet Technology Co.,Ltd. All rights reserved.
//

#import "ZZFileManager.h"

static NSUInteger const MSize = 1024 * 1024;

@implementation ZZFileManager

+ (instancetype)share{
    return [ZZFileManager new];
}

- (NSString *)filePathWithType:(ZZFilePathType)fileType{
    switch (fileType) {
        case ZZFilePathDocument:
            return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            break;
        case ZZFilePathLibrary:
            return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            break;
        case ZZFilePathCache:
            return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            break;
        case ZZFilePathTemp:
            return NSTemporaryDirectory();
            break;
        default:
            break;
    }
}

- (BOOL)fileExistAtPath:(NSString *)path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

- (BOOL)createDirectoryWithPath:(NSString *)path
{
    //    NSLog(@"%@",path);
    NSFileManager *fm = [NSFileManager defaultManager];
    
    BOOL isok = YES;
    BOOL isDir = NO;
    BOOL isEx = [fm fileExistsAtPath:path isDirectory:&isDir];
    if (isEx) {
        return YES;
    }
    
    NSString *baseS = [path copy];
    while (!isEx && !isDir) {
        baseS = [baseS stringByDeletingLastPathComponent];
        isEx = [fm fileExistsAtPath:baseS isDirectory:&isDir];
    }
    
    NSRange range = [path rangeOfString:baseS];
    NSString *subS;
    if (range.length < path.length) {
        subS = [path substringFromIndex:range.length + 1];
    }
    else {
        subS = [path substringFromIndex:range.length];
    }
    NSArray *arr = [subS componentsSeparatedByString:@"/"];
    
    NSUInteger count = arr.count;
    NSString *extension = [path pathExtension];
    if (extension && ![extension isEqualToString:@""]) {
        count -= 1;
    }
    for (int i = 0; i < count; i ++) {
        baseS = [baseS stringByAppendingPathComponent:arr[i]];
        isok &= [fm createDirectoryAtPath:baseS withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return isok;
}

- (NSArray *)contentNamesAtDirectory:(NSString *)rootPath withPredicate:(nullable NSPredicate *)predicate
{
    NSPredicate *pre;
    
    if (!predicate) {
        pre = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@",@"."];
    }
    else
        pre = predicate;
    NSArray *temp = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:rootPath error:nil];
    return [temp filteredArrayUsingPredicate:pre];
}

- (BOOL)removeFiles:(NSString *)path
{
    NSError *error;
    BOOL ok = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    
    if (!ok && error) {
        NSLog(@"remove error: %@",error);
    }
    return ok;
}

- (unsigned long long)fileSizeAtPath:(NSString *)path
{
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        return [fm attributesOfItemAtPath:path error:nil].fileSize;
    }
    return 0;
}

- (CGFloat)filesSizeAtPath:(NSString *)path
{
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path]) {
        return 0;
    }
    unsigned long long size = 0;
    NSEnumerator *enumer = [[fm subpathsAtPath:path] objectEnumerator];
    while ([enumer nextObject] != nil) {
        NSString *filePath = [path stringByAppendingPathComponent:[enumer nextObject]];
        size += [self fileSizeAtPath:filePath];
    }
    return (size * 1.0) / MSize ;
}

@end
