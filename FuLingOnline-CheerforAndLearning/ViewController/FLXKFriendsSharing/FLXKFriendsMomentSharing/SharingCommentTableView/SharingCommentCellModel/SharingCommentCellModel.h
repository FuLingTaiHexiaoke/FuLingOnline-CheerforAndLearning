//
//  FLXKSharingCellModel.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharingCommentCellModel : NSObject
@property(nonatomic)NSString* user_id;
@property(nonatomic)NSString* user_name;
@property(nonatomic)NSString* avatarImageUrl;
@property(nonatomic)NSString* nickName;
@property(nonatomic)NSString* comment_content;
@property(nonatomic)NSString* thumbUp_timestamp;
@property(nonatomic)NSString* content_id;
@property(nonatomic)NSInteger isReply;

@end