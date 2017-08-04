//
//  WeChatPriUtil.m
//  WeChatPri
//
//  Created by Lorwy on 2017/8/4.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import "WeChatPriUtil.h"
#import "WeChatPriConfigCenter.h"

@implementation WeChatPriUtil

+ (NSMutableArray * )filtMessageWrapArr:(NSMutableArray *)msgList
{
    NSMutableArray *msgListResult = [msgList mutableCopy];
    for (id msgWrap in msgList) {
        Ivar nsFromUsrIvar = class_getInstanceVariable(objc_getClass("CMessageWrap"), "m_nsFromUsr");
        NSString *m_nsFromUsr = object_getIvar(msgWrap, nsFromUsrIvar);
        if ([WeChatPriConfigCenter sharedInstance].chatIgnoreInfo[m_nsFromUsr].boolValue) {
            [msgListResult removeObject:msgWrap];
        }
    }
    return msgListResult;
}

@end
