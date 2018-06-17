//
//  XTILogerSwitchTableViewCell.m
//  XTILogerManager
//
//  Created by Input on 2018/6/17.
//  Copyright © 2018年 input. All rights reserved.
//

#import "XTILogerSwitchTableViewCell.h"
@interface XTILogerSwitchTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switchView;
@end
@implementation XTILogerSwitchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)clickSwitchView:(id)sender {
    if (self.clickSwitch) {
        self.clickSwitch();
    }
}
- (void)setIsSwitch:(BOOL)isSwitch {
    _isSwitch = isSwitch;
    [self.switchView setOn:isSwitch];
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLable.text = title;
}

- (void)setDetail:(NSString *)detail {
    _detail = detail;
    self.detailLabel.text = detail;
}
@end
