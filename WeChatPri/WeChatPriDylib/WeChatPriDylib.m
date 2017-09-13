//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  WeChatPriDylib.m
//  WeChatPriDylib
//
//  Created by Lorwy on 2017/8/4.
//  Copyright (c) 2017年 Lorwy. All rights reserved.
//

#import "WeChatPriDylib.h"
#import "CaptainHook.h"
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>
#import <CydiaSubstrate/CydiaSubstrate.h>

#import "WeChatPriConfigCenter.h"
#import "WeChatPri.h"
#import "WeChatPriUtil.h"

#import "WeChatRedEnvelop.h"
#import "WeChatRedEnvelopParam.h"
#import "WBSettingViewController.h"
#import "WBReceiveRedEnvelopOperation.h"
#import "WBRedEnvelopTaskManager.h"
#import "WBRedEnvelopConfig.h"
#import "WBRedEnvelopParamQueue.h"

#import "SimplifyWeChatController.h"

#import "WeChatNewsMsgManager.h"

#import "TKRobotConfig.h"
#import "TKSettingViewController.h"

#define WeChatPriConfigCenterKey @"WeChatPriConfigCenterKey"

// 发现页面
CHDeclareClass(FindFriendEntryViewController)

// 设置页面
CHDeclareClass(NewSettingViewController)

// 微信步数
CHDeclareClass(WCDeviceStepObject)

//
CHDeclareClass(MicroMessengerAppDelegate)
CHDeclareClass(CMessageMgr)

// 去掉小红点
CHDeclareClass(MMTabBarController)
CHDeclareClass(UIView)

//CHDeclareClass(NewMainFrameViewController)


// 夜间模式
CHDeclareClass(UIViewController)
CHDeclareClass(UILabel)

// 防止消息撤回
CHDeclareClass(ChatRoomInfoViewController)

// 微信红包





static __attribute__((constructor)) void entry()
{
    NSLog(@"\n               🎉!!！congratulations!!！🎉\n👍----------------insert dylib success----------------👍");
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        CYListenServer(6666);
    }];
}

CHOptimizedMethod2(self, void, MicroMessengerAppDelegate, application, UIApplication *, application, didFinishLaunchingWithOptions, NSDictionary *, options)
{
    CHSuper2(MicroMessengerAppDelegate, application, application, didFinishLaunchingWithOptions, options);
    
    NSLog(@"## Load WeChatPriConfigCenter ##");
    NSData *centerData = [[NSUserDefaults standardUserDefaults] objectForKey:WeChatPriConfigCenterKey];
    if (centerData) {
        WeChatPriConfigCenter *center = [NSKeyedUnarchiver unarchiveObjectWithData:centerData];
        [WeChatPriConfigCenter loadInstance:center];
    }
}

