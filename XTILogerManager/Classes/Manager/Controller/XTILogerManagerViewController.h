//
//  XTILogerManagerViewController.h
//  XTILogerManager
//
//  Created by Input on 2018/6/17.
//  Copyright © 2018年 input. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTILogerManagerViewController : UIViewController
@property (nonatomic, copy) NSDictionary<NSString *, NSString *> *extDict;
@property (nonatomic, copy) void (^ clickExt)(NSString *name);

@end
