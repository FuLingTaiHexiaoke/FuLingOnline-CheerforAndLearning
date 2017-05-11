//
//  config.h
//  Psy-TeachersTerminal
//
//  Created by apple on 2016/6/30.
//  Copyright © 2016年 apple. All rights reserved.
//




#ifndef FriendsMomentSharingConfig_h
#define FriendsMomentSharingConfig_h
//================================================== GLOBAL ======================================================
// 屏幕高度
#define SCREEN_FULL_HEIGHT         [[UIScreen mainScreen] bounds].size.height
// 屏幕宽度
#define SCREEN_FULL_WIDTH          [[UIScreen mainScreen] bounds].size.width

#define RGBA(r,g,b,a)         [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r,g,b)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define SYSTEM_FONT(size)      [UIFont systemFontOfSize:size]

#define objectOrNull(obj) ((obj) ? (obj) : [NSNull null])
#define objectOrEmptyStr(obj) ((obj) ? (obj) : @"")

#define isNull(x)             (!x || [x isKindOfClass:[NSNull class]])
#define toInt(x)              (isNull(x) ? 0 : [x intValue])
#define isEmptyString(x)      (isNull(x) || [x isEqual:@""] || [x isEqual:@"(null)"])
#define isNotEmptyString(x)     ( !(isNull(x) || [x isEqual:@""] || [x isEqual:@"(null)"]))

//================================================== FLXKSharingFuLingOnlineStyleCell ======================================================
#define avatarImageViewHeight 40
#define sharingMainOperationsContainerViewHeight 21
#define likeTheSharingRecordScrollViewHeight 20
#define bottomSeparatorLineViewHeight 0.5

#define DEFAULT_VIEW_SPACING 8

#define CONTENT_LABEL_FONT_SIZE 14
#define CONTENT_LABEL_DEFAULT_HEIGHT  68
#define CONTENT_SHOW_BUTTON_NORMAL_COLOR RGB(92,140,193)
#define CONTENT_SHOW_BUTTON_SELECTED_COLOR RGB(92,140,193)


#define LOCATION_BUTTON_FONT_SIZE 14
#define LOCATION_BUTTON_NORMAL_COLOR RGB(92,140,193)


#define COMMENT_CELL_LABEL_FONT_SIZE 14


#define MAX_CONTENT_WIDTH (SCREEN_FULL_WIDTH-avatarImageViewHeight-DEFAULT_VIEW_SPACING)
#define RECT_FOR_TEXT_GET_HEIGHT (CGRectMake(0, 0, MAX_CONTENT_WIDTH, CGFLOAT_MAX))
#define SIZE_FOR_TEXT_GET_HEIGHT (CGSizeMake(MAX_CONTENT_WIDTH, CGFLOAT_MAX))

#define COMMENT_USER_TEXT_FONT_COLOR [UIColor colorWithRed:73/255.0 green:119/255.0 blue:154/255.0 alpha:1.0]


#define IMAGES_DEFAULT_SPACE (5)
#define IMAGES_DEFAULT_WIDTH  (80+IMAGES_DEFAULT_SPACE)
#define IMAGES_DEFAULT_HEIGHT (80+IMAGES_DEFAULT_SPACE)

#endif
