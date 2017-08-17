//
//  ZZFileManager.h
//  ZZChainDemo
//
//  Created by cooper Cher on 2017/8/17.
//  Copyright © 2017年 Celnet Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  file保存路径
 */
typedef NS_ENUM(NSInteger,ZZFilePathType) {
    /**
     *  沙盒根路径
     */
    ZZFilePathDocument = 0,
    /**
     *  lib根路径
     */
    ZZFilePathLibrary,
    /**
     *  缓存路径
     */
    ZZFilePathCache,
    /**
     *  临时文件路径
     */
    ZZFilePathTemp,
};
@interface ZZFileManager : NSObject


+ (instancetype _Nullable )share;

/**
 *  获取沙盒根目录路径
 *
 *  @param fileType 沙盒类型
 *
 *  @return 路径
 */
- (nullable NSString *)filePathWithType:(ZZFilePathType)fileType;


/**
 *  判断文件是否存在
 *
 *  @param path 文件路径
 *
 *  @return 存在与否
 */
- (BOOL)fileExistAtPath:(nonnull NSString *)path;

/**
 *  创建多级子目录
 *
 *  @param path 文件全路径
 *
 *  @return 创建成功与否
 */
- (BOOL)createDirectoryWithPath:(nonnull NSString *)path;

/**
 *  获取目录下所有文件
 *
 *  @param rootPath  指定目录文件
 *  @param predicate 筛选条件
 *
 *  @return 默认输出所有带后缀的文件
 */
- (nullable NSArray *)contentNamesAtDirectory:(nonnull NSString *)rootPath withPredicate:(nullable NSPredicate *)predicate;

/**
 *  清除文件夹文件
 *
 *  @param path 文件目录
 *
 *  @return 成功与否
 */
- (BOOL)removeFiles:(nonnull NSString *)path;

/**
 *  文件大小
 *
 *  @param path 文件目录
 *
 *  @return 文件大小
 */
- (CGFloat)filesSizeAtPath:(NSString *_Nonnull)path;

@end
