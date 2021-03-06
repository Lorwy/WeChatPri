//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Jul  5 2017 23:13:50).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MMUIViewController.h"

#import "UIScrollViewDelegate-Protocol.h"

@class FaceRecogGuideInfo, MMUILabel, NSString, UIButton, UIImageView, UIScrollView, UIView;
@protocol FaceRecogGuideViewControllerDelegate;

@interface FaceRecogGuideViewController : MMUIViewController <UIScrollViewDelegate>
{
    id <FaceRecogGuideViewControllerDelegate> _delegate;
    UIScrollView *_pageScrollView;
    MMUILabel *_guideTitleLabel;
    UIImageView *_firstStepNumberIconView;
    MMUILabel *_firstStepContentLabel;
    UIImageView *_firstStepIconView;
    UIImageView *_secondStepNumberIconView;
    MMUILabel *_secondStepContentLabel;
    UIImageView *_secondStepIconView;
    UIButton *_finishBtn;
    UIButton *_cancelBtn;
    UIView *_connectLineView;
    FaceRecogGuideInfo *_guideInfo;
}

@property(retain, nonatomic) FaceRecogGuideInfo *guideInfo; // @synthesize guideInfo=_guideInfo;
@property(retain, nonatomic) UIView *connectLineView; // @synthesize connectLineView=_connectLineView;
@property(retain, nonatomic) UIButton *cancelBtn; // @synthesize cancelBtn=_cancelBtn;
@property(retain, nonatomic) UIButton *finishBtn; // @synthesize finishBtn=_finishBtn;
@property(retain, nonatomic) UIImageView *secondStepIconView; // @synthesize secondStepIconView=_secondStepIconView;
@property(retain, nonatomic) MMUILabel *secondStepContentLabel; // @synthesize secondStepContentLabel=_secondStepContentLabel;
@property(retain, nonatomic) UIImageView *secondStepNumberIconView; // @synthesize secondStepNumberIconView=_secondStepNumberIconView;
@property(retain, nonatomic) UIImageView *firstStepIconView; // @synthesize firstStepIconView=_firstStepIconView;
@property(retain, nonatomic) MMUILabel *firstStepContentLabel; // @synthesize firstStepContentLabel=_firstStepContentLabel;
@property(retain, nonatomic) UIImageView *firstStepNumberIconView; // @synthesize firstStepNumberIconView=_firstStepNumberIconView;
@property(retain, nonatomic) MMUILabel *guideTitleLabel; // @synthesize guideTitleLabel=_guideTitleLabel;
@property(retain, nonatomic) UIScrollView *pageScrollView; // @synthesize pageScrollView=_pageScrollView;
@property(nonatomic) __weak id <FaceRecogGuideViewControllerDelegate> delegate; // @synthesize delegate=_delegate;
- (void).cxx_destruct;
- (void)initData;
- (void)initLineView;
- (void)initFirstPage;
- (void)initScrollView;
- (void)initView;
- (void)viewDidLoad;
- (void)dealloc;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

