//
//  WeChatPriConfigCenter.h
//  WeChatPri
//
//  Created by Lorwy on 2017/8/4.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>


/**
 配置中心
 */
@interface WeChatPriConfigCenter : NSObject<NSCoding>

@property (nonatomic, getter = isNightMode) BOOL nightMode;
@property (nonatomic) unsigned int stepCount;
@property (nonatomic,retain) NSDate *lastChangeStepCountDate;
@property (nonatomic, retain) NSMutableDictionary<NSString *,NSNumber *> *chatIgnoreInfo;
@property (nonatomic, getter=onRevokeMsg) BOOL revokeMsg;
@property (nonatomic, copy) NSString *currentUserName;

+ (instancetype)sharedInstance;
+ (void)loadInstance:(WeChatPriConfigCenter *)instance;

- (void)handleNightMode:(UISwitch *)sender;
- (void)handleStepCount:(UITextField *)sender;
- (void)handleIgnoreChatRoom:(UISwitch *)sender;

@end
