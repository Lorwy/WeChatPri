//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Jul  5 2017 23:13:50).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class WCDataBaseItem;

@interface WCDBTableColumnInfo : NSObject
{
    _Bool m_isRowId;
    unsigned int m_objectIndex;
    WCDataBaseItem *m_item;
}

@property(nonatomic) _Bool m_isRowId; // @synthesize m_isRowId;
@property(nonatomic) unsigned int m_objectIndex; // @synthesize m_objectIndex;
@property(retain, nonatomic) WCDataBaseItem *m_item; // @synthesize m_item;
- (void).cxx_destruct;

@end

