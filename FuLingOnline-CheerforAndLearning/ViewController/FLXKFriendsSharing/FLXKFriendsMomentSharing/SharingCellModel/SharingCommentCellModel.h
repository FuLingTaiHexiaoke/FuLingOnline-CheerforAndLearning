//
//  FLXKSharingCellModel.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+ModelConverter.h"

@interface SharingCommentCellModel : NSObject
@property(nonatomic)NSString* _id;
@property(nonatomic)NSString* fromUserID;
@property(nonatomic)NSString* fromUserName;
@property(nonatomic)NSString* toUserID;
@property(nonatomic)NSString* toUserName;
@property(nonatomic)NSString* content;
@property(nonatomic)NSInteger isReply;
@property(nonatomic)NSString* timestamp;
@property(nonatomic)NSString* newsID;

+(NSAttributedString*)getCommentString:(SharingCommentCellModel *)model;
@end
