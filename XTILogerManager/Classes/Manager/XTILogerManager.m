//
//  XTILogerManager.m
//  XTILogerManager
//
//  Created by Input on 2018/6/17.
//  Copyright © 2018年 input. All rights reserved.
//

#import "XTILogerManager.h"

void XTIUncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *content = [NSString stringWithFormat:@"\n========异常错误报告========\nName:%@\nReason:\n%@\nCallStackSymbols:\n%@", name, reason, [arr componentsJoinedByString:@"\n"]];
    XTILoger_Crash(@"%@", content);
}

@implementation XTILogerManager
+ (instancetype)shared {
    static XTILogerManager *defaultManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSSetUncaughtExceptionHandler(&XTIUncaughtExceptionHandler);
        defaultManager = [[XTILogerManager alloc] init];
    });
    return defaultManager;
}

- (void)showLogZipWithFormVC:(UIViewController *)VC complete:(BOOL (^)(NSString *path))complete {
    [self showLogZipWithLevel:(XTILogerLevelAll) formVC:(VC) complete:complete];
}

- (void)showLogZipWithLevel:(XTILogerLevel)level formVC:(UIViewController *)VC complete:(BOOL (^)(NSString *path))complete {
    __block NSMutableArray<NSString *> *filesPath = [[NSMutableArray<NSString *> alloc] init];

    [[[XTILoger shared] getLogerFilePathsWith:level] enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        [[[XTILoger shared] getLogerFilePathsWith:[[XTILoger shared] getXTILogerLevelWith:obj]] enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
            [filesPath addObject:[NSString stringWithFormat:@"%@/%@", [XTILoger shared].logFolderPath, obj]];
        }];
    }];
    NSString *path = [[XTILoger shared].logFolderPath stringByAppendingPathComponent:@"/XTILoger.zip"];
    //创建不带密码zip压缩包
    BOOL isSuccess = [SSZipArchive createZipFileAtPath:path withFilesAtPaths:filesPath];
    if (isSuccess) {
        if (complete) {
            BOOL flag = complete(path);
            if (flag) {
                NSURL *url = [NSURL fileURLWithPath:path];
                UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[url] applicationActivities:nil];
                NSArray *excludedActivities = @[UIActivityTypePostToTwitter, UIActivityTypePostToFacebook,
                                                UIActivityTypePostToWeibo,
                                                UIActivityTypeMessage, UIActivityTypeMail,
                                                UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
                                                UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,
                                                UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr,
                                                UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo];
                activityViewController.excludedActivityTypes = excludedActivities;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [VC presentViewController:activityViewController animated:YES completion:nil];
                });
            }
        }
    }
}

- (BOOL)removeLogerFiles {
    return [self removeLogerFileWithLevel:XTILogerLevelAll];
}

- (BOOL)removeLogerFileWithLevel:(XTILogerLevel)level {
    return [XTILoger.shared removeLogerFileWith:level];
}

#pragma mark -
- (void)setSaveLevel:(XTILogerLevel)saveLevel {
    _saveLevel = saveLevel;
    [[XTILoger shared] setValue:@(saveLevel) forKey:@"saveLevel"];
}

- (void)setPrintLevel:(XTILogerLevel)printLevel {
    _printLevel = printLevel;
    [[XTILoger shared] setValue:@(printLevel) forKey:@"printLevel"];
}

@end
