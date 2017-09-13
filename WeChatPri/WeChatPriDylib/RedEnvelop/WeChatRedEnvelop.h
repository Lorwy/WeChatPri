#import <UIKit/UIKit.h>

@class CMessageWrap;

#pragma mark - Util

@interface WCBizUtil : NSObject

+ (id)dictionaryWithDecodedComponets:(id)arg1 separator:(id)arg2;

@end

@interface SKBuiltinBuffer_t : NSObject

@property(retain, nonatomic) NSData *buffer; // @dynamic buffer;

@end

#pragma mark - Manager

@interface MMNewSessionMgr : NSObject
- (unsigned int)GenSendMsgTime;
@end

#pragma mark - Message

@interface WCPayInfoItem: NSObject

@property(retain, nonatomic) NSString *m_c2cNativeUrl;

@end

@interface FriendAsistSessionMgr : NSObject
- (id)GetLastMessage:(id)arg1 HelloUser:(id)arg2 OnlyTo:(BOOL)arg3;
@end

@interface AutoSetRemarkMgr : NSObject
- (id)GetStrangerAttribute:(id)arg1 AttributeName:(int)arg2;
@end

@interface CMessageMgr : NSObject

- (id)GetMsg:(id)arg1 n64SvrID:(long long)arg2;
- (void)AsyncOnSpecialSession:(id)arg1 MsgList:(id)arg2;
- (id)GetHelloUsers:(id)arg1 Limit:(unsigned int)arg2 OnlyUnread:(BOOL)arg3;

- (void)DelMsg:(id)arg1 MsgList:(id)arg2 DelAll:(_Bool)arg3;
- (void)AddMsg:(id)arg1 MsgWrap:(id)arg2;
- (void)onRevokeMsg:(id)arg1;
- (id)GetMsgByCreateTime:(id)arg1 FromID:(unsigned int)arg2 FromCreateTime:(unsigned int)arg3 Limit:(unsigned int)arg4 LeftCount:(unsigned int *)arg5 FromSequence:(unsigned int)arg6;
- (void)AddLocalMsg:(id)arg1 MsgWrap:(id)arg2 fixTime:(_Bool)arg3 NewMsgArriveNotify:(_Bool)arg4;
- (void)AsyncOnAddMsg:(id)arg1 MsgWrap:(id)arg2;
- (void)MessageReturn:(unsigned int)arg1 MessageInfo:(id)arg2 Event:(unsigned int)arg3;

- (void)AddEmoticonMsg:(id)arg1 MsgWrap:(id)arg2;

// new
- (void)addAutoVerifyWithArray:(NSArray *)ary arrayType:(TKArrayTpye)type;
- (void)addAutoVerifyWithMessageInfo:(NSDictionary *)info;
- (void)autoReplyWithMessageWrap:(CMessageWrap *)wrap;
- (void)autoReplyChatRoomWithMessageWrap:(CMessageWrap *)wrap;
- (void)sendMsg:(NSString *)msg toContactUsrName:(NSString *)userName;
- (void)welcomeJoinChatRoomWithMessageWrap:(CMessageWrap *)wrap;
- (void)removeMemberWithMessageWrap:(CMessageWrap *)wrap;


@end

@interface CBaseContact : NSObject
@property (nonatomic, copy) NSString *m_nsEncodeUserName;                // 微信用户名转码
@property (nonatomic, assign) int m_uiFriendScene;                       // 是否是自己的好友(非订阅号、自己)
@property (nonatomic,assign) BOOL m_isPlugin;                            // 是否为微信插件
- (BOOL)isChatroom;
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

@property (nonatomic, copy) NSString *m_nsLastDisplayContent;
@property (nonatomic, copy) NSString *m_nsPushContent;

@property(nonatomic) unsigned int m_uiGameType;     // 游戏类型
@property(nonatomic) unsigned int m_uiGameContent;  // 游戏内容

- (id)initWithMsgType:(long long)arg1;
+ (_Bool)isSenderFromMsgWrap:(id)arg1;

@end

@interface MMServiceCenter : NSObject

+ (instancetype)defaultCenter;
- (id)getService:(Class)service;

@end

