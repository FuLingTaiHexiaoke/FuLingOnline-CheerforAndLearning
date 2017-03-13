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

#pragma mark -
#pragma mark - NSUserDefaults

//================================================== [NSUserDefaults standardUserDefaults]======================================================
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
#define BaseURL(relativeString) [NSString stringWithFormat:@"https://%@:%@/%@",UserDefaultsObjForKey(@"ServerIP"),UserDefaultsObjForKey(@"ServerPort"),relativeString]
//#define BaseURL(relativeString) [NSString stringWithFormat:@"http://%@:%@/%@",UserDefaultsObjForKey(@"ServerIP"),UserDefaultsObjForKey(@"ServerPort"),relativeString]

#define Url_GetAdvertisementImageInfo BaseURL(@"launch/getAdvertisementImage")

//https://127.0.0.1:3000/publishNewsController/PublishNewsModel
#define Url_UploadPublishNews BaseURL(@"publishNewsController/PublishNewsModel")




//==================================================Http Request Part======================================================

#define HOST_URL @"192.168.2.142:8080"

#define APP_Update_HOST @"wap.psylife.cc"

//#define APP_Update_URL @"http://%@/Baojiao/interface/checkVersion.action?modelType=ios"
#define APP_Update_URL @"https://%@/ser_higher3.0_lvyuan/ServletControler.do?action=CheckVersion"

//1.登录接口  tag判断手机类型//0代表android,1代表ios
#define LOGIN_URL @"http://%@/Baojiao/interface/login.action?username=%@&password=%@&key=%@&tag=1"

//2.根据教师id获取该教师参加的会议--以及会议的问卷
#define get_meeting_list_url @"http://%@/Baojiao/interface/getMeeting.action?userid=%@&status=%@"

//3.根据教师id获取该全校会议--以及会议的问卷
#define get_all_school_meeting_list_url @"http://%@/Baojiao/interface/getAllSchoolMeeting.action?userid=%@&status=%@"

//4.根据会议id获取问卷
#define get_meeting_paper_url @"http://%@/Baojiao/interface/toAnsQuestion.action?userid=%@&meetingid=%@"

//5.根据会议id获取问卷
#define get_meeting_signed_url @"http://%@/Baojiao/user/sign.action?meetingid=%@"


#endif
