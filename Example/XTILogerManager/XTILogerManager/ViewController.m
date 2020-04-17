//
//  ViewController.m
//  XTILogerManager
//
//  Created by Input on 2018/6/17.
//  Copyright © 2018年 input. All rights reserved.
//

#import "ViewController.h"
#import "XTILogerManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [XTILogerManager sharedInstance].printLevel = XTILogerLevelInfo;
//    [XTILogerManager sharedInstance].saveLevel = XTILogerLevelError;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (int i = 0; i < 100; i++) {
        XTILoger_Debug(@"%@__%@", @"日志测试", self);
        XTILoger_Info(@"%@__%@", @"日志测试", self);
        XTILoger_Warning(@"%@__%@", @"日志测试", self);
        XTILoger_Error(@"%@__%@", @"日志测试", self);
        XTILoger_Crash(@"%@__%@", @"日志测试", self);
    }
    [[XTILogerManager shared] showManagerViewController:self complete:^(NSString *path) {
        XTILoger_Info(@"%@", path);
    }];
}

@end
