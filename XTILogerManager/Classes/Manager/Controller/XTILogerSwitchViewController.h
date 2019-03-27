//
//  XTILogerSwitchViewController.h
//  XTILogerManager
//
//  Created by Input on 2018/6/17.
//  Copyright © 2018年 input. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XTILoger.h"

#define PodNibWithClass(class) [UINib nibWithNibName:NSStringFromClass(class) bundle:[NSBundle bundleForClass:class]]

@interface XTILogerSwitchViewController : UIViewController
@property (nonatomic, assign) BOOL isSingle;
@property (nonatomic, strong) void (^ clickBtn)(NSArray *list);
@end
