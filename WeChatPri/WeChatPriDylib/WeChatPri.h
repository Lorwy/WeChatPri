//
//  WeChatPri.h
//  WeChatPri
//
//  Created by Lorwy on 2017/8/4.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Controller
@interface FindFriendEntryViewController:UIViewController

- (void)reloadData;

@end

@interface NewSettingViewController : UIViewController

- (void)reloadTableData;

@end

@interface BaseMsgContentViewController : UIViewController

- (id)GetContact;

@end


@interface AddContactToChatRoomViewController : UIViewController

@end

@interface ChatRoomInfoViewController : UIViewController

@end



#pragma mark - MMTableView

@interface MMTableViewInfo : NSObject

- (id)getSectionAt:(int)arg1;
- (id)getTableView;
- (void)insertSection:(id)arg1 At:(unsigned int)arg2;

@end

@interface MMTableViewSectionInfo

+ (id)sectionInfoDefaut;
+ (id)sectionInfoHeader:(id)arg1;
+ (id)sectionInfoHeader:(id)arg1 Footer:(id)arg2;
- (void)addCell:(id)arg1;


@end

@interface MMTableViewCellInfo : NSObject

+ (id)switchCellForSel:(SEL)arg1 target:(id)arg2 title:(id)arg3 on:(_Bool)arg4;
+ (id)editorCellForSel:(SEL)arg1 target:(id)arg2 tip:(id)arg3 focus:(_Bool)arg4 text:(id)arg5;

@end

@interface MMTableView: UITableView

- (void)reloadData;

@end

#pragma mark - setp
@interface WCDeviceStepObject: NSObject


- (unsigned int)m7StepCount;

@end

#pragma mark - red dot
@interface MMTabBarController: UITabBarController

- (void)setTabBarBadgeImage:(id)arg1 forIndex:(unsigned int)arg2;
- (void)setTabBarBadgeString:(id)arg1 forIndex:(long long)arg2;
- (void)setTabBarBadgeValue:(long long)arg1 forIndex:(long long)arg2;

@end

@interface CMessageMgr : NSObject

- (void)DelMsg:(id)arg1 MsgList:(id)arg2 DelAll:(_Bool)arg3;
- (void)onRevokeMsg:(id)arg1;
- (id)GetMsgByCreateTime:(id)arg1 FromID:(unsigned int)arg2 FromCreateTime:(unsigned int)arg3 Limit:(unsigned int)arg4 LeftCount:(unsigned int *)arg5 FromSequence:(unsigned int)arg6;

@end

@interface CSyncBaseEvent : NSObject

- (_Bool)BatchAddMsg:(_Bool)arg1 ShowPush:(_Bool)arg2;

@end