CHDeclareMethod1(void, MicroMessengerAppDelegate, applicationWillResignActive, UIApplication *, application)
{
    NSData *centerData = [NSKeyedArchiver archivedDataWithRootObject:[WeChatPriConfigCenter sharedInstance]];
    [[NSUserDefaults standardUserDefaults] setObject:centerData forKey:WeChatPriConfigCenterKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


//MARK: 清理发现页面
CHOptimizedMethod2(self, CGFloat, FindFriendEntryViewController, tableView, UITableView *, tableView, heightForRowAtIndexPath, NSIndexPath *, indexPath)
{
    if ((indexPath.section == 0 && indexPath.row == 0) &&
        ![WeChatPriConfigCenter sharedInstance].friendEnter) {
        return 0;
    }else if ((indexPath.section == 1 && indexPath.row == 0) &&
              ![WeChatPriConfigCenter sharedInstance].scanEnter) {
        return 0;
    }else if ((indexPath.section == 1 && indexPath.row == 1) &&
              ![WeChatPriConfigCenter sharedInstance].shakeEnter) {
        return 0;
    }else if ((indexPath.section == 2 && indexPath.row == 0) &&
             ![WeChatPriConfigCenter sharedInstance].nearbydEnter) {
        return 0;
    }else if ((indexPath.section == 2 && indexPath.row == 1) &&
              ![WeChatPriConfigCenter sharedInstance].driftBottleEnter) {
        return 0;
    }else if ((indexPath.section == 3 && indexPath.row == 0) &&
              ![WeChatPriConfigCenter sharedInstance].shopEnter) {
        return 0;
    }else if ((indexPath.section == 3 && indexPath.row == 1) &&
              ![WeChatPriConfigCenter sharedInstance].gameEnter) {
        return 0;
    }else if ((indexPath.section == 4 && indexPath.row == 0) &&
              ![WeChatPriConfigCenter sharedInstance].appletEnter) {
        return 0;
    }
    return CHSuper2(FindFriendEntryViewController, tableView, tableView, heightForRowAtIndexPath, indexPath);
}

CHOptimizedMethod2(self, UITableViewCell *, FindFriendEntryViewController, tableView, UITableView *, tableView, cellForRowAtIndexPath, NSIndexPath *, indexPath)
{
    UITableViewCell *cell = CHSuper2(FindFriendEntryViewController, tableView, tableView, cellForRowAtIndexPath, indexPath);
    if ((indexPath.section == 0 && indexPath.row == 0) &&
        ![WeChatPriConfigCenter sharedInstance].friendEnter) {
        [self cleanCell:cell];
    }else if ((indexPath.section == 1 && indexPath.row == 0) &&
              ![WeChatPriConfigCenter sharedInstance].scanEnter) {
        [self cleanCell:cell];
    }else if ((indexPath.section == 1 && indexPath.row == 1) &&
              ![WeChatPriConfigCenter sharedInstance].shakeEnter) {
        [self cleanCell:cell];
    }else if ((indexPath.section == 2 && indexPath.row == 0) &&
              ![WeChatPriConfigCenter sharedInstance].nearbydEnter) {
        [self cleanCell:cell];
    }else if ((indexPath.section == 2 && indexPath.row == 1) &&
              ![WeChatPriConfigCenter sharedInstance].driftBottleEnter) {
        [self cleanCell:cell];
    }else if ((indexPath.section == 3 && indexPath.row == 0) &&
              ![WeChatPriConfigCenter sharedInstance].shopEnter) {
        [self cleanCell:cell];
    }else if ((indexPath.section == 3 && indexPath.row == 1) &&
              ![WeChatPriConfigCenter sharedInstance].gameEnter) {
        [self cleanCell:cell];
    }else if ((indexPath.section == 4 && indexPath.row == 0) &&
              ![WeChatPriConfigCenter sharedInstance].appletEnter) {
        [self cleanCell:cell];
    }
    return cell;
}

CHDeclareMethod1(void, FindFriendEntryViewController, cleanCell, UITableViewCell*, cell) {
    cell.hidden = YES;
    for (UIView *subview in cell.subviews) {
        [subview removeFromSuperview];
    }
    cell.clipsToBounds = YES;
}

CHOptimizedMethod1(self, void, FindFriendEntryViewController, viewDidAppear, BOOL, animated)
{
    CHSuper1(FindFriendEntryViewController, viewDidAppear, animated);
    [self performSelector:@selector(reloadData)];
}

//MARK: 修改设置页面
CHDeclareMethod0(void, NewSettingViewController, reloadTableData)
{
    CHSuper0(NewSettingViewController, reloadTableData);
    MMTableViewInfo *tableInfo = [self valueForKeyPath:@"m_tableViewInfo"];
    MMTableViewSectionInfo *sectionInfo = [objc_getClass("MMTableViewSectionInfo") sectionInfoDefaut];
    // 加一个开启夜间模式的cell
    MMTableViewCellInfo *nightCellInfo = [objc_getClass("MMTableViewCellInfo") switchCellForSel:@selector(handleNightMode:) target:[WeChatPriConfigCenter sharedInstance] title:@"夜间模式" on:[WeChatPriConfigCenter sharedInstance].isNightMode];
    [sectionInfo addCell:nightCellInfo];
    // 加一个开启步数排行榜页面自动点赞开关的cell
    MMTableViewCellInfo *autoLikeCellInfo = [objc_getClass("MMTableViewCellInfo") switchCellForSel:@selector(handleStepAutoLike:) target:[WeChatPriConfigCenter sharedInstance] title:@"步数排行榜浏览自动点赞" on:[WeChatPriConfigCenter sharedInstance].isStepAutoLike];
    [sectionInfo addCell:autoLikeCellInfo];
    // 加一个开启webpage消息提醒的开关
    MMTableViewCellInfo *showMsgInWebPageCellInfo = [objc_getClass("MMTableViewCellInfo") switchCellForSel:@selector(handleShowMsgInWebPage:) target:[WeChatPriConfigCenter sharedInstance] title:@"聊天网页无缝切换" on:[WeChatPriConfigCenter sharedInstance].isShowMsgInWebPage];
    [sectionInfo addCell:showMsgInWebPageCellInfo];
    // 加一个输入步数的cell
    MMTableViewCellInfo *stepcountCellInfo = [objc_getClass("MMTableViewCellInfo") editorCellForSel:@selector(handleStepCount:) target:[WeChatPriConfigCenter sharedInstance] tip:@"请输入步数" focus:NO text:[NSString stringWithFormat:@"%ld", (long)[WeChatPriConfigCenter sharedInstance].stepCount]];
    [sectionInfo addCell:stepcountCellInfo];
    
    MMTableViewCellInfo *settingCell = [objc_getClass("MMTableViewCellInfo") normalCellForSel:@selector(setting) target:self title:@"红包小助手" accessoryType:1];
    [sectionInfo addCell:settingCell];
    
    MMTableViewCellInfo *simplifySettingCell = [objc_getClass("MMTableViewCellInfo") normalCellForSel:@selector(simplifySetting) target:self title:@"功能开关" accessoryType:1];
    [sectionInfo addCell:simplifySettingCell];
    
    MMTableViewCellInfo *groupSettingCell = [objc_getClass("MMTableViewCellInfo") normalCellForSel:@selector(groupSetting) target:self title:@"群助手" accessoryType:1];
    [sectionInfo addCell:groupSettingCell];
    
    [tableInfo insertSection:sectionInfo At:0];
    
    
    MMTableView *tableView = [tableInfo getTableView];
    [tableView reloadData];
}

CHDeclareMethod0(void, NewSettingViewController, setting) {
    WBSettingViewController *settingViewController = [WBSettingViewController new];
    [self.navigationController PushViewController:settingViewController animated:YES];
}

CHDeclareMethod0(void, NewSettingViewController, simplifySetting) {
    SimplifyWeChatController *settingViewController = [SimplifyWeChatController new];
    [self.navigationController PushViewController:settingViewController animated:YES];
}

CHDeclareMethod0(void, NewSettingViewController, groupSetting) {
    TKSettingViewController *settingViewController = [TKSettingViewController new];
    [self.navigationController PushViewController:settingViewController animated:YES];
}

//MARK:                       
CHOptimizedMethod0(self, unsigned int, WCDeviceStepObject, m7StepCount)
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    components = [cal components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[WeChatPriConfigCenter sharedInstance].lastChangeStepCountDate];
    NSDate *otherDate = [cal dateFromComponents:components];
    BOOL modifyToday = NO;
    if([today isEqualToDate:otherDate]) {
        modifyToday = YES;
    }
    if ([WeChatPriConfigCenter sharedInstance].stepCount == 0 || !modifyToday) {
        [WeChatPriConfigCenter sharedInstance].stepCount = CHSuper0(WCDeviceStepObject, m7StepCount);
    }
    return [WeChatPriConfigCenter sharedInstance].stepCount;
}

// 自动点赞
CHDeclareClass(BraceletRankViewController)

CHOptimizedMethod2(self, MMTableViewCell *, BraceletRankViewController, tableView, id, arg1, cellForRowAtIndexPath, NSIndexPath *, indexpath) {
    MMTableViewCell *cell = CHSuper2(BraceletRankViewController, tableView, arg1, cellForRowAtIndexPath, indexpath);
    if([WeChatPriConfigCenter sharedInstance].isStepAutoLike) {
        BraceletRankLikeButton *btn = (BraceletRankLikeButton *)[WeChatPriUtil findSubView:[[objc_getClass("BraceletRankLikeButton") class] class] fromView:cell];
        if (btn) {
            CContactMgr *contactManager = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("CContactMgr") class]];
            CContact *selfContact = [contactManager getSelfContact];
            if (![btn.m_rankInfo.username isEqualToString:selfContact.m_nsUsrName]) {
                btn.m_rankInfo.localLike = true;
                btn.m_rankInfo.hasLike = true;
                [self performSelectorInBackground:@selector(onClickLike:) withObject:btn];
            }
        }
    }
    return cell;
}

//MARK: 取掉小红点
CHOptimizedMethod2(self, void, MMTabBarController, setTabBarBadgeImage, id, arg1, forIndex, unsigned int, arg2)
{
    if (arg2 != 2 && arg2 != 3) {
        CHSuper2(MMTabBarController, setTabBarBadgeImage, arg1, forIndex, arg2);
    }
}

CHOptimizedMethod2(self, void, MMTabBarController, setTabBarBadgeString, id, arg1, forIndex, unsigned int, arg2)
{
    if (arg2 != 2 && arg2 != 3) {
        CHSuper2(MMTabBarController, setTabBarBadgeString, arg1, forIndex, arg2);
    }
}

CHOptimizedMethod2(self, void, MMTabBarController, setTabBarBadgeValue, long long, arg1, forIndex, unsigned int, arg2)
{
    if (arg2 != 2 && arg2 != 3) {
        CHSuper2(MMTabBarController, setTabBarBadgeValue, arg1, forIndex, arg2);
    }
}

// 去掉所有小红点
CHOptimizedMethod1(self, void, UIView, didAddSubview, UIView *, subview)
{
    if ([subview isKindOfClass:NSClassFromString(@"MMBadgeView")]) {
        subview.hidden = YES;
    }
}

//MARK: 夜间模式


CHDeclareMethod1(void, UIView, willMoveToSuperview, UIView *, newSuperview)
{
    CHSuper1(UIView,willMoveToSuperview , newSuperview);
    if ([WeChatPriConfigCenter sharedInstance].isNightMode) {
        [WeChatPriUtil updateColorOfView:self];
    }
}

CHDeclareMethod1(void, UIViewController, viewWillAppear, BOOL, animated)
{
    CHSuper1(UIViewController, viewWillAppear, animated);
    if ([WeChatPriConfigCenter sharedInstance].isNightMode) {
        [WeChatPriUtil updateColorOfView:[self valueForKeyPath:@"view"]];
        [[self valueForKeyPath:@"view"] setBackgroundColor:nightBackgroundColor];
        [self setValue:nightTabBarColor forKeyPath:@"tabBarController.tabBar.barTintColor"];
        [self setValue:nightTabBarColor forKeyPath:@"tabBarController.tabBar.tintColor"];
    }
}



