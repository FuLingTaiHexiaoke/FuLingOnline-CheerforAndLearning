//
//  UserModel.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/12.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property(nonatomic)NSString* userID;
@property(nonatomic)NSString* login_name;
@property(nonatomic)NSString* password;
@property(nonatomic)NSString* name;
@property(nonatomic)NSString* avatar_picture;
@property(nonatomic)NSString* thumb_avatar_picture;
@property(nonatomic)NSString* phone_number;
@property(nonatomic)NSString* gender;
@property(nonatomic)NSString* birthday;
@property(nonatomic)NSString* self_detail;
@property(nonatomic)NSString* email;
@property(nonatomic)NSString* location;
@property(nonatomic)NSString* website;
@end
