//
//  XTILoger.h
//  XTILogerManager
//
//  Created by Input on 2018/6/17.
//  Copyright © 2018年 input. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LogerFileMaxLength 1048576 //日志文件最大长度，1M

/**
 日志等级

 - XTILogerLevelAll: 这个用于获取所有日志文件
 - XTILogerLevelDebug: 调试日志
 - XTILogerLevelInfo: 信息日志
 - XTILogerLevelWarning: 警告日志
 - XTILogerLevelError: 错误日志
 - XTILogerLevelCrash: 崩溃日志
 - XTILogerLevelOff: 关闭日志
 */
typedef NS_ENUM(NSInteger, XTILogerLevel) {
    XTILogerLevelAll,
    XTILogerLevelDebug,
    XTILogerLevelInfo,
    XTILogerLevelWarning,
    XTILogerLevelError,
    XTILogerLevelCrash,
    XTILogerLevelOff,
};

@interface XTILoger : NSObject

@property (nonatomic, copy, readonly) NSString *logFolderPath;

+ (instancetype)sharedInstance;
- (void)log:(XTILogerLevel)level format:(NSString *)format, ...;

- (void)logDebugWithFormat:(NSString *)format, ...;
- (void)logInfoWithFormat:(NSString *)format, ...;
- (void)logWarningWithFormat:(NSString *)format, ...;
- (void)logErrorWithFormat:(NSString *)format, ...;
- (void)logCrashWithFormat:(NSString *)format, ...;

- (BOOL)removeLogerFileWith:(XTILogerLevel)level;
- (NSArray<NSString *> *)getLogerFilePathsWith:(XTILogerLevel)level;
- (NSString *)getXTILogerLevelNameWith:(XTILogerLevel)level;
- (XTILogerLevel)getXTILogerLevelWith:(NSString *)name;
- (NSString *)getFileLengthWith:(XTILogerLevel)level;
- (NSString *)getFileLengthWithName:(NSString *)name;
- (NSString *)getSaveLevel;
@end
