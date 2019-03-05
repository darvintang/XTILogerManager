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
 日志控制器，主要内容就是一个表格，点击表格的cell会调用clickExt闭包(日志相关的闭包除外)
 扩展功能，例如需要扩展一个切换服务器域名功能，那就将功能的名字放到字典里，key用于title，value用于detail，然后在clickExt闭包实现相关功能。
 */
- (void)showManagerViewController:(UIViewController *)VC extDict:(NSDictionary<NSString *, NSString *> *)extDict;
@property (nonatomic, copy) void (^ clickExt)(UIViewController *viewController, NSString *name);
/**
 控制台输出的日志等级，默认全部打开
 */
@property (nonatomic, assign) XTILogerLevel printLevel;
/**
 写入文件的最低日志等级，如果不需要保存就设置为off。如果在控制板上设置了该属性那么该属性再设置的就无效
 */
@property (nonatomic, assign) XTILogerLevel saveLevel;

+ (instancetype)sharedInstance;

@end
