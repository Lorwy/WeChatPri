//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Jul  5 2017 23:13:50).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSString;

@interface AddShareObject : NSObject
{
    _Bool m_bIsSelected;
    NSString *m_nsTitle;
    NSString *m_nsContent;
    int m_eShareType;
}

@property(nonatomic) int m_eShareType; // @synthesize m_eShareType;
@property(retain, nonatomic) NSString *m_nsContent; // @synthesize m_nsContent;
@property(retain, nonatomic) NSString *m_nsTitle; // @synthesize m_nsTitle;
@property(nonatomic) _Bool m_bIsSelected; // @synthesize m_bIsSelected;
- (void).cxx_destruct;
- (id)init;

@end

