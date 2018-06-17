//
//  XTILogerManagerViewController.m
//  XTILogerManager
//
//  Created by Input on 2018/6/17.
//  Copyright © 2018年 input. All rights reserved.
//

#import "XTILogerManagerViewController.h"
#import "XTILogerSwitchViewController.h"
#import "XTILogerTableViewCell.h"
#import "XTILogerManager.h"

#ifndef isIPhoneX
#define isIPhoneX (kScreenWidth == 812.0f || kScreenHeight == 812.0f)
#endif

#ifndef kNavAndStatusBarHeight
#define kNavAndStatusBarHeight (isIPhoneX ? 88.0f : 64.0f)
#endif

#ifndef kScreenWidth
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#endif

#ifndef kScreenHeight
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#endif

@interface XTILogerManagerViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) XTILogerSwitchViewController *switchViewController;
@property (nonatomic, copy) NSMutableDictionary<NSString *, NSString *> *infoDict;
@end

@implementation XTILogerManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"调试模式设置";
    // Do any additional setup after loading the view.
    if (!self.navigationController) {
        [self.view addSubview:[self headVew]];
    }
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor grayColor];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.infoDict[@"1清除日志"] = [[XTILoger sharedInstance] getFileLengthWith:XTILogerLevelAll];
    [self.tableView reloadData];
}
- (UIView *)headVew {
    UIView *headVew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavAndStatusBarHeight - 0.5)];
    headVew.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0 - 60, kNavAndStatusBarHeight - 44, 120, 44)];
    titleLabel.text = @"调试模式设置";
    [headVew addSubview:titleLabel];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(kScreenWidth - 48, kNavAndStatusBarHeight - 44, 44, 44);
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [headVew addSubview:closeBtn];
    return headVew;
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UITableViewDragDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoDict.allKeys.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XTILogerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XTILogerTableViewCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellStyleValue1;
    NSString *title = self.infoDict.allKeys[indexPath.row];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = self.infoDict[title];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XTILogerTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *title = cell.textLabel.text;

    if ([title isEqualToString:@"1清除日志"]) {
        [[XTILoger sharedInstance] removeLogerFileWith:XTILogerLevelAll];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.infoDict[@"1清除日志"] = [[XTILoger sharedInstance] getFileLengthWith:XTILogerLevelAll];
            [self.tableView reloadData];
        });
    } else if ([title isEqualToString:@"2日志等级"]) {
        self.switchViewController.isSingle = YES;
        [self presentViewController:self.switchViewController animated:YES completion:nil];
    } else if ([title isEqualToString:@"3分享日志"]) {
        self.switchViewController.isSingle = NO;
        [self presentViewController:self.switchViewController animated:YES completion:nil];
    } else {
        if (self.clickExt) {
            self.clickExt(title);
        }
    }
}
- (void)showActivityViewControllerWithPath:(NSString *)path {
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
        [self presentViewController:activityViewController animated:YES completion:nil];
    });
}
- (XTILogerSwitchViewController *)switchViewController {
    if (!_switchViewController) {
        _switchViewController = [[XTILogerSwitchViewController alloc] init];
        _switchViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        __weak typeof(self) weakSelf = self;
        _switchViewController.clickBtn = ^(NSArray *list) {
            if (weakSelf.switchViewController.isSingle) {
                XTILogerLevel level = [[XTILoger sharedInstance] getXTILogerLevelWith:list.firstObject];
                [[XTILoger sharedInstance] setValue:@(level) forKey:@"saveLevel"];
                [[NSUserDefaults standardUserDefaults] setValue:list.firstObject forKey:@"XTILogerManager.saveLevel"];
                weakSelf.infoDict[@"2日志等级"] = [[XTILoger sharedInstance] getSaveLevel];
            } else {
                __block NSMutableArray<NSString *> *filesPath = [[NSMutableArray<NSString *> alloc] init];
                [list enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
                    [[[XTILoger sharedInstance] getLogerFilePathsWith:[[XTILoger sharedInstance] getXTILogerLevelWith:obj]] enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
                        [filesPath addObject:[NSString stringWithFormat:@"%@/%@", [XTILoger sharedInstance].logFolderPath, obj]];
                    }];
                }];
                NSString *path = [[XTILoger sharedInstance].logFolderPath stringByAppendingPathComponent:@"/log.zip"];
                //创建不带密码zip压缩包
                BOOL isSuccess = [SSZipArchive createZipFileAtPath:path withFilesAtPaths:filesPath];
                if (isSuccess) {
                    [weakSelf showActivityViewControllerWithPath:path];
                }
            }
            [weakSelf.tableView reloadData];
        };
    }
    return _switchViewController;
}
- (NSMutableDictionary<NSString *, NSString *> *)infoDict {
    if (!_infoDict) {
        _infoDict = [[NSMutableDictionary alloc] init];
        _infoDict[@"1清除日志"] = [[XTILoger sharedInstance] getFileLengthWith:XTILogerLevelAll];
        _infoDict[@"2日志等级"] = [[XTILoger sharedInstance] getSaveLevel];
        _infoDict[@"3分享日志"] = @"提取日志文件";
    }
    return _infoDict;
}
- (void)setExtDict:(NSDictionary<NSString *, NSString *> *)extDict {
    _extDict = extDict;
    [self.infoDict addEntriesFromDictionary:extDict];
}
- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat tableViewH = kScreenHeight - kNavAndStatusBarHeight;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavAndStatusBarHeight, kScreenWidth, tableViewH) style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        if (@available(ios 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_tableView registerNib:[UINib nibWithNibName:@"XTILogerTableViewCell" bundle:nil] forCellReuseIdentifier:@"XTILogerTableViewCell"];
    }
    return _tableView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}
@end
