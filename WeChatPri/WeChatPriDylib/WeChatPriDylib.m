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



//-fno-objc-arc

//CHDeclareClass(UIApplication)
//CHDeclareClass(MicroMessengerAppDelegate)
//CHDeclareClass(CMessageMgr)
CHDeclareClass(FindFriendEntryViewController)
//CHDeclareClass(MMTabBarController)
//CHDeclareClass(MMBadgeView)
//CHDeclareClass(WCDeviceStepObject)
//CHDeclareClass(NewMainFrameViewController)
//CHDeclareClass(UIView)
//CHDeclareClass(NewSettingViewController)
//CHDeclareClass(MMTableViewInfo)
//CHDeclareClass(MMTableViewSectionInfo)
//CHDeclareClass(MMTableViewCellInfo)
//CHDeclareClass(MMTableView)
//CHDeclareClass(UIViewController)
//CHDeclareClass(UILabel)
//CHDeclareClass(ChatRoomInfoViewController)

@interface FindFriendEntryViewController:UIViewController

- (void)reloadData;

@end

static __attribute__((constructor)) void entry()
{
    NSLog(@"\n               🎉!!！congratulations!!！🎉\n👍----------------insert dylib success----------------👍");
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        CYListenServer(6666);
    }];
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


CHConstructor{
    CHLoadLateClass(FindFriendEntryViewController);
    CHHook2(FindFriendEntryViewController, tableView, heightForRowAtIndexPath);
    CHHook2(FindFriendEntryViewController, tableView, cellForRowAtIndexPath);
    CHHook1(FindFriendEntryViewController, viewDidAppear);
}

