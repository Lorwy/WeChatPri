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
- (void)AddMsg:(id)arg1 MsgWrap:(id)arg2;
- (void)onRevokeMsg:(id)arg1;
- (id)GetMsgByCreateTime:(id)arg1 FromID:(unsigned int)arg2 FromCreateTime:(unsigned int)arg3 Limit:(unsigned int)arg4 LeftCount:(unsigned int *)arg5 FromSequence:(unsigned int)arg6;
- (void)AddLocalMsg:(id)arg1 MsgWrap:(id)arg2 fixTime:(_Bool)arg3 NewMsgArriveNotify:(_Bool)arg4;

@end

@interface CSyncBaseEvent : NSObject

- (_Bool)BatchAddMsg:(_Bool)arg1 ShowPush:(_Bool)arg2;

@end

#pragma mark - message

@interface WCPayInfoItem: NSObject

@property(retain, nonatomic) NSString *m_c2cNativeUrl;

@end

@interface CMessageWrap : NSObject

@property (retain, nonatomic) WCPayInfoItem *m_oWCPayInfoItem;
@property (assign, nonatomic) NSUInteger m_uiMesLocalID;
@property (retain, nonatomic) NSString* m_nsFromUsr;            ///< 发信人，可能是群或个人
@property (retain, nonatomic) NSString* m_nsToUsr;              ///< 收信人
@property (assign, nonatomic) NSUInteger m_uiStatus;
@property (retain, nonatomic) NSString* m_nsContent;            ///< 消息内容
@property (retain, nonatomic) NSString* m_nsRealChatUsr;        ///< 群消息的发信人，具体是群里的哪个人
@property (assign, nonatomic) NSUInteger m_uiMessageType;
@property (assign, nonatomic) long long m_n64MesSvrID;
@property (assign, nonatomic) NSUInteger m_uiCreateTime;
@property (retain, nonatomic) NSString *m_nsDesc;
@property (retain, nonatomic) NSString *m_nsAppExtInfo;
@property (assign, nonatomic) NSUInteger m_uiAppDataSize;
@property (assign, nonatomic) NSUInteger m_uiAppMsgInnerType;
@property (retain, nonatomic) NSString *m_nsShareOpenUrl;
@property (retain, nonatomic) NSString *m_nsShareOriginUrl;
@property (retain, nonatomic) NSString *m_nsJsAppId;
@property (retain, nonatomic) NSString *m_nsPrePublishId;
@property (retain, nonatomic) NSString *m_nsAppID;
@property (retain, nonatomic) NSString *m_nsAppName;
@property (retain, nonatomic) NSString *m_nsThumbUrl;
@property (retain, nonatomic) NSString *m_nsAppMediaUrl;
@property (retain, nonatomic) NSData *m_dtThumbnail;
@property (retain, nonatomic) NSString *m_nsTitle;
@property (retain, nonatomic) NSString *m_nsMsgSource;

- (id)initWithMsgType:(long long)arg1;
+ (_Bool)isSenderFromMsgWrap:(id)arg1;

@end

#pragma mark - contact
@interface CContactMgr : NSObject

- (id)getSelfContact;
- (id)getContactByName:(id)arg1;
- (id)getContactForSearchByName:(id)arg1;
- (_Bool)getContactsFromServer:(id)arg1;
- (_Bool)isInContactList:(id)arg1;
- (_Bool)addLocalContact:(id)arg1 listType:(unsigned int)arg2;

@end

@interface MMServiceCenter : NSObject

+ (instancetype)defaultCenter;
- (id)getService:(Class)service;

@end

@interface CContact: NSObject <NSCoding>

@property(retain, nonatomic) NSString *m_nsUsrName;
@property(retain, nonatomic) NSString *m_nsHeadImgUrl;
@property(retain, nonatomic) NSString *m_nsNickName;

- (id)getContactDisplayName;

- (id)getChatRoomMemberWithoutMyself:(id)arg1;

@end