CHDeclareMethod1(void, UIView, setBackgroundColor, UIColor *, color)
{
    CHSuper1(UIView, setBackgroundColor, color);
    if ([WeChatPriConfigCenter sharedInstance].isNightMode) {
        if ([self isKindOfClass:UILabel.class]) {
            CHSuper1(UIView, setBackgroundColor, [UIColor clearColor]);
        }
        else if ([self isKindOfClass:UIButton.class]) {
            UIButton *button = (UIButton *)self;
            button.tintColor = nightTextColor;
        }
        else if ([self isKindOfClass:UITableViewCell.class]) {
            CHSuper1(UIView, setBackgroundColor, nightBackgroundColor);
        }
        else if ([self isKindOfClass:UITableView.class]) {
            ((UITableView *)self).separatorColor = nightSeparatorColor;
        }
        else if (![WeChatPriUtil compareColor:color color2:nightBackgroundColor]
                 && ![WeChatPriUtil compareColor:color color2:nightSeparatorColor]
                 && ![WeChatPriUtil compareColor:color color2:nightTabBarColor]) {
            CHSuper1(UIView, setBackgroundColor, [UIColor clearColor]);
        }
    }
}

CHDeclareMethod1(void, UILabel, setTextColor, UIColor *, color)
{
    if ([WeChatPriConfigCenter sharedInstance].isNightMode) {
        CHSuper1(UILabel, setTextColor, nightTextColor);
        self.tintColor = nightTextColor;
        self.backgroundColor = [UIColor clearColor];
    }
    else {
        CHSuper1(UILabel, setTextColor, color);
    }
}

CHDeclareMethod1(void, UILabel, setText, NSString *, text)
{
    CHSuper1(UILabel, setText, text);
    if ([WeChatPriConfigCenter sharedInstance].isNightMode) {
        self.textColor = nightTextColor;
        self.tintColor = nightTextColor;
        self.backgroundColor = [UIColor clearColor];
    }
}

//MARK: At all
CHOptimizedMethod2(self, void, CMessageMgr, AddMsg, id, arg1, MsgWrap, CMessageWrap *, wrap){
    NSUInteger type = wrap.m_uiMessageType;
    NSString *mFromUser = wrap.m_nsFromUsr;
    NSString *mToUsr = wrap.m_nsToUsr;
    NSString *mContent = wrap.m_nsContent;
    NSString *mSource = wrap.m_nsMsgSource;
    CContactMgr *contactManager = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("CContactMgr") class]];
    CContact *selfContact = [contactManager getSelfContact];
    if (type == 1){
        if ([mFromUser isEqualToString:selfContact.m_nsUsrName]) {
            if ([mToUsr hasSuffix:@"@chatroom"]) {
                if( mSource == nil){
                    NSString *aaa = [selfContact.m_nsUsrName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; NSLog(@"length=%lu,%@",(unsigned long)aaa.length,aaa);
                    NSArray *result = (NSArray *)[objc_getClass("CContact") getChatRoomMemberWithoutMyself:mToUsr];
                    if ([mContent hasPrefix:@"#所有人"]){
                        // 前缀要求
                        NSString *subStr = [mContent substringFromIndex:4];
                        NSMutableString *string = [NSMutableString string];
                        [result enumerateObjectsUsingBlock:^(CContact *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            [string appendFormat:@",%@",obj.m_nsUsrName];
                        }];
                        NSString *sourceString = [string substringFromIndex:1];
                        wrap.m_uiStatus = 3;
                        wrap.m_nsContent = subStr;
                        wrap.m_nsMsgSource = [NSString stringWithFormat:@"<msgsource><atuserlist>%@</atuserlist></msgsource>",sourceString];
                    }
                }
            }
        }
    }
    CHSuper(2, CMessageMgr,AddMsg,arg1,MsgWrap,wrap);
}

//MARK: 屏蔽消息

CHDeclareClass(BaseMsgContentViewController)
CHDeclareMethod1(void, BaseMsgContentViewController, viewDidAppear, BOOL, animated)
{
    CHSuper1(BaseMsgContentViewController, viewDidAppear, animated);
    id contact = [self GetContact];
    [WeChatPriConfigCenter sharedInstance].currentUserName = [contact valueForKey:@"m_nsUsrName"];
}

// MARK: 网页和聊天页面的快速切换
// 在聊天界面加上快速返回网页的按钮
CHDeclareMethod1(void, BaseMsgContentViewController, viewWillAppear, BOOL, animated)
{
    CHSuper1(BaseMsgContentViewController, viewWillAppear, animated);
    
    UIButton *btn = [self.view viewWithTag:8899];
    if ([WeChatPriConfigCenter sharedInstance].isShowMsgInWebPage && VALID_ARRAY([WeChatNewsMsgManager sharedInstance].webViewViewControllers)) {
        if (!btn) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 80, 74, 80, 40)];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [button setTitle:@"网页" forState:UIControlStateNormal];
            button.tag = 8899;
            [button addTarget:self action:@selector(backToWebViewController) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
        [self.view bringSubviewToFront:btn];
    } else {
        if (btn) {
            [btn removeFromSuperview];
            btn = nil;
        }
    }
}

CHDeclareMethod0(void, BaseMsgContentViewController, backToWebViewController) {
    // 从聊天界面到网页
    NSArray *webViewViewControllers = [WeChatNewsMsgManager sharedInstance].webViewViewControllers;
    if (VALID_ARRAY(webViewViewControllers)) {
        [[objc_getClass("CAppViewControllerManager") getCurrentNavigationController] setViewControllers:webViewViewControllers animated:YES];
    }
}


CHDeclareMethod0(void, ChatRoomInfoViewController, reloadTableData)
{
    CHSuper0(ChatRoomInfoViewController, reloadTableData);
    NSString *userName = [WeChatPriConfigCenter sharedInstance].currentUserName;
    MMTableViewInfo *tableInfo = [self valueForKeyPath:@"m_tableViewInfo"];
    MMTableViewSectionInfo *sectionInfo = [tableInfo getSectionAt:2];
    MMTableViewCellInfo *ignoreCellInfo = [objc_getClass("MMTableViewCellInfo") switchCellForSel:@selector(handleIgnoreChatRoom:) target:[WeChatPriConfigCenter sharedInstance] title:@"屏蔽群消息" on:[WeChatPriConfigCenter sharedInstance].chatIgnoreInfo[userName].boolValue];
    [sectionInfo addCell:ignoreCellInfo];
    MMTableView *tableView = [tableInfo getTableView];
    [tableView reloadData];
}

CHDeclareClass(MMWebViewController)
CHDeclareMethod0(void, MMWebViewController, viewDidLoad)
{
    CHSuper0(MMWebViewController, viewDidLoad);
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveNewMessage)
                                                 name:KweChatNewMessageNotification
                                               object:nil];
}

CHDeclareMethod0(void, MMWebViewController, didReceiveNewMessage) {
    
    if (![WeChatPriConfigCenter sharedInstance].isShowMsgInWebPage) {
        [WeChatNewsMsgManager sharedInstance].webViewViewControllers = nil;
        return;
    }
    
    NSString *username = [WeChatNewsMsgManager sharedInstance].username;
    NSString *content = [WeChatNewsMsgManager sharedInstance].content;
    CContactMgr *contactManager = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("CContactMgr") class]];
    CContact *selfContact = [contactManager getSelfContact];
    
    CContactMgr *contactMgr = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("CContactMgr") class]];
    CContact *contact = [contactMgr getContactByName:username];
    if ([selfContact.m_nsUsrName isEqualToString:[WeChatNewsMsgManager sharedInstance].fromUserName]) {
        // 自己从其他端登录的不管
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *text = [NSString stringWithFormat:@"  %@: %@  ", contact.m_nsNickName, content];
        [WeChatNewsMsgManager showHUDInView:self.view text:text target:self action:@selector(backToMsgContentViewController)];
    });
}

