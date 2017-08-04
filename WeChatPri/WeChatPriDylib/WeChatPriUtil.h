//
//  WeChatPriUtil.h
//  WeChatPri
//
//  Created by Lorwy on 2017/8/4.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeChatPriUtil : NSObject

+ (NSMutableArray * )filtMessageWrapArr:(NSMutableArray *)msgList;

+ (BOOL)compareColor:(UIColor *)color1 color2:(UIColor *)color2;

@end
