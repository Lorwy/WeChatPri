//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Jul  5 2017 23:13:50).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "NSObject-Protocol.h"

@class NSData;

@protocol LocalAreaNetworkClientDelegate <NSObject>
- (void)onNetworkConnectFailWithFirstPacketData:(NSData *)arg1;
- (void)onNetworkDisconnect;
- (void)onNetworkReciveData:(NSData *)arg1 andLength:(unsigned int)arg2;
@end