CHDeclareMethod0(void, MMWebViewController, backToMsgContentViewController) {
    // 返回聊天界面ViewController前记录当前navigationController的VC堆栈，以便快速返回
    NSArray *webViewViewControllers = [objc_getClass("CAppViewControllerManager") getCurrentNavigationController].viewControllers;
    [WeChatNewsMsgManager sharedInstance].webViewViewControllers = webViewViewControllers;
    
    // 返回rootViewController
    UINavigationController *navVC = [objc_getClass("CAppViewControllerManager") getCurrentNavigationController];
    [navVC popToRootViewControllerAnimated:NO];
    
    // 进入聊天界面ViewController
    NSString *username = [WeChatNewsMsgManager sharedInstance].username;
    CContactMgr *contactMgr = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("CContactMgr") class]];
    CContact *contact = [contactMgr getContactByName:username];
    MMMsgLogicManager *logicMgr = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("MMMsgLogicManager") class]];
    [logicMgr PushOtherBaseMsgControllerByContact:contact navigationController:navVC animated:YES];
}

// MARK : 屏蔽消息
CHDeclareClass(AddContactToChatRoomViewController)

CHDeclareMethod0(void, AddContactToChatRoomViewController, reloadTableData)
{
    CHSuper0(AddContactToChatRoomViewController, reloadTableData);
    NSString *userName = [WeChatPriConfigCenter sharedInstance].currentUserName;
    MMTableViewInfo *tableInfo = [self valueForKeyPath:@"m_tableViewInfo"];
    MMTableViewSectionInfo *sectionInfo = [tableInfo getSectionAt:1];
    MMTableViewCellInfo *ignoreCellInfo = [objc_getClass("MMTableViewCellInfo") switchCellForSel:@selector(handleIgnoreChatRoom:) target:[WeChatPriConfigCenter sharedInstance] title:@"屏蔽此人消息" on:[WeChatPriConfigCenter sharedInstance].chatIgnoreInfo[userName].boolValue];
    [sectionInfo addCell:ignoreCellInfo];
    MMTableView *tableView = [tableInfo getTableView];
    [tableView reloadData];
}

CHDeclareMethod6(id, CMessageMgr, GetMsgByCreateTime, id, arg1, FromID, unsigned int, arg2, FromCreateTime, unsigned int, arg3, Limit, unsigned int, arg4, LeftCount, unsigned int*, arg5, FromSequence, unsigned int, arg6)
{
    id result = CHSuper6(CMessageMgr, GetMsgByCreateTime, arg1, FromID, arg2, FromCreateTime, arg3, Limit, arg4, LeftCount, arg5, FromSequence, arg6);
    if ([WeChatPriConfigCenter sharedInstance].chatIgnoreInfo[arg1].boolValue) {
        return [WeChatPriUtil filtMessageWrapArr:result];
    }
    return result;
}

CHDeclareClass(CSyncBaseEvent)
CHDeclareMethod2(BOOL, CSyncBaseEvent, BatchAddMsg, BOOL, arg1, ShowPush, BOOL, arg2)
{
    NSMutableArray *msgList = [self valueForKeyPath:@"m_arrMsgList"];
    NSMutableArray *msgListResult = [WeChatPriUtil filtMessageWrapArr:msgList];
    [self setValue:msgListResult forKeyPath:@"m_arrMsgList"];
    return CHSuper2(CSyncBaseEvent, BatchAddMsg, arg1, ShowPush, arg2);
}

//MARK: 微信红包
CHDeclareClass(WCRedEnvelopesLogicMgr)
CHOptimizedMethod2(self, void, WCRedEnvelopesLogicMgr, OnWCToHongbaoCommonResponse, HongBaoRes*, arg1, Request, HongBaoReq *, arg2){
    
    CHSuper2(WCRedEnvelopesLogicMgr, OnWCToHongbaoCommonResponse, arg1, Request, arg2);
    
    // 非参数查询请求
    if (arg1.cgiCmdid != 3) { return; }
    
    NSString *(^parseRequestSign)() = ^NSString *() {
        NSString *requestString = [[NSString alloc] initWithData:arg2.reqText.buffer encoding:NSUTF8StringEncoding];
        NSDictionary *requestDictionary = [objc_getClass("WCBizUtil") dictionaryWithDecodedComponets:requestString separator:@"&"];
        NSString *nativeUrl = [[requestDictionary stringForKey:@"nativeUrl"] stringByRemovingPercentEncoding];
        NSDictionary *nativeUrlDict = [objc_getClass("WCBizUtil") dictionaryWithDecodedComponets:nativeUrl separator:@"&"];
        
        return [nativeUrlDict stringForKey:@"sign"];
    };
    
    NSDictionary *responseDict = [[[NSString alloc] initWithData:arg1.retText.buffer encoding:NSUTF8StringEncoding] JSONDictionary];
    
    WeChatRedEnvelopParam *mgrParams = [[WBRedEnvelopParamQueue sharedQueue] dequeue];
    
    BOOL (^shouldReceiveRedEnvelop)() = ^BOOL() {
        
        // 手动抢红包
        if (!mgrParams) { return NO; }
        
        // 自己已经抢过
        if ([responseDict[@"receiveStatus"] integerValue] == 2) { return NO; }
        
        // 红包被抢完
        if ([responseDict[@"hbStatus"] integerValue] == 4) { return NO; }
        
        // 没有这个字段会被判定为使用外挂
        if (!responseDict[@"timingIdentifier"]) { return NO; }
        
        if (mgrParams.isGroupSender) { // 自己发红包的时候没有 sign 字段
            return [WBRedEnvelopConfig sharedConfig].autoReceiveEnable;
        } else {
            return [parseRequestSign() isEqualToString:mgrParams.sign] && [WBRedEnvelopConfig sharedConfig].autoReceiveEnable;
        }
    };
    
    if (shouldReceiveRedEnvelop()) {
        mgrParams.timingIdentifier = responseDict[@"timingIdentifier"];
        
        unsigned int delaySeconds = [self calculateDelaySeconds];
        WBReceiveRedEnvelopOperation *operation = [[WBReceiveRedEnvelopOperation alloc] initWithRedEnvelopParam:mgrParams delay:delaySeconds];
        
        if ([WBRedEnvelopConfig sharedConfig].serialReceive) {
            [[WBRedEnvelopTaskManager sharedManager] addSerialTask:operation];
        } else {
            [[WBRedEnvelopTaskManager sharedManager] addNormalTask:operation];
        }
    }
}
CHDeclareMethod0(unsigned int, WCRedEnvelopesLogicMgr, calculateDelaySeconds) {
    NSInteger configDelaySeconds = [WBRedEnvelopConfig sharedConfig].delaySeconds;
    
    if ([WBRedEnvelopConfig sharedConfig].serialReceive) {
        unsigned int serialDelaySeconds;
        if ([WBRedEnvelopTaskManager sharedManager].serialQueueIsEmpty) {
            serialDelaySeconds = (unsigned int)configDelaySeconds;
        } else {
            serialDelaySeconds = 15;
        }
        
        return serialDelaySeconds;
    } else {
        return (unsigned int)configDelaySeconds;
    }
}

