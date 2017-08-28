//
//  WeChatNewsMsgManager.m
//  WeChatPri
//
//  Created by Lorwy on 2017/8/28.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import "WeChatNewsMsgManager.h"

static UIButton* contentView;


@implementation WeChatNewsMsgManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static WeChatNewsMsgManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [WeChatNewsMsgManager new];
    });
    return instance;
}

+ (void)receiveNewMsg:(NSString *)userName
              content:(NSString *)content
         fromUserName:(NSString *)fromUserName {
    
    [WeChatNewsMsgManager sharedInstance].username = userName;
    [WeChatNewsMsgManager sharedInstance].content = content;
    [WeChatNewsMsgManager sharedInstance].fromUserName = fromUserName;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KweChatNewMessageNotification object:nil];
    
}

+ (UIButton *)showHUDInView:(UIView *)superView
                 text:(NSString *)text
               target:(id)target
               action:(SEL)action {
    
    [contentView removeFromSuperview];
    contentView = nil;
    
    contentView = [[UIButton alloc] init];
    contentView.backgroundColor = [UIColor grayColor];
    contentView.layer.cornerRadius = 10;
    contentView.clipsToBounds = YES;
    contentView.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [superView addSubview:contentView];
    
    [contentView setTitle:text forState:UIControlStateNormal];
    
    [contentView addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    contentView.frame = CGRectMake(10, 74, superView.frame.size.width -  20, 30);
    return contentView;
}

+ (BOOL)showed
{
    return contentView && contentView.superview;
}

+ (void)hideMsgHudAfterDelay:(NSTimeInterval)delay {
    [[self class] performSelector:@selector(hideMsg) withObject:nil afterDelay:delay];
}

+ (void)hideMsg {
    if ([WeChatNewsMsgManager showed]) {
        [contentView removeFromSuperview];
        contentView = nil;
    }
}

@end
