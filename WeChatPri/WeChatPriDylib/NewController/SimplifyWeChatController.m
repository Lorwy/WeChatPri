//
//  SimplifyWeChatController.m
//  WeChatPri
//
//  Created by Lorwy on 2017/8/7.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import "SimplifyWeChatController.h"
#import <objc/objc-runtime.h>
#import "WBMultiSelectGroupsViewController.h"
#import "WeChatPriConfigCenter.h"
#import "WeChatRedEnvelop.h"

@interface SimplifyWeChatController ()

@property (nonatomic, strong) MMTableViewInfo *tableViewInfo;

@end

@implementation SimplifyWeChatController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _tableViewInfo = [[objc_getClass("MMTableViewInfo") alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitle];
    [self reloadTableData];
    
    MMTableView *tableView = [self.tableViewInfo getTableView];
    [self.view addSubview:tableView];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self stopLoading];
}

- (void)initTitle {
    self.title = @"功能开关";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0]}];
}

- (void)reloadTableData {
    [self.tableViewInfo clearAllSection];
    
    [self addLocationSettingSection];
    [self addBasicSettingSection];
    
    MMTableView *tableView = [self.tableViewInfo getTableView];
    [tableView reloadData];
}

#pragma mark - BasicSetting

- (void)addBasicSettingSection {
    MMTableViewSectionInfo *sectionInfo = [objc_getClass("MMTableViewSectionInfo") sectionInfoHeader:@"发现页面开关" Footer:nil];
    
    [sectionInfo addCell:[self createFriendEnterCell]];
    [sectionInfo addCell:[self createShakeEnterCell]];
    [sectionInfo addCell:[self createScanEnterCell]];
    [sectionInfo addCell:[self createNearbydEnterCell]];
    [sectionInfo addCell:[self createDriftBoottleEnterCell]];
    [sectionInfo addCell:[self createShopEnterCell]];
    [sectionInfo addCell:[self createGameEnterCell]];
    [sectionInfo addCell:[self createAppletCell]];
    
    [self.tableViewInfo addSection:sectionInfo];
}


- (MMTableViewCellInfo *)createFriendEnterCell {
    return [objc_getClass("MMTableViewCellInfo") switchCellForSel:@selector(switchFriendEnter:) target:self title:@"朋友圈" on:[WeChatPriConfigCenter sharedInstance].friendEnter];
}

- (void)switchFriendEnter:(UISwitch *)envelopSwitch {
    [WeChatPriConfigCenter sharedInstance].friendEnter = envelopSwitch.on;
    [self reloadTableData];
}

- (MMTableViewCellInfo *)createShakeEnterCell {
    return [objc_getClass("MMTableViewCellInfo") switchCellForSel:@selector(switchShakeEnter:) target:self title:@"摇一摇" on:[WeChatPriConfigCenter sharedInstance].shakeEnter];
}

- (void)switchShakeEnter:(UISwitch *)envelopSwitch {
    [WeChatPriConfigCenter sharedInstance].shakeEnter = envelopSwitch.on;
    [self reloadTableData];
}

- (MMTableViewCellInfo *)createScanEnterCell {
    return [objc_getClass("MMTableViewCellInfo") switchCellForSel:@selector(scanScanEnter:) target:self title:@"扫一扫" on:[WeChatPriConfigCenter sharedInstance].scanEnter];
}

- (void)scanScanEnter:(UISwitch *)envelopSwitch {
    [WeChatPriConfigCenter sharedInstance].scanEnter = envelopSwitch.on;
    [self reloadTableData];
}

- (MMTableViewCellInfo *)createNearbydEnterCell {
    return [objc_getClass("MMTableViewCellInfo") switchCellForSel:@selector(switchNearbydEnter:) target:self title:@"附近的人" on:[WeChatPriConfigCenter sharedInstance].nearbydEnter];
}

- (void)switchNearbydEnter:(UISwitch *)envelopSwitch {
    [WeChatPriConfigCenter sharedInstance].nearbydEnter = envelopSwitch.on;
    [self reloadTableData];
}