// CMessageMgr
CHOptimizedMethod2(self, void, CMessageMgr, AsyncOnAddMsg, NSString *, msg, MsgWrap, CMessageWrap *, wrap){
    CHSuper2(CMessageMgr, AsyncOnAddMsg, msg, MsgWrap, wrap);
    
    // web和聊天界面的快速切换
    [WeChatNewsMsgManager receiveNewMsg:msg
                                content:wrap.m_nsContent
                           fromUserName:wrap.m_nsFromUsr];
    
    switch(wrap.m_uiMessageType) {
        case 49: { // AppNode
            
            /** 是否为红包消息 */
            BOOL (^isRedEnvelopMessage)() = ^BOOL() {
                return [wrap.m_nsContent rangeOfString:@"wxpay://"].location != NSNotFound;
            };
            
            if (isRedEnvelopMessage()) { // 红包
                Class contactMgrClass = [objc_getClass("CContactMgr") class];
                CContactMgr *contactManager = [[objc_getClass("MMServiceCenter") defaultCenter] getService:contactMgrClass];
                CContact *selfContact = [contactManager getSelfContact];
                
                BOOL (^isSender)() = ^BOOL() {
                    return [wrap.m_nsFromUsr isEqualToString:selfContact.m_nsUsrName];
                };
                
                /** 是否别人在群聊中发消息 */
                BOOL (^isGroupReceiver)() = ^BOOL() {
                    return [wrap.m_nsFromUsr rangeOfString:@"@chatroom"].location != NSNotFound;
                };
                
                /** 是否自己在群聊中发消息 */
                BOOL (^isGroupSender)() = ^BOOL() {
                    return isSender() && [wrap.m_nsToUsr rangeOfString:@"chatroom"].location != NSNotFound;
                };
                
                /** 是否抢自己发的红包 */
                BOOL (^isReceiveSelfRedEnvelop)() = ^BOOL() {
                    return [WBRedEnvelopConfig sharedConfig].receiveSelfRedEnvelop;
                };
                
                /** 是否在黑名单中 */
                BOOL (^isGroupInBlackList)() = ^BOOL() {
                    return [[WBRedEnvelopConfig sharedConfig].blackList containsObject:wrap.m_nsFromUsr];
                };
                
                /** 是否自动抢红包 */
                BOOL (^shouldReceiveRedEnvelop)() = ^BOOL() {
                    if (![WBRedEnvelopConfig sharedConfig].autoReceiveEnable) { return NO; }
                    if (isGroupInBlackList()) { return NO; }
                    
                    return isGroupReceiver() || (isGroupSender() && isReceiveSelfRedEnvelop());
                };
                
                NSDictionary *(^parseNativeUrl)(NSString *nativeUrl) = ^(NSString *nativeUrl) {
                    nativeUrl = [nativeUrl substringFromIndex:[@"wxpay://c2cbizmessagehandler/hongbao/receivehongbao?" length]];
                    return [objc_getClass("WCBizUtil") dictionaryWithDecodedComponets:nativeUrl separator:@"&"];
                };
                
                /** 获取服务端验证参数 */
                void (^queryRedEnvelopesReqeust)(NSDictionary *nativeUrlDict) = ^(NSDictionary *nativeUrlDict) {
                    NSMutableDictionary *params = [@{} mutableCopy];
                    params[@"agreeDuty"] = @"0";
                    params[@"channelId"] = [nativeUrlDict stringForKey:@"channelid"];
                    params[@"inWay"] = @"0";
                    params[@"msgType"] = [nativeUrlDict stringForKey:@"msgtype"];
                    params[@"nativeUrl"] = [[wrap m_oWCPayInfoItem] m_c2cNativeUrl];
                    params[@"sendId"] = [nativeUrlDict stringForKey:@"sendid"];
                    
                    WCRedEnvelopesLogicMgr *logicMgr = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("WCRedEnvelopesLogicMgr") class]];
                    [logicMgr ReceiverQueryRedEnvelopesRequest:params];
                };
                
                /** 储存参数 */
                void (^enqueueParam)(NSDictionary *nativeUrlDict) = ^(NSDictionary *nativeUrlDict) {
                    WeChatRedEnvelopParam *mgrParams = [[WeChatRedEnvelopParam alloc] init];
                    mgrParams.msgType = [nativeUrlDict stringForKey:@"msgtype"];
                    mgrParams.sendId = [nativeUrlDict stringForKey:@"sendid"];
                    mgrParams.channelId = [nativeUrlDict stringForKey:@"channelid"];
                    mgrParams.nickName = [selfContact getContactDisplayName];
                    mgrParams.headImg = [selfContact m_nsHeadImgUrl];
                    mgrParams.nativeUrl = [[wrap m_oWCPayInfoItem] m_c2cNativeUrl];
                    mgrParams.sessionUserName = isGroupSender() ? wrap.m_nsToUsr : wrap.m_nsFromUsr;
                    mgrParams.sign = [nativeUrlDict stringForKey:@"sign"];
                    
                    mgrParams.isGroupSender = isGroupSender();
                    
                    [[WBRedEnvelopParamQueue sharedQueue] enqueue:mgrParams];
                };
                
                if (shouldReceiveRedEnvelop()) {
                    NSString *nativeUrl = [[wrap m_oWCPayInfoItem] m_c2cNativeUrl];			
                    NSDictionary *nativeUrlDict = parseNativeUrl(nativeUrl);
                    
                    queryRedEnvelopesReqeust(nativeUrlDict);
                    enqueueParam(nativeUrlDict);
                }
            }	
            break;
        }
        default:
            break;
    }
    
}

//MARK: 自动添加人
CHOptimizedMethod3(self, void, CMessageMgr, MessageReturn, unsigned int, arg1, MessageInfo, NSDictionary *, info, Event, unsigned int, arg3){
    CHSuper3(CMessageMgr, MessageReturn, arg1, MessageInfo, info, Event, arg3);
    CMessageWrap *wrap = [info objectForKey:@"18"];
    
    if (arg1 == 227) {
        NSDate *now = [NSDate date];
        NSTimeInterval nowSecond = now.timeIntervalSince1970;
        if (nowSecond - wrap.m_uiCreateTime > 60) {      // 若是1分钟前的消息，则不进行处理。
            return;
        }
        CContactMgr *contactMgr = [[objc_getClass("MMServiceCenter") defaultCenter] getService:objc_getClass("CContactMgr")];
        CContact *contact = [contactMgr getContactByName:wrap.m_nsFromUsr];
        if(wrap.m_uiMessageType == 1) {                                         // 收到文本消息
            if (![contact isChatroom]) {                                        // 是否为群聊
                [self performSelector:@selector(autoReplyWithMessageWrap:)
                           withObject:wrap];                                    // 自动回复个人消息
            } else {
                [self performSelector:@selector(removeMemberWithMessageWrap:)
                           withObject:wrap];                                    // 自动踢人
                [self performSelector:@selector(autoReplyChatRoomWithMessageWrap:)
                           withObject:wrap];                                // 自动回复群消息
            }
        } else if(wrap.m_uiMessageType == 10000) {                              // 收到群通知，eg:群邀请了好友；删除了好友。
            CContact *selfContact = [contactMgr getSelfContact];
            if([selfContact.m_nsUsrName isEqualToString:contact.m_nsOwner]) {   // 只有自己创建的群，才发送群欢迎语
                [self performSelector:@selector(welcomeJoinChatRoomWithMessageWrap:) withObject:wrap];
            }
        }
    }
    
    if (arg1 == 332) {                                                          // 收到添加好友消息
        [self performSelector:@selector(addAutoVerifyWithMessageInfo:) withObject:info];
    }
}

