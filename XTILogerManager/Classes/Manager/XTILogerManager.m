//
//  XTILogerManager.m
//  XTILogerManager
//
//  Created by Input on 2018/6/17.
//  Copyright © 2018年 input. All rights reserved.
//

#import "XTILogerManager.h"

@implementation XTILogerManager
+ (instancetype)shared {
    static XTILogerManager *defaultManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultManager = [[XTILogerManager alloc] init];
    });
    return defaultManager;
}

- (void)showManagerViewController:(UIViewController *)VC complete:(void (^)(NSString *path))complete {
    __block NSMutableArray<NSString *> *filesPath = [[NSMutableArray<NSString *> alloc] init];
    [@[@"debug", @"info", @"warning", @"error", @"crash"] enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        [[[XTILoger shared] getLogerFilePathsWith:[[XTILoger shared] getXTILogerLevelWith:obj]] enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
            [filesPath addObject:[NSString stringWithFormat:@"%@/%@", [XTILoger shared].logFolderPath, obj]];
        }];
    }];
    NSString *path = [[XTILoger shared].logFolderPath stringByAppendingPathComponent:@"/XTILoger.zip"];
    //创建不带密码zip压缩包
    BOOL isSuccess = [SSZipArchive createZipFileAtPath:path withFilesAtPaths:filesPath];
    if (isSuccess) {
        if (complete) {
            complete(path);
        }
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