- (MMTableViewCellInfo *)createDriftBoottleEnterCell {
    return [objc_getClass("MMTableViewCellInfo") switchCellForSel:@selector(switchDriftBoottleEnter:) target:self title:@"漂流瓶" on:[WeChatPriConfigCenter sharedInstance].driftBottleEnter];
}

- (void)switchDriftBoottleEnter:(UISwitch *)envelopSwitch {
    [WeChatPriConfigCenter sharedInstance].driftBottleEnter = envelopSwitch.on;
    [self reloadTableData];
}

- (MMTableViewCellInfo *)createShopEnterCell {
    return [objc_getClass("MMTableViewCellInfo") switchCellForSel:@selector(switchShopEnter:) target:self title:@"购物" on:[WeChatPriConfigCenter sharedInstance].shopEnter];
}

- (void)switchShopEnter:(UISwitch *)envelopSwitch {
    [WeChatPriConfigCenter sharedInstance].shopEnter = envelopSwitch.on;
    [self reloadTableData];
}

- (MMTableViewCellInfo *)createGameEnterCell {
    return [objc_getClass("MMTableViewCellInfo") switchCellForSel:@selector(switchGameEnter:) target:self title:@"游戏" on:[WeChatPriConfigCenter sharedInstance].gameEnter];
}

- (void)switchGameEnter:(UISwitch *)envelopSwitch {
    [WeChatPriConfigCenter sharedInstance].gameEnter = envelopSwitch.on;
    [self reloadTableData];
}

- (MMTableViewCellInfo *)createAppletCell {
    return [objc_getClass("MMTableViewCellInfo") switchCellForSel:@selector(switchAppletEnter:) target:self title:@"小程序" on:[WeChatPriConfigCenter sharedInstance].appletEnter];
}

- (void)switchAppletEnter:(UISwitch *)envelopSwitch {
    [WeChatPriConfigCenter sharedInstance].appletEnter = envelopSwitch.on;
    [self reloadTableData];
}


// MARK: 自定义经纬度的
- (void)addLocationSettingSection {
    MMTableViewSectionInfo *sectionInfo = [objc_getClass("MMTableViewSectionInfo") sectionInfoHeader:@"自定义位置(输入完成需要点键盘上的完成按钮)" Footer:nil];
    [sectionInfo addCell:[self createLocationSwichCell]];
    if ([WeChatPriConfigCenter sharedInstance].customLocation) {
        [sectionInfo addCell:[self createLocationLatSwichCell]];
        [sectionInfo addCell:[self createLocationLngSwichCell]];
    }
    [self.tableViewInfo addSection:sectionInfo];
}

- (MMTableViewCellInfo *)createLocationSwichCell {
    return [objc_getClass("MMTableViewCellInfo") switchCellForSel:@selector(switchLocation:) target:self title:@"自定义位置" on:[WeChatPriConfigCenter sharedInstance].customLocation];
}

- (void)switchLocation:(UISwitch *)envelopSwitch {
    [WeChatPriConfigCenter sharedInstance].customLocation = envelopSwitch.on;
    [self reloadTableData];
}

- (MMTableViewCellInfo *)createLocationLatSwichCell {
    MMTableViewCellInfo *latCellInfo = [objc_getClass("MMTableViewCellInfo") editorCellForSel:@selector(handleCustomLat:) target:[WeChatPriConfigCenter sharedInstance] tip:@"经度" focus:NO text:[WeChatPriConfigCenter sharedInstance].customLat];
    return latCellInfo;
}

- (MMTableViewCellInfo *)createLocationLngSwichCell {
    MMTableViewCellInfo *lngCellInfo = [objc_getClass("MMTableViewCellInfo") editorCellForSel:@selector(handleCustomLng:) target:[WeChatPriConfigCenter sharedInstance] tip:@"纬度" focus:NO text:[WeChatPriConfigCenter sharedInstance].customLng];
    return lngCellInfo;
}

@end