CHOptimizedMethod3(self, id, CMessageMgr, GetHelloUsers, id, arg1, Limit, unsigned int, arg2, OnlyUnread, _Bool, arg3){
    id userNameArray = CHSuper3(CMessageMgr, GetHelloUsers, arg1, Limit, arg2, OnlyUnread, arg3);;
    if ([arg1 isEqualToString:@"fmessage"] && arg2 == 0 && arg3 == 0) {
        [self performSelector:@selector(addAutoVerifyWithArray:arrayType:) withObject:userNameArray withObject:@(TKArrayTpyeMsgUserName)];
    }
    
    return userNameArray;
}

// MARK: 给CMessageMgr新增方法
CHDeclareMethod1(void, CMessageMgr, autoReplyWithMessageWrap, CMessageWrap *, wrap) {
    BOOL autoReplyEnable = [[TKRobotConfig sharedConfig] autoReplyEnable];
    NSString *autoReplyContent = [[TKRobotConfig sharedConfig] autoReplyText];
    if (!autoReplyEnable || autoReplyContent == nil || [autoReplyContent isEqualToString:@""]) {                                                     // 是否开启自动回复
        return;
    }
    
    NSString * content = [wrap valueForKeyPath:@"m_nsLastDisplayContent"];
    NSString *needAutoReplyMsg = [[TKRobotConfig sharedConfig] autoReplyKeyword];
    NSArray * keyWordArray = [needAutoReplyMsg componentsSeparatedByString:@"||"];
    [keyWordArray enumerateObjectsUsingBlock:^(NSString *keyword, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([keyword isEqualToString:@"*"] || [content isEqualToString:keyword]) {
            [self performSelector:@selector(sendMsg:toContactUsrName:) withObject:autoReplyContent withObject:wrap.m_nsFromUsr];
        }
    }];
}

CHDeclareMethod1(void, CMessageMgr, removeMemberWithMessageWrap, CMessageWrap *, wrap) {
    BOOL chatRoomSensitiveEnable = [[TKRobotConfig sharedConfig] chatRoomSensitiveEnable];
    if (!chatRoomSensitiveEnable) {
        return;
    }
    
    CGroupMgr *groupMgr = [[objc_getClass("MMServiceCenter") defaultCenter] getService:objc_getClass("CGroupMgr")];
    NSString *content = [wrap valueForKeyPath:@"m_nsLastDisplayContent"];
    NSMutableArray *array = [[TKRobotConfig sharedConfig] chatRoomSensitiveArray];
    [array enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL * _Nonnull stop) {
        if([content isEqualToString:text]) {
            [groupMgr DeleteGroupMember:wrap.m_nsFromUsr withMemberList:@[wrap.m_nsRealChatUsr] scene:3074516140857229312];
        }
    }];
}

CHDeclareMethod1(void, CMessageMgr, autoReplyChatRoomWithMessageWrap, CMessageWrap *, wrap) {
    BOOL autoReplyChatRoomEnable = [[TKRobotConfig sharedConfig] autoReplyChatRoomEnable];
    NSString *autoReplyChatRoomContent = [[TKRobotConfig sharedConfig] autoReplyChatRoomText];
    if (!autoReplyChatRoomEnable || autoReplyChatRoomContent == nil || [autoReplyChatRoomContent isEqualToString:@""]) {                                                     // 是否开启自动回复
        return;
    }
    
    NSString * content = [wrap valueForKeyPath:@"m_nsLastDisplayContent"];
    NSString *needAutoReplyChatRoomMsg = [[TKRobotConfig sharedConfig] autoReplyChatRoomKeyword];
    NSArray * keyWordArray = [needAutoReplyChatRoomMsg componentsSeparatedByString:@"||"];
    [keyWordArray enumerateObjectsUsingBlock:^(NSString *keyword, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([keyword isEqualToString:@"*"] || [content isEqualToString:keyword]) {
            [self performSelector:@selector(sendMsg:toContactUsrName:) withObject:autoReplyChatRoomContent withObject:wrap.m_nsFromUsr];
        }
    }];
}

CHDeclareMethod1(void, CMessageMgr, welcomeJoinChatRoomWithMessageWrap, CMessageWrap *, wrap){
    BOOL welcomeJoinChatRoomEnable = [[TKRobotConfig sharedConfig] welcomeJoinChatRoomEnable];
    if (!welcomeJoinChatRoomEnable) return;                                     // 是否开启入群欢迎语
    
    
    
    
    NSString * content = [wrap valueForKeyPath:@"m_nsLastDisplayContent"];
    NSRange rangeFrom = [content rangeOfString:@"邀请\""];
    NSRange rangeTo = [content rangeOfString:@"\"加入了群聊"];
    NSRange nameRange;
    if (rangeFrom.length > 0 && rangeTo.length > 0) {                           // 通过别人邀请进群
        NSInteger nameLocation = rangeFrom.location + rangeFrom.length;
        nameRange = NSMakeRange(nameLocation, rangeTo.location - nameLocation);
    } else {
        NSRange range = [content rangeOfString:@"\"通过扫描\""];
        if (range.length > 0) {                                                 // 通过二维码扫描进群
            nameRange = NSMakeRange(2, range.location - 2);
        } else {
            return;
        }
    }
    
    NSString *welcomeJoinChatRoomText = [[TKRobotConfig sharedConfig] welcomeJoinChatRoomText];
    [self performSelector:@selector(sendMsg:toContactUsrName:) withObject:welcomeJoinChatRoomText withObject:wrap.m_nsFromUsr];
}

