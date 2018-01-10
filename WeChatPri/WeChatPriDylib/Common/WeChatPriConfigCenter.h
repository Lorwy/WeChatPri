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

#define WeChatPriConfigCenterKey @"WeChatPriConfigCenterKey"

/**
 配置中心
 */
@interface WeChatPriConfigCenter : NSObject<NSCoding>

@property (nonatomic, getter = isNightMode) BOOL nightMode;
@property (nonatomic) unsigned int stepCount;
@property (nonatomic, getter = isStepAutoLike) BOOL stepAutoLike;
@property (nonatomic, getter = isShowMsgInWebPage) BOOL showMsgInWebPage;
@property (nonatomic,retain) NSDate *lastChangeStepCountDate;
@property (nonatomic, retain) NSMutableDictionary<NSString *,NSNumber *> *chatIgnoreInfo;
//@property (nonatomic, getter=onRevokeMsg) BOOL revokeMsg;
@property (nonatomic, copy) NSString *currentUserName;
@property (nonatomic, assign) BOOL customLocation;
@property (nonatomic, strong) NSMutableArray *customLocationArray;        /**<    自己添加的地点    */
@property (nonatomic, assign) BOOL customStep;

@property (nonatomic, copy) NSString* customLat;
@property (nonatomic, copy) NSString* customLng;

@property (nonatomic, assign) BOOL friendEnter;
@property (nonatomic, assign) BOOL scanEnter;
@property (nonatomic, assign) BOOL shakeEnter;
@property (nonatomic, assign) BOOL searchEnter;
@property (nonatomic, assign) BOOL nearbydEnter;
@property (nonatomic, assign) BOOL driftBottleEnter;
@property (nonatomic, assign) BOOL shopEnter;
@property (nonatomic, assign) BOOL gameEnter;
@property (nonatomic, assign) BOOL appletEnter;

+ (instancetype)sharedInstance;
+ (void)saveConfigCenter;
+ (void)loadInstance:(WeChatPriConfigCenter *)instance;

- (void)handleNightMode:(UISwitch *)sender;
- (void)handleStepAutoLike:(UISwitch *)sender;
- (void)handleShowMsgInWebPage:(UISwitch *)sender;
- (void)handleStepCount:(UITextField *)sender;
- (void)handleIgnoreChatRoom:(UISwitch *)sender;


- (void)handleCustomLat:(UITextField *)sender;
- (void)handleCustomLng:(UITextField *)sender;

+ (BOOL)isCustomFindPage;

@end
