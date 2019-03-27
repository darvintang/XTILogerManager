//
//  XTILogerManager.m
//  XTILogerManager
//
//  Created by Input on 2018/6/17.
//  Copyright © 2018年 input. All rights reserved.
//

#import "XTILogerManager.h"
#import "XTILogerManagerViewController.h"

@implementation XTILogerManager
+ (instancetype)sharedInstance {
    static XTILogerManager *defaultManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultManager = [[XTILogerManager alloc] init];
    });
    return defaultManager;
}

- (void)showManagerViewController:(UIViewController *)VC extDict:(NSDictionary<NSString *, NSString *> *)extDict {
    XTILogerManagerViewController *managerViewController = [[XTILogerManagerViewController alloc] init];
    __weak typeof(self)weakSelf = self;
    __weak typeof(XTILogerManagerViewController) * weakManagerViewController = managerViewController;
    managerViewController.extDict = extDict;
    managerViewController.clickExt = ^(NSString *name) {
        if (weakSelf.clickExt) {
            weakSelf.clickExt(weakManagerViewController, name);
        }
    };

    [VC presentViewController:managerViewController animated:YES completion:nil];
}

#pragma mark -
- (void)setSaveLevel:(XTILogerLevel)saveLevel {
    NSString *flag = [[NSUserDefaults standardUserDefaults] stringForKey:@"XTILogerManager.saveLevel"];
    if (!flag) {
        _saveLevel = saveLevel;
        [[XTILoger sharedInstance] setValue:@(saveLevel) forKey:@"saveLevel"];
    }
}

- (void)setPrintLevel:(XTILogerLevel)printLevel {
    _printLevel = printLevel;
    [[XTILoger sharedInstance] setValue:@(printLevel) forKey:@"printLevel"];
}

@end
