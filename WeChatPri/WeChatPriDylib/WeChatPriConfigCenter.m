//
//  WeChatPriConfigCenter.m
//  WeChatPri
//
//  Created by Lorwy on 2017/8/4.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import "WeChatPriConfigCenter.h"


@implementation WeChatPriConfigCenter

LSERIALIZE_CODER_DECODER()

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static WeChatPriConfigCenter *instance;
    dispatch_once(&onceToken, ^{
        instance = [WeChatPriConfigCenter new];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.chatIgnoreInfo = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (void)loadInstance:(WeChatPriConfigCenter *)instance {
    WeChatPriConfigCenter *center = [self sharedInstance];
    center.nightMode = instance.isNightMode;
    center.stepCount = instance.stepCount;
    center.revokeMsg = instance.onRevokeMsg;
    center.chatIgnoreInfo = instance.chatIgnoreInfo;
    center.currentUserName = instance.currentUserName;
    center.lastChangeStepCountDate = instance.lastChangeStepCountDate;
}

#pragma mark - Handle Events

- (void)handleNightMode:(UISwitch *)sender
{
    self.nightMode = sender.isOn;
    [[self viewControllerOfResponder:sender] viewWillAppear:NO];
}

- (void)handleStepCount:(UITextField *)sender
{
    self.stepCount = (unsigned int)sender.text.integerValue;
    self.lastChangeStepCountDate = [NSDate date];
}

- (void)handleIgnoreChatRoom:(UISwitch *)sender
{
    self.chatIgnoreInfo[self.currentUserName] = @(sender.isOn);
}

- (UIViewController *)viewControllerOfResponder:(UIResponder *)responder
{
    UIResponder *current = responder;
    while (current && ![current isKindOfClass:UIViewController.class]) {
        current = [current nextResponder];
    }
    return (UIViewController *)current;
}

@end
