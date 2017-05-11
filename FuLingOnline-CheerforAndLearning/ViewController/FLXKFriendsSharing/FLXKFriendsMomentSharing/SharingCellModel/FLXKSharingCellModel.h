//
//  FLXKSharingCellModel.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLXKLikeTheSharingRecordModel;
@class SharingCommentCellModel;
@class FLXKSharingImagesModel;

@interface FLXKSharingCellModel : NSObject

@property(nonatomic)NSString* newsID;
@property(nonatomic)NSString* fromUserID;
@property(nonatomic)NSInteger isThumberuped;
@property(nonatomic)NSString* avatarImageUrl;
@property(nonatomic)NSString* nickName;
@property(nonatomic)NSString* timestamp;
@property(nonatomic)NSString* mainSharingContent;
@property(nonatomic)NSArray<FLXKSharingImagesModel*>* sharingImages;
@property(nonatomic)NSString* locationRecord;
@property(nonatomic)NSMutableArray<UserModel*>* likeTheSharingUserRecords;
@property(nonatomic)NSMutableArray<SharingCommentCellModel*>* sharingComments;

@property(nonatomic,assign)CGFloat headerSection_Height;
@property(nonatomic,assign)CGFloat default_mainSharingContent_Height;
@property(nonatomic,assign)CGFloat mainSharingContent_Height;
@property(nonatomic,assign)CGFloat showContentButton_Height;
@property(nonatomic,assign)CGFloat sharingImages_Height;
@property(nonatomic,assign)CGFloat sharingImages_Width;
@property(nonatomic,assign)CGFloat locationRecord_Height;
@property(nonatomic,assign)CGFloat sharingMainOperationsContainerView_Height;
@property(nonatomic,assign)CGFloat likeTheSharingUserRecords_Height;
@property(nonatomic,assign)CGFloat bottomSeparatorLineView_Height;
@property(nonatomic,assign)CGFloat sharingComments_Height;

@property(nonatomic,assign)CGFloat cell_Height;


@property (assign, nonatomic)BOOL shouldShowMainSharingContent;
@property (assign, nonatomic)BOOL shouldShowSharingContentShowAllButton;
@property (assign, nonatomic)BOOL shouldShowSharingImages;
@property (assign, nonatomic)BOOL shouldShowLocationRecord;
@property (assign, nonatomic)BOOL shouldShow_bottomSeparatorLineView;
@property (assign, nonatomic)BOOL shouldShow_sharingComments;


@property (assign, nonatomic)BOOL isMainSharingContentLabelExpand;

@end
