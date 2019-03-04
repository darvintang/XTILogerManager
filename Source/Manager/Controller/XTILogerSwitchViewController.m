
//
//  XTILogerSwitchViewController.m
//  XTILogerManager
//
//  Created by Input on 2018/6/17.
//  Copyright © 2018年 input. All rights reserved.
//

#import "XTILogerSwitchViewController.h"
#import "XTILogerSwitchTableViewCell.h"

@interface XTILogerSwitchViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISwitch *switchView;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableDictionary *selectDict;
@end

@implementation XTILogerSwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"XTILogerSwitchTableViewCell" bundle:nil] forCellReuseIdentifier:@"XTILogerSwitchTableViewCell"];
    [self.switchView addTarget:self action:@selector(clickSwitchView:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.selectDict = [[NSMutableDictionary alloc] init];
    if (self.isSingle) {
        [self.tempLabel setHidden:YES];
        [self.switchView setHidden:YES];
        self.selectDict[[[XTILoger sharedInstance] getSaveLevel]] = [[XTILoger sharedInstance] getSaveLevel];
    } else {
        [self.tempLabel setHidden:NO];
        [self.switchView setHidden:NO];
        [self.switchView setOn:NO];
    }
    [self.tableView reloadData];
}

- (IBAction)clickBtn:(UIButton *)sender {
    if (self.clickBtn && self.selectDict.allKeys.count > 0) {
        self.clickBtn(self.selectDict.allKeys);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickSwitchView:(UISwitch *)switchView {
    if (switchView.isOn) {
        [self.dataArray enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
            self.selectDict[obj] = obj;
        }];
    } else {
        [self.selectDict removeAllObjects];
    }
    [self.tableView reloadData];
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"debug", @"info", @"warning", @"error", @"crash"];
    }
    return _dataArray;
}

#pragma mark - UITableViewDragDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XTILogerSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XTILogerSwitchTableViewCell" forIndexPath:indexPath];
    NSString *title = self.dataArray[indexPath.row];
    cell.title = title;
    cell.detail = [[XTILoger sharedInstance] getFileLengthWithName:title];
    cell.isSwitch = self.selectDict[title] != nil;
    __weak typeof(self)weakSelf = self;
    cell.clickSwitch = ^{
        if (weakSelf.isSingle) {
            [self.selectDict removeAllObjects];
        }
        if (weakSelf.selectDict[title] == nil) {
            weakSelf.selectDict[title] = title;
        } else {
            weakSelf.selectDict[title] = nil;
        }
        [weakSelf.tableView reloadData];
    };
    return cell;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.view == touches.allObjects.firstObject.view) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
