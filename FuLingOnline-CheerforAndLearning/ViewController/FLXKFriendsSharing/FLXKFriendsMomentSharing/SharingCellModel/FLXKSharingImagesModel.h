//
//  FLXKSharingImagesModel.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/1.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLXKSharingImagesModel : NSObject
@property(nonatomic)NSString* id;
@property(nonatomic)NSString* newsID;
@property(nonatomic)NSString* pictureSize;
@property(nonatomic)NSString* picturePath;
@property(nonatomic)NSString* isDeleted;
@property(nonatomic)NSString* actualPictureUrl;
@property(nonatomic)NSString* thumbnailPictureUrl;
@property(nonatomic)NSString* pictureName;
@property(nonatomic)NSString* uid;
@property(nonatomic)NSInteger originImageWidth;
@property(nonatomic)NSInteger originImageHeight;
@property(nonatomic)NSInteger thumberImageWidth;
@property(nonatomic)NSInteger thumberImageHeight;

@end