CHDeclareMethod1(void, CMessageMgr, addAutoVerifyWithMessageInfo, NSDictionary *, info){
    BOOL autoVerifyEnable = [[TKRobotConfig sharedConfig] autoVerifyEnable];
    
    if (!autoVerifyEnable)
        return;
    
    NSString *keyStr = [info objectForKey:@"5"];
    if ([keyStr isEqualToString:@"fmessage"]) {
        NSArray *wrapArray = [info objectForKey:@"27"];
        [self performSelector:@selector(addAutoVerifyWithArray:arrayType:) withObject:wrapArray withObject:@(TKArrayTpyeMsgWrap)];
    }
}
// 自动通过好友请求
CHDeclareMethod2(void, CMessageMgr, addAutoVerifyWithArray, NSArray *, ary, arrayType, NSNumber *, type) {
    NSMutableArray *arrHellos = [NSMutableArray array];
    [ary enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (type.integerValue == TKArrayTpyeMsgWrap) {
            CPushContact *contact = [NSClassFromString(@"SayHelloDataLogic") getContactFrom:obj];
            [arrHellos addObject:contact];
        } else if (type.integerValue == TKArrayTpyeMsgUserName) {
            FriendAsistSessionMgr *asistSessionMgr = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("FriendAsistSessionMgr") class]];
            CMessageWrap *wrap = [asistSessionMgr GetLastMessage:@"fmessage" HelloUser:obj OnlyTo:NO];
            CPushContact *contact = [NSClassFromString(@"SayHelloDataLogic") getContactFrom:wrap];
            [arrHellos addObject:contact];
        }
    }];
    
    NSString *autoVerifyKeyword = [[TKRobotConfig sharedConfig] autoVerifyKeyword];
    for (int idx = 0;idx < arrHellos.count;idx++) {
        CPushContact *contact = arrHellos[idx];
        if (![contact isMyContact] && [contact.m_nsDes isEqualToString:autoVerifyKeyword]) {
            CContactVerifyLogic *verifyLogic = [[NSClassFromString(@"CContactVerifyLogic") alloc] init];
            CVerifyContactWrap *wrap = [[NSClassFromString(@"CVerifyContactWrap") alloc] init];
            [wrap setM_nsUsrName:contact.m_nsEncodeUserName];
            [wrap setM_uiScene:contact.m_uiFriendScene];
            [wrap setM_nsTicket:contact.m_nsTicket];
            [wrap setM_nsChatRoomUserName:contact.m_nsChatRoomUserName];
            wrap.m_oVerifyContact = contact;
            
            AutoSetRemarkMgr *mgr = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("AutoSetRemarkMgr") class]];
            id attr = [mgr GetStrangerAttribute:contact AttributeName:1001];
            
            if([attr boolValue]) {
                [wrap setM_uiWCFlag:(wrap.m_uiWCFlag | 1)];
            }
            [verifyLogic startWithVerifyContactWrap:[NSArray arrayWithObject:wrap] opCode:3 parentView:[UIView new] fromChatRoom:NO];
            
            // 发送欢迎语
            BOOL autoWelcomeEnable = [[TKRobotConfig sharedConfig] autoWelcomeEnable];
            NSString *autoWelcomeText = [[TKRobotConfig sharedConfig] autoWelcomeText];
            if (autoWelcomeEnable && autoWelcomeText != nil) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self performSelector:@selector(sendMsg:toContactUsrName:) withObject:autoWelcomeText withObject:contact.m_nsUsrName];
                });
            }
        }
    }
}

// 发送消息
CHDeclareMethod2(void, CMessageMgr, sendMsg, NSString *, msg, toContactUsrName, NSString *, userName) {
    CMessageWrap *wrap = [[NSClassFromString(@"CMessageWrap") alloc] initWithMsgType:1];
    id usrName = [NSClassFromString(@"SettingUtil") getLocalUsrName:0];
    [wrap setM_nsFromUsr:usrName];
    [wrap setM_nsContent:msg];
    [wrap setM_nsToUsr:userName];
    MMNewSessionMgr *sessionMgr = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("MMNewSessionMgr") class]];
    [wrap setM_uiCreateTime:[sessionMgr GenSendMsgTime]];
    [wrap setM_uiStatus:YES];
    
    CMessageMgr *chatMgr = [[objc_getClass("MMServiceCenter") defaultCenter] getService:[objc_getClass("CMessageMgr") class]];
    [chatMgr AddMsg:userName MsgWrap:wrap];
}

//MARK: 阻止撤回消息
CHOptimizedMethod1(self, void, CMessageMgr, onRevokeMsg, CMessageWrap *, arg1)
{
    if (![WBRedEnvelopConfig sharedConfig].revokeEnable) {
        CHSuper1(CMessageMgr, onRevokeMsg, arg1);
    } else {
        if ([arg1.m_nsContent rangeOfString:@"<session>"].location == NSNotFound) { return; }
        if ([arg1.m_nsContent rangeOfString:@"<replacemsg>"].location == NSNotFound) { return; }
        
        NSString *(^parseSession)() = ^NSString *() {
            NSUInteger startIndex = [arg1.m_nsContent rangeOfString:@"<session>"].location + @"<session>".length;
            NSUInteger endIndex = [arg1.m_nsContent rangeOfString:@"</session>"].location;
            NSRange range = NSMakeRange(startIndex, endIndex - startIndex);
            return [arg1.m_nsContent substringWithRange:range];
        };
        
        NSString *(^parseSenderName)() = ^NSString *() {
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<!\\[CDATA\\[(.*?)撤回了一条消息\\]\\]>" options:NSRegularExpressionCaseInsensitive error:nil];
            
            NSRange range = NSMakeRange(0, arg1.m_nsContent.length);
            NSTextCheckingResult *result = [regex matchesInString:arg1.m_nsContent options:0 range:range].firstObject;
            if (result.numberOfRanges < 2) { return nil; }
            
            return [arg1.m_nsContent substringWithRange:[result rangeAtIndex:1]];
        };
        
        CMessageWrap *msgWrap = [[objc_getClass("CMessageWrap") alloc] initWithMsgType:0x2710];
        BOOL isSender = [objc_getClass("CMessageWrap") isSenderFromMsgWrap:arg1];
        
        NSString *sendContent;
        if (isSender) {
            [msgWrap setM_nsFromUsr:arg1.m_nsToUsr];
            [msgWrap setM_nsToUsr:arg1.m_nsFromUsr];
            sendContent = @"你撤回一条消息";
        } else {
            [msgWrap setM_nsToUsr:arg1.m_nsToUsr];
            [msgWrap setM_nsFromUsr:arg1.m_nsFromUsr];
            
            NSString *name = parseSenderName();
            sendContent = [NSString stringWithFormat:@"拦截 %@ 的一条撤回消息", name ? name : arg1.m_nsFromUsr];
        }
        [msgWrap setM_uiStatus:0x4];
        [msgWrap setM_nsContent:sendContent];
        [msgWrap setM_uiCreateTime:[arg1 m_uiCreateTime]];
        
        [self AddLocalMsg:parseSession() MsgWrap:msgWrap fixTime:0x1 NewMsgArriveNotify:0x0];
    }
}

// MARK: 自定义游戏结果
CHOptimizedMethod2(self, void, CMessageMgr, AddEmoticonMsg, id, arg1, MsgWrap, id, arg2){
    CMessageWrap *wrap = (CMessageWrap *)arg2;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger diceNumber = [userDefaults integerForKey:@"WeChatTweakCustomDiceNumberKey"];
    NSInteger rpsResult = [userDefaults integerForKey:@"WeChatTweakCustomRPSResultKey"];
    if (wrap.m_uiGameType == 2) {
        if (diceNumber) {
            CHSuper2(CMessageMgr, AddEmoticonMsg, arg1, MsgWrap, [WeChatPriUtil setDice:arg2 point:diceNumber]);
        } else {
            CHSuper2(CMessageMgr, AddEmoticonMsg, arg1, MsgWrap, arg2);
        }
    } else if (wrap.m_uiGameType == 1) {
        if (rpsResult) {
            CHSuper2(CMessageMgr, AddEmoticonMsg, arg1, MsgWrap, [WeChatPriUtil setRPS:arg2 type:rpsResult]);
        } else {
            CHSuper2(CMessageMgr, AddEmoticonMsg, arg1, MsgWrap, arg2);
        }
    } else {
        CHSuper2(CMessageMgr, AddEmoticonMsg, arg1, MsgWrap, arg2);
    }
}

CHDeclareClass(GameController)
CHOptimizedMethod1(self, void, GameController, getMD5ByGameContent, unsigned int, arg1) {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger diceNumber = [userDefaults integerForKey:@"WeChatTweakCustomDiceNumberKey"];
    NSInteger rpsResult = [userDefaults integerForKey:@"WeChatTweakCustomRPSResultKey"];
    if (arg1 > 3 && arg1 < 10) {
        if (diceNumber) {
            return CHSuper1(GameController,getMD5ByGameContent,diceNumber + 3);
        } else {
            return CHSuper1(GameController,getMD5ByGameContent,arg1);
        }
    } else if (arg1 > 0 && arg1 < 4) {
        if (rpsResult) {
            return CHSuper1(GameController,getMD5ByGameContent,rpsResult);
        } else {
            return CHSuper1(GameController,getMD5ByGameContent,arg1);
        }
    } else {
        return CHSuper1(GameController,getMD5ByGameContent,arg1);
    }
}

