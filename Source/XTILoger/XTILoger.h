//
//  XTILoger.h
//  XTILogerManager
// 如果非cocoapods管理三方库，请在PREPROCESSOR_DEFINITIONS添加Debugm模式下DEBUG=1
//  Created by Input on 2018/6/17.
//  Copyright © 2018年 input. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LogerFileMaxLength 1048576 //日志文件最大长度，1M

#define XTILogerManagerFormat(format) [NSString stringWithFormat:@"%@:%@ > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], [NSNumber numberWithInt:__LINE__], format]

#define XTILoger_Debug(format, ...)   [[XTILoger sharedInstance] logDebugWithFormat:XTILogerManagerFormat(format), ## __VA_ARGS__]
#define XTILoger_Info(format, ...)    [[XTILoger sharedInstance] logInfoWithFormat:XTILogerManagerFormat(format), ## __VA_ARGS__]
#define XTILoger_Warning(format, ...) [[XTILoger sharedInstance] logWarningWithFormat:XTILogerManagerFormat(format), ## __VA_ARGS__]
#define XTILoger_Error(format, ...)   [[XTILoger sharedInstance] logErrorWithFormat:XTILogerManagerFormat(format), ## __VA_ARGS__]
#define XTILoger_Crash(format, ...)   [[XTILoger sharedInstance] logCrashWithFormat:XTILogerManagerFormat(format), ## __VA_ARGS__]

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
typedef NS_ENUM (NSInteger, XTILogerLevel) {
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
//删除日志文件
- (BOOL)removeLogerFileWith:(XTILogerLevel)level;
/**
 获取日志文件，需要
 */
- (NSArray<NSString *> *)getLogerFilePathsWith:(XTILogerLevel)level;
/**
 获取该日志等级的名字
 */
- (NSString *)getXTILogerLevelNameWith:(XTILogerLevel)level;
/**
 获取日志等级
 */
- (XTILogerLevel)getXTILogerLevelWith:(NSString *)name;

- (NSString *)getFileLengthWith:(XTILogerLevel)level;
- (NSString *)getFileLengthWithName:(NSString *)name;

- (NSString *)getSaveLevel;
@end
