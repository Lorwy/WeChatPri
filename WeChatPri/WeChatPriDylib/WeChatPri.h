//
//  WeChatPri.h
//  WeChatPri
//
//  Created by Lorwy on 2017/8/4.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeChatRedEnvelop.h"

#pragma mark - Controller

@interface FindFriendEntryViewController:UIViewController

- (void)reloadData;
- (void)cleanCell:(UITableViewCell *)cell;

@end

@interface BaseMsgContentViewController : UIViewController

- (id)GetContact;

@end


@interface AddContactToChatRoomViewController : UIViewController

@end

@interface ChatRoomInfoViewController : UIViewController

@end


@interface MMTableViewCell : UITableViewCell

@end

@interface DeviceRankInfo : NSObject

@property(nonatomic) BOOL localLike; // @synthesize localLike=_localLike;
@property(nonatomic) BOOL hasLike; // @synthesize hasLike=_hasLike;
@property(nonatomic) unsigned int likeCount; // @synthesize likeCount=_likeCount;
@property(copy, nonatomic) NSString *scoreTitle; // @synthesize scoreTitle=_scoreTitle;
@property(copy, nonatomic) NSString *rankTitle; // @synthesize rankTitle=_rankTitle;
@property(nonatomic) unsigned int score; // @synthesize score=_score;
@property(nonatomic) unsigned int rank; // @synthesize rank=_rank;
@property(copy, nonatomic) NSString *nickname; // @synthesize nickname=_nickname;
@property(copy, nonatomic) NSString *username; // @synthesize username=_username;

@end

@interface BraceletRankLikeButton : UIButton

@property(retain) DeviceRankInfo *m_rankInfo;

@end

@interface BraceletRankViewController : UIViewController


@property (nonatomic,strong) UIBarButtonItem *m_rightBarBtnItem;

- (void)onClickLike:(DeviceRankInfo *)arg1;

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

@interface CSyncBaseEvent : NSObject

- (_Bool)BatchAddMsg:(_Bool)arg1 ShowPush:(_Bool)arg2;

@end