@interface CGroupMgr : NSObject
- (BOOL)SetChatRoomDesc:(id)arg1 Desc:(id)arg2 Flag:(unsigned int)arg3;
- (BOOL)CreateGroup:(id)arg1 withMemberList:(id)arg2;
- (_Bool)DeleteGroupMember:(id)arg1 withMemberList:(id)arg2 scene:(unsigned long long)arg3;
@end

@interface MMLanguageMgr: NSObject

- (id)getStringForCurLanguage:(id)arg1 defaultTo:(id)arg2;


@end

#pragma mark - RedEnvelop

@interface WCRedEnvelopesControlData : NSObject

@property(retain, nonatomic) CMessageWrap *m_oSelectedMessageWrap;

@end

@interface WCRedEnvelopesLogicMgr: NSObject

- (void)OpenRedEnvelopesRequest:(id)params;
- (void)ReceiverQueryRedEnvelopesRequest:(id)arg1;
- (void)GetHongbaoBusinessRequest:(id)arg1 CMDID:(unsigned int)arg2 OutputType:(unsigned int)arg3;
- (void)OnWCToHongbaoCommonResponse:(id)arg1 Request:(id)arg2;

/** Added Methods */
- (unsigned int)calculateDelaySeconds;

@end

@interface HongBaoRes : NSObject

@property(retain, nonatomic) SKBuiltinBuffer_t *retText; // @dynamic retText;
@property(nonatomic) int cgiCmdid; // @dynamic cgiCmdid;

@end

@interface HongBaoReq : NSObject

@property(retain, nonatomic) SKBuiltinBuffer_t *reqText; // @dynamic reqText;

@end

#pragma mark - Contact

@interface CContact: CBaseContact <NSCoding>

@property(retain, nonatomic) NSString *m_nsHeadImgUrl;
@property (nonatomic, copy) NSString *m_nsOwner;                        // 拥有者
@property (nonatomic, copy) NSString *m_nsNickName;                     // 用户昵称
@property (nonatomic, copy) NSString *m_nsUsrName;                      // 微信id
@property (nonatomic, copy) NSString *m_nsMemberName;

- (id)getContactDisplayName;
- (id)getChatRoomMemberWithoutMyself:(id)arg1;

@end

@interface CPushContact : CContact
@property (nonatomic, copy) NSString *m_nsChatRoomUserName;
@property (nonatomic, copy) NSString *m_nsDes;
@property (nonatomic, copy) NSString *m_nsSource;
@property (nonatomic, copy) NSString *m_nsSourceNickName;
@property (nonatomic, copy) NSString *m_nsSourceUserName;
@property (nonatomic, copy) NSString *m_nsTicket;
- (BOOL)isMyContact;
@end

@interface CVerifyContactWrap : NSObject
@property (nonatomic, copy) NSString *m_nsChatRoomUserName;
@property (nonatomic, copy) NSString *m_nsOriginalUsrName;
@property (nonatomic, copy) NSString *m_nsSourceNickName;
@property (nonatomic, copy) NSString *m_nsSourceUserName;
@property (nonatomic, copy) NSString *m_nsTicket;
@property (nonatomic, copy) NSString *m_nsUsrName;
@property (nonatomic, strong) CContact *m_oVerifyContact;
@property (nonatomic, assign) unsigned int m_uiScene;
@property (nonatomic, assign) unsigned int m_uiWCFlag;
@end


@interface GroupMember : NSObject
@property(copy, nonatomic) NSString *m_nsNickName;; // @synthesize m_nsNickName;
@property(nonatomic) unsigned int m_uiMemberStatus; // @synthesize m_uiMemberStatus;
@property(copy, nonatomic) NSString *m_nsMemberName; // @synthesize m_nsMemberName;
@end

@interface CContactMgr : NSObject

- (id)getSelfContact;
- (id)getContactByName:(id)arg1;
- (id)getContactForSearchByName:(id)arg1;
- (_Bool)getContactsFromServer:(id)arg1;
- (_Bool)isInContactList:(id)arg1;
- (_Bool)addLocalContact:(id)arg1 listType:(unsigned int)arg2;
- (id)getContactList:(unsigned int)arg1 contactType:(unsigned int)arg2;

@end


#pragma mark - QRCode

@interface ScanQRCodeLogicController: NSObject

