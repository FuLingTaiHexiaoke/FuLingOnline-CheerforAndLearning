//
//  config.h
//  Psy-TeachersTerminal
//
//  Created by apple on 2016/6/30.
//  Copyright © 2016年 apple. All rights reserved.
//
#import "BaseConfig.h"


#ifndef config_h
#define config_h

//================================================== GLOBAL APPEARANCE COLOR======================================================
#pragma mark -
#pragma mark - GLOBAL APPEARANCE COLOR

#define NAVIGATION_BAR_TOP_BARTINTCOLOR [UIColor orangeColor]
#define NAVIGATION_BAR_TOP_TINTCOLOR [UIColor whiteColor]

#define NAVIGATION_BAR_DEFAULT_BARTINTCOLOR RGBA(248, 249, 250, 1.0)
#define NAVIGATION_BAR_DEFAULT_TINTCOLOR RGBA(91, 92, 94, 1.0)

//================================================== [NSUserDefaults standardUserDefaults]======================================================

#pragma mark -
#pragma mark - NSUserDefaults

#define login_user_name  @"login_user_name"
#define login_user_password  @"login_user_password"
#define login_user_remember  @"login_user_remember"
#define apns_deviceToken  @"apns_deviceToken"

#pragma mark -
#pragma mark - NSNotification

//==================================================NSNotification Key======================================================

#define SeverRemoteNotificationCameKey @"SeverRemoteNotificationCameKey"


#pragma mark -
#pragma mark - NSError
//================================================== NSError Domain======================================================

#define   NetWorkOffError [NSError errorWithDomain:@"error" code:100001 userInfo:@{NSLocalizedDescriptionKey:@"网络连接异常"}];


#pragma mark -
#pragma mark - APP ViewController Router


#define VC_VIEWCONTROLLER @"VC"

#define VC_STORYBOARD @"SB"

#define NORMAL_ICON @"ICONOR"

#define  SELECTED_ICON @"ICONSE"

#define TITLE @"TITLE"

//xibType
//0:no xib
//1:single xib
//2:in storyboard

//#define Router(URLString) [[UIApplication sharedApplication]openURL:[NSURL URLWithString:(URLString)]];
#define Router(URLString)  dispatch_barrier_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{\
[FLXKAPPRouter openURL:[NSURL URLWithString:(URLString)] withScheme:@"FuLingOnLineScheme"];\
});

//#define Router(URLString)  [FLXKURLSchemaRouter openURL:[NSURL URLWithString:(URLString)] withScheme:@"FuLingOnLineScheme"];

#define Router_FLXKTabBarController @"FuLingOnLineScheme://FLXKTabBarController?containerVCName=&xibType=2&stName=Main&stid=stid_FLXKTabBarController"
#define Router_TabBar_FriendsSharing_NewsPublish @"FuLingOnLineScheme://FLXKNewsPublishController?containerVCName=FLXKFriendsSharingViewController&xibType=2&stName=Main&stid=stid_FLXKNewsPublishController"
#define Router_Launch_NotificationCenter @"FuLingOnLineScheme://NotificationExamplesTableViewController?containerVCName=&xibType=0&stName=&stid="



#pragma mark -
#pragma mark - APP Network API


//Http Request Part
//#define BaseURL @"http://127.0.0.1:3000"
#define BaseURL(relativeString) [NSString stringWithFormat:@"http://%@:%@/%@",UserDefaultsObjForKey(@"ServerIP"),UserDefaultsObjForKey(@"ServerPort"),relativeString]

#define NSURL_BaseURL(relativeString) [NSURL URLWithString:BaseURL(relativeString)]

//#define BaseURL(relativeString) [NSString stringWithFormat:@"http://%@:%@/%@",UserDefaultsObjForKey(@"ServerIP"),UserDefaultsObjForKey(@"ServerPort"),relativeString]

//朋友圈
#define Url_GetAdvertisementImageInfo BaseURL(@"launch/getAdvertisementImage")

//https://127.0.0.1:3000/publishNewsController/PublishNewsModel
#define Url_UploadPublishNews BaseURL(@"publishNewsController/PublishNewsModel")

//#define Url_GetFriendSharingModel BaseURL(@"publishNewsController/PublishNewsModel/1")
#define Url_GetFriendSharingModel BaseURL(@"publishNewsController/PublishNewsModel/getNewsModel")

//点赞
#define Url_AddFriendsharingThumbup BaseURL(@"publishNewsController/PublishNewsModel/addThumberup")//添加点赞

//评论
#define Url_AddFriendsharingComment BaseURL(@"publishNewsController/PublishNewsModel/addComment")

//用户
#define Url_AddUser BaseURL(@"userController/User")

#define Url_GetUser BaseURL(@"userController/User/")

//==================================================Http Request Part======================================================

#define HOST_URL [NSString stringWithFormat:@"https://%@:%@",UserDefaultsObjForKey(@"ServerIP"),UserDefaultsObjForKey(@"ServerPort")]

#define APP_Update_HOST @"wap.psylife.cc"

#define APP_Update_URL @"http://%@/Baojiao/interface/checkVersion.action?modelType=ios"

#define APP_GetFriendSharingModel  [NSString stringWithFormat:@"%@/publishNewsController/PublishNewsModel/1",HOST_URL]




#endif
