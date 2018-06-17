//
//  XTILogerSwitchTableViewCell.h
//  XTILogerManager
//
//  Created by Input on 2018/6/17.
//  Copyright © 2018年 input. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTILogerSwitchTableViewCell : UITableViewCell
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *detail;
@property (nonatomic, assign) BOOL isSwitch;
@property (nonatomic, copy) void(^clickSwitch)(void);
@end
