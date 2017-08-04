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

#define WeChatPriConfigCenterKey @"WeChatPriConfigCenterKey"

// 发现页面
CHDeclareClass(FindFriendEntryViewController)

// 设置页面
CHDeclareClass(NewSettingViewController)
//CHDeclareClass(MMTableViewInfo)
//CHDeclareClass(MMTableViewSectionInfo)
//CHDeclareClass(MMTableViewCellInfo)
//CHDeclareClass(MMTableView)

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
    if ((indexPath.section == 1 && indexPath.row == 1)
        || (indexPath.section == 2 && indexPath.row == 0)
        || (indexPath.section == 3 && indexPath.row == 0))
    {
        return 0;
    }
    return CHSuper2(FindFriendEntryViewController, tableView, tableView, heightForRowAtIndexPath, indexPath);
}

CHOptimizedMethod2(self, UITableViewCell *, FindFriendEntryViewController, tableView, UITableView *, tableView, cellForRowAtIndexPath, NSIndexPath *, indexPath)
{
    UITableViewCell *cell = CHSuper2(FindFriendEntryViewController, tableView, tableView, cellForRowAtIndexPath, indexPath);
    if ((indexPath.section == 1 && indexPath.row == 1)
        || (indexPath.section == 2 && indexPath.row == 0)
        || (indexPath.section == 3 && indexPath.row == 0))
    {
        NSLog(@"## 隐藏摇一摇、附近的人、购物 ##");
        cell.hidden = YES;
        for (UIView *subview in cell.subviews) {
            [subview removeFromSuperview];
        }
    }
    return cell;
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
    // 加一个输入步数的cell
    MMTableViewCellInfo *stepcountCellInfo = [objc_getClass("MMTableViewCellInfo") editorCellForSel:@selector(handleStepCount:) target:[WeChatPriConfigCenter sharedInstance] tip:@"请输入步数" focus:NO text:[NSString stringWithFormat:@"%ld", (long)[WeChatPriConfigCenter sharedInstance].stepCount]];
    [sectionInfo addCell:stepcountCellInfo];
    [tableInfo insertSection:sectionInfo At:0];
    MMTableView *tableView = [tableInfo getTableView];
    [tableView reloadData];
}

//MARK: 微信运动步数
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

//MARK: 阻止撤回消息
CHOptimizedMethod1(self, void, CMessageMgr, onRevokeMsg, id, msg)
{
    [WeChatPriConfigCenter sharedInstance].revokeMsg = YES;
    CHSuper1(CMessageMgr, onRevokeMsg, msg);
}

CHDeclareMethod3(void, CMessageMgr, DelMsg, id, arg1, MsgList, id, arg2, DelAll, BOOL, arg3)
{
    if ([WeChatPriConfigCenter sharedInstance].revokeMsg) {
        [WeChatPriConfigCenter sharedInstance].revokeMsg = NO;
    }
    else {
        CHSuper3(CMessageMgr, DelMsg, arg1, MsgList, arg2, DelAll, arg3);
    }
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
}

