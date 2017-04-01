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

@property(nonatomic)NSString* avatarImageUrl;
@property(nonatomic)NSString* nickName;
@property(nonatomic)NSString* timestamp;
@property(nonatomic)NSString* mainSharingContent;
@property(nonatomic)NSArray<FLXKSharingImagesModel*>* sharingImages;
@property(nonatomic)NSString* locationRecord;
@property(nonatomic)NSArray<FLXKLikeTheSharingRecordModel*>* likeTheSharingRecords;
@property(nonatomic)NSArray<SharingCommentCellModel*>* sharingComments;

@end
