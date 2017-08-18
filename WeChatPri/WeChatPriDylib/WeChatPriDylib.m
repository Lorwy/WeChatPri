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
    // 加一个输入步数的cell
    MMTableViewCellInfo *stepcountCellInfo = [objc_getClass("MMTableViewCellInfo") editorCellForSel:@selector(handleStepCount:) target:[WeChatPriConfigCenter sharedInstance] tip:@"请输入步数" focus:NO text:[NSString stringWithFormat:@"%ld", (long)[WeChatPriConfigCenter sharedInstance].stepCount]];
    [sectionInfo addCell:stepcountCellInfo];
    
    MMTableViewCellInfo *settingCell = [objc_getClass("MMTableViewCellInfo") normalCellForSel:@selector(setting) target:self title:@"红包小助手" accessoryType:1];
    [sectionInfo addCell:settingCell];
    
    MMTableViewCellInfo *simplifySettingCell = [objc_getClass("MMTableViewCellInfo") normalCellForSel:@selector(simplifySetting) target:self title:@"功能开关" accessoryType:1];
    [sectionInfo addCell:simplifySettingCell];
    
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
}