@property(nonatomic) unsigned int fromScene;
- (id)initWithViewController:(id)arg1 CodeType:(int)arg2;
- (void)tryScanOnePicture:(id)arg1;
- (void)doScanQRCode:(id)arg1;
- (void)showScanResult;

@end

@interface NewQRCodeScanner: NSObject

- (id)initWithDelegate:(id)arg1 CodeType:(int)arg2;
- (void)notifyResult:(id)arg1 type:(id)arg2 version:(int)arg3;

@end

#pragma mark - MMTableView

@interface MMTableViewInfo

- (id)getSectionAt:(int)arg1;
- (id)getTableView;
- (void)clearAllSection;
- (void)addSection:(id)arg1;
- (void)insertSection:(id)arg1 At:(unsigned int)arg2;

@property(nonatomic,assign) id delegate;

@end

@interface MMTableViewSectionInfo

+ (id)sectionInfoDefaut;
+ (id)sectionInfoHeader:(id)arg1;
+ (id)sectionInfoHeader:(id)arg1 Footer:(id)arg2;
- (void)addCell:(id)arg1;

- (void)removeCellAt:(unsigned long long)arg1;
- (unsigned long long)getCellCount;

@end

@interface MMTableViewCellInfo

+ (id)normalCellForSel:(SEL)arg1 target:(id)arg2 title:(id)arg3 accessoryType:(long long)arg4;
+ (id)switchCellForSel:(SEL)arg1 target:(id)arg2 title:(id)arg3 on:(_Bool)arg4;
+ (id)normalCellForSel:(SEL)arg1 target:(id)arg2 title:(id)arg3 rightValue:(id)arg4 accessoryType:(long long)arg5;
+ (id)normalCellForTitle:(id)arg1 rightValue:(id)arg2;
+ (id)urlCellForTitle:(id)arg1 url:(id)arg2;
+ (id)editorCellForSel:(SEL)arg1 target:(id)arg2 tip:(id)arg3 focus:(_Bool)arg4 text:(id)arg5;
@property(nonatomic) long long editStyle; // @synthesize editStyle=_editStyle;
@property(retain, nonatomic) id userInfo;

@end

@interface MMTableView: UITableView

@end

#pragma mark - UI
@interface MMUICommonUtil : NSObject

+ (id)getBarButtonWithTitle:(id)arg1 target:(id)arg2 action:(SEL)arg3 style:(int)arg4;

@end

@interface SettingUtil : NSObject
+ (id)getLocalUsrName:(unsigned int)arg1;
@end

@interface MMLoadingView : UIView

@property(retain, nonatomic) UILabel *m_label; // @synthesize m_label;
@property (assign, nonatomic) BOOL m_bIgnoringInteractionEventsWhenLoading; // @synthesize m_bIgnoringInteractionEventsWhenLoading;

- (void)setFitFrame:(long long)arg1;
- (void)startLoading;
- (void)stopLoading;
- (void)stopLoadingAndShowError:(id)arg1;
- (void)stopLoadingAndShowOK:(id)arg1;


@end

@interface MMTextView : UITextView
@property(retain, nonatomic) NSString *placeholder;
@end

@interface MMWebViewController: UIViewController

- (id)initWithURL:(id)arg1 presentModal:(_Bool)arg2 extraInfo:(id)arg3;

-  (void)didReceiveNewMessage;
- (void)backToMsgContentViewController;

@end


@protocol ContactSelectViewDelegate <NSObject>

- (void)onSelectContact:(CContact *)arg1;

@end

@interface ContactSelectView : UIView

@property(nonatomic) unsigned int m_uiGroupScene; // @synthesize m_uiGroupScene;
@property(nonatomic) _Bool m_bMultiSelect; // @synthesize m_bMultiSelect;
@property(retain, nonatomic) NSMutableDictionary *m_dicMultiSelect; // @synthesize m_dicMultiSelect;

- (id)initWithFrame:(struct CGRect)arg1 delegate:(id)arg2;
- (void)initData:(unsigned int)arg1;
- (void)initView;
- (void)addSelect:(id)arg1;

