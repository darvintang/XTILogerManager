//
//  XTILogerManager.h
//  XTILogerManager
//
//  Created by Input on 2018/6/17.
//  Copyright © 2018年 input. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __has_include(<SSZipArchive/SSZipArchive.h>)
#import <SSZipArchive/SSZipArchive.h>
#else
#import "SSZipArchive.h"
#endif

#import "XTILoger.h"

/**
 日志管理类，包括设置输出日志等级、分享日志文件。同一级别的日志文件只保存两个
 */
@interface XTILogerManager : NSObject

/**
将日志压缩输出
 */
- (void)showLogZipWithFormVC:(UIViewController *)VC complete:(BOOL (^)(NSString *path))complete;
- (void)showLogZipWithLevel:(XTILogerLevel)level formVC:(UIViewController *)VC complete:(BOOL (^)(NSString *path))complete;

- (BOOL)removeLogerFiles;
- (BOOL)removeLogerFileWithLevel:(XTILogerLevel)level;

/**
 控制台输出的日志等级，默认全部打开
 */
@property (nonatomic, assign) XTILogerLevel printLevel;
/**
 写入文件的最低日志等级，如果不需要保存就设置为off。如果在控制板上设置了该属性那么该属性再设置的就无效
 */
@property (nonatomic, assign) XTILogerLevel saveLevel;

+ (instancetype)shared;

@end