CHDeclareClass(CEmoticonUploadMgr)
CHOptimizedMethod1(self, void, CEmoticonUploadMgr, StartUpload, id, arg1) {
    CMessageWrap *wrap = (CMessageWrap *)arg1;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger diceNumber = [userDefaults integerForKey:@"WeChatTweakCustomDiceNumberKey"];
    NSInteger rpsResult = [userDefaults integerForKey:@"WeChatTweakCustomRPSResultKey"];
    if (wrap.m_uiGameType == 2) {
        if (diceNumber) {
            CHSuper1(CEmoticonUploadMgr,StartUpload,[WeChatPriUtil setDice:arg1 point:diceNumber]);
        } else {
            CHSuper1(CEmoticonUploadMgr,StartUpload,arg1);
        }
    } else if (wrap.m_uiGameType == 1) {
        if (rpsResult) {
            CHSuper1(CEmoticonUploadMgr,StartUpload,[WeChatPriUtil setRPS:arg1 type:rpsResult]);
        } else {
            CHSuper1(CEmoticonUploadMgr,StartUpload,arg1);
        }
    } else {
        CHSuper1(CEmoticonUploadMgr,StartUpload,arg1);
    }
}

// MARK: 朋友圈
//CHDeclareClass(WCOperateFloatView)
//CHOptimizedMethod1(self, void, WCOperateFloatView, onLikeItem, id, arg1) {
//    CHSuper1(WCOperateFloatView, onLikeItem, arg1);
//}
//
//CHOptimizedMethod2(self, void, WCOperateFloatView, showWithItemData, WCDataItem *, arg1, tipPoint, struct CGPoint, arg2) {
//    CHSuper2(WCOperateFloatView, showWithItemData, arg1, tipPoint, arg2);
//    if (arg2.x < 0 && !arg1.likeFlag) {
////        [self onLikeItem:arg1];
//        [self performSelector:@selector(onLikeItem:) withObject:arg1 afterDelay:2];
//    }
//}
//
//
////
//CHDeclareClass(WCTimeLineViewController)
//
//CHOptimizedMethod0(self, void, WCTimeLineViewController, viewDidLoad) {
//    CHSuper0(WCTimeLineViewController, viewDidLoad);
//}
//
//CHOptimizedMethod2(self, UITableViewCell *, WCTimeLineViewController, tableView, id, arg1, cellForRowAtIndexPath, NSIndexPath *, indexpath) {
//    
//    UITableViewCell *cell = CHSuper2(WCTimeLineViewController, tableView, arg1, cellForRowAtIndexPath, indexpath);
//    WCTimeLineCellView *cellView = (WCTimeLineCellView *)[WeChatPriUtil findSubView:[[objc_getClass("WCTimeLineCellView") class] class]
//                                                                           fromView:cell];
//    
//    UIButton *lorwyButton = [cellView viewWithTag:9998];
//    if (!lorwyButton) {
//        lorwyButton = [[UIButton alloc] initWithFrame:CGRectMake(-20, 0, 20, 20)];
//        lorwyButton.backgroundColor =[UIColor orangeColor];
//        lorwyButton.tag = 9998;
//        [cellView addSubview:lorwyButton];
//    }
//    [cellView performSelectorOnMainThread:@selector(onCommentPhoto:) withObject:lorwyButton waitUntilDone:NO];
//    return cell;
//}
//
//
////
//CHDeclareClass(WCTimeLineCellView)
//CHOptimizedMethod1(self, void, WCTimeLineCellView, onCommentPhoto, id , arg1) {
//    CHSuper1(WCTimeLineCellView, onCommentPhoto, arg1);
//}
//
//
//
////
//CHDeclareClass(WCLikeButton)
//CHOptimizedMethod1(self, void, WCLikeButton, initWithDataItem, id, arg1) {
//    CHSuper1(WCLikeButton, initWithDataItem, arg1);
//}
//
//CHOptimizedMethod0(self, void, WCLikeButton, onLikeFriend) {
//    CHSuper0(WCLikeButton, onLikeFriend);
//}

CHConstructor{
    // 存取本地配置
    CHLoadLateClass(MicroMessengerAppDelegate);
    CHHook2(MicroMessengerAppDelegate, application, didFinishLaunchingWithOptions);
    
    // 清理发现页面
    CHLoadLateClass(FindFriendEntryViewController);
    CHHook2(FindFriendEntryViewController, tableView, heightForRowAtIndexPath);
    CHHook2(FindFriendEntryViewController, tableView, cellForRowAtIndexPath);
    CHHook1(FindFriendEntryViewController, viewDidAppear);
    
    // 修改微信步数
    CHLoadLateClass(WCDeviceStepObject);
    CHHook0(WCDeviceStepObject, m7StepCount);
    CHLoadLateClass(BraceletRankViewController);
    CHHook2(BraceletRankViewController, tableView, cellForRowAtIndexPath);
    
    // 去小红点
    CHLoadLateClass(MMTabBarController);
    CHHook2(MMTabBarController, setTabBarBadgeImage, forIndex);
    CHHook2(MMTabBarController, setTabBarBadgeString, forIndex);
    CHHook2(MMTabBarController, setTabBarBadgeValue, forIndex);
    CHLoadLateClass(UIView);
    CHHook1(UIView, didAddSubview);
    
    // 消息撤回
    CHLoadLateClass(CMessageMgr);
    CHHook1(CMessageMgr, onRevokeMsg);
    CHHook2(CMessageMgr, AddMsg, MsgWrap);
    
    // 红包
    CHLoadLateClass(WCRedEnvelopesLogicMgr);
    CHHook2(WCRedEnvelopesLogicMgr, OnWCToHongbaoCommonResponse, Request);
    CHHook2(CMessageMgr, AsyncOnAddMsg, MsgWrap);
    
    // 朋友圈
//    CHLoadLateClass(WCOperateFloatView);
//    CHHook1(WCOperateFloatView, onLikeItem);
//    CHHook2(WCOperateFloatView, showWithItemData, tipPoint);
//    
//    CHLoadLateClass(WCTimeLineViewController);
//    CHHook2(WCTimeLineViewController, tableView, cellForRowAtIndexPath);
//    CHHook0(WCTimeLineViewController, viewDidLoad);
//    
//    CHLoadLateClass(WCTimeLineCellView);
//    CHHook1(WCTimeLineCellView, onCommentPhoto);
//    
//    
//    CHLoadLateClass(WCLikeButton);
//    CHHook1(WCLikeButton, initWithDataItem);
//    CHHook0(WCLikeButton, onLikeFriend);

    
    // 自动添加好友
    CHHook3(CMessageMgr, MessageReturn, MessageInfo, Event);
    CHHook3(CMessageMgr, GetHelloUsers, Limit, OnlyUnread);
    
    
    // 自定义游戏
    CHLoadLateClass(GameController);
    CHHook1(GameController, getMD5ByGameContent);
    CHHook2(CMessageMgr, AddEmoticonMsg, MsgWrap);
    
    CHLoadLateClass(CEmoticonUploadMgr);
    CHHook1(CEmoticonUploadMgr, StartUpload);
}