@property(nonatomic) _Bool m_bShowHistoryGroup; // @synthesize m_bShowHistoryGroup;
@property(nonatomic) _Bool m_bShowRadarCreateRoom; // @synthesize m_bShowRadarCreateRoom;
@property(retain, nonatomic) NSDictionary *m_dicExistContact; // @synthesize m_dicExistContact;
- (void)initSearchBar;
- (void)makeGroupCell:(id)arg1 head:(id)arg2 title:(id)arg3;

@end

#pragma mark - Logic

@interface SayHelloDataLogic : NSObject
@property (nonatomic, strong) NSMutableArray *m_arrHellos;
- (void)loadData:(unsigned int)arg1;
+ (id)getContactFrom:(id)arg1;
- (id)getContactForIndex:(unsigned int)arg1;
- (void)onFriendAssistAddMsg:(NSArray *)arg1;
@end

@interface CContactVerifyLogic : NSObject
- (void)startWithVerifyContactWrap:(id)arg1
                            opCode:(unsigned int)arg2
                        parentView:(id)arg3
                      fromChatRoom:(BOOL)arg4;
@end

@interface ContactsDataLogic : NSObject

@property(nonatomic) unsigned int m_uiScene; // @synthesize m_uiScene;
- (id)getKeysArray;
- (BOOL)reloadContacts;
- (BOOL)hasHistoryGroupContacts;
- (id)getContactsArrayWith:(id)arg1;
- (id)initWithScene:(unsigned int)arg1 delegate:(id)arg2 sort:(BOOL)arg3;

@end

@interface SKBuiltinString_t : NSObject
// Remaining properties
@property(copy, nonatomic) NSString *string; // @dynamic string;
@end

@interface CreateChatRoomResponse : NSObject
@property(strong, nonatomic) SKBuiltinString_t *chatRoomName; // @dynamic chatRoomName;
@end


@interface MMUINavigationController : UINavigationController

@end

#pragma mark - UtilCategory

@interface NSMutableDictionary (SafeInsert)

- (void)safeSetObject:(id)arg1 forKey:(id)arg2;

@end

@interface NSDictionary (NSDictionary_SafeJSON)

- (id)arrayForKey:(id)arg1;
- (id)dictionaryForKey:(id)arg1;
- (double)doubleForKey:(id)arg1;
- (float)floatForKey:(id)arg1;
- (long long)int64ForKey:(id)arg1;
- (long long)integerForKey:(id)arg1;
- (id)stringForKey:(id)arg1;

@end

@interface NSString (NSString_SBJSON)

- (id)JSONArray;
- (id)JSONDictionary;
- (id)JSONValue;

@end

#pragma mark - UICategory

@interface UINavigationController (LogicController)

- (void)PushViewController:(id)arg1 animated:(_Bool)arg2;

@end

@interface MMUIViewController : UIViewController

- (void)startLoadingBlocked;
- (void)startLoadingNonBlock;
- (void)startLoadingWithText:(NSString *)text;
- (void)stopLoading;
- (void)stopLoadingWithFailText:(NSString *)text;
- (void)stopLoadingWithOKText:(NSString *)text;

@end

@interface NewSettingViewController: MMUIViewController

- (void)reloadTableData;
- (void)setting;
- (void)simplifySetting;
- (void)groupSetting;

@end

@interface SayHelloViewController : UIViewController
@property (nonatomic, strong) SayHelloDataLogic *m_DataLogic;
- (void)OnSayHelloDataVerifyContactOK:(CPushContact *)arg1;
@end

@interface ContactInfoViewController : MMUIViewController

@property(retain, nonatomic) CContact *m_contact; // @synthesize m_contact;

@end

@protocol MultiSelectContactsViewControllerDelegate <NSObject>
- (void)onMultiSelectContactReturn:(NSArray *)arg1;

@optional
- (int)getFTSCommonScene;
- (void)onMultiSelectContactCancelForSns;
- (void)onMultiSelectContactReturnForSns:(NSArray *)arg1;
@end

@interface MultiSelectContactsViewController : UIViewController

@property(nonatomic) _Bool m_bKeepCurViewAfterSelect; // @synthesize m_bKeepCurViewAfterSelect=_m_bKeepCurViewAfterSelect;
@property(nonatomic) unsigned int m_uiGroupScene; // @synthesize m_uiGroupScene;

@property(nonatomic, weak) id <MultiSelectContactsViewControllerDelegate> m_delegate; // @synthesize m_delegate;

@end

