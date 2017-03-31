//
//  FLXKSharingCellModel.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharingCommentCellModel : NSObject
//@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
//@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
//@property (weak, nonatomic) IBOutlet UILabel *mainSharingContentLabel;
//@property (weak, nonatomic) IBOutlet UIView *sharingImagesContainerView;
//@property (weak, nonatomic) IBOutlet UIButton *locationRecordButton;
//@property (weak, nonatomic) IBOutlet UIView *sharingMainOperationsContainerView;
//@property (weak, nonatomic) IBOutlet UIScrollView *likeTheSharingRecordScrollView;
//@property (weak, nonatomic) IBOutlet UIView *bottomSeparatorLineView;
//@property (weak, nonatomic) IBOutlet UITableView *sharingCommentsTableView;

@property(nonatomic)NSString* avatarImageUrl;
@property(nonatomic)NSString* nickName;
@property(nonatomic)NSString* timestamp;
@property(nonatomic)NSString* mainSharingContent;
@property(nonatomic)NSString* sharingImages;
@property(nonatomic)NSString* locationRecord;
@property(nonatomic)NSString* likeTheSharingRecords;
@property(nonatomic)NSString* sharingComments;

@end
