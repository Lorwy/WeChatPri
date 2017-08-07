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

