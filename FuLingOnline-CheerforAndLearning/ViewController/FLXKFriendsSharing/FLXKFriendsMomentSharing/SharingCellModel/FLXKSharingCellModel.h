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
@property (assign, nonatomic)BOOL shouldShowSharingContentShowAllButton;

@property (assign, nonatomic)BOOL isMainSharingContentLabelExpand;
@end
