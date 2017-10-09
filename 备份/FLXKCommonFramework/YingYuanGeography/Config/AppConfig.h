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

//containerVCName为目的tabbaritem基类

//xibType
//0:no xib
//1:single xib
//2:in storyboard

//#define Router(URLString) [[UIApplication sharedApplication]openURL:[NSURL URLWithString:(URLString)]];
#define Router(URLString)  dispatch_barrier_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{\
[FLXKAPPRouter openURL:[NSURL URLWithString:(URLString)] withScheme:@"FuLingOnLineScheme"];\
});


#pragma mark -
#pragma mark - APP Network API


//Http Request Part
//#define BaseURL @"http://127.0.0.1:3000"
#define BaseURL(relativeString) [NSString stringWithFormat:@"http://%@:%@/%@",UserDefaultsObjForKey(@"ServerIP"),UserDefaultsObjForKey(@"ServerPort"),relativeString]

#define NSURL_BaseURL(relativeString) [NSURL URLWithString:BaseURL(relativeString)]

//朋友圈
#define Url_GetAdvertisementImageInfo BaseURL(@"launch/getAdvertisementImage")


//==================================================Http Request Part======================================================

#define HOST_URL [NSString stringWithFormat:@"https://%@:%@",UserDefaultsObjForKey(@"ServerIP"),UserDefaultsObjForKey(@"ServerPort")]

#define APP_Update_HOST @"wap.psylife.cc"

#define APP_Update_URL @"http://%@/Baojiao/interface/checkVersion.action?modelType=ios"
//==================================================Global data======================================================

#define ShoolName [[NSUserDefaults standardUserDefaults]objectForKey:@"ShoolName"]?:@"迎园地理"
#define LocalRecordFileName @"数据记录.txt"

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


//==================================================FBTweakValue======================================================

#define FLXKMessageToolBar_Font_Size FBTweakValue(@"FLXKMessageToolBar", @"sharedInstance",  @"font", 15.0)


//==================================================LearingTest======================================================


#define NoteFile [PsySegueJumpHelper sharedInstance].projectParameters.noteFile
#define NoteFilelOACL [PsySegueJumpHelper sharedInstance].projectParameters.noteFilelOACL

//接口

#define Adress [PsySegueJumpHelper sharedInstance].projectParameters.adress
#define Port [PsySegueJumpHelper sharedInstance].projectParameters.port
#define yf_url [PsySegueJumpHelper sharedInstance].projectParameters.Yf_url

//进度条
//需要设置进度条的widtht,heigh和YPosition轴的位置（会居中显示）
//(-984+20, 66, 984, 25)
#define ProgressWidth 1024
#define ProgressHeigh 13
#define ProgressX (1024-ProgressWidth)/2
#define ProgressY 73

//底图，下一题，播放音频的按钮图片
#define ImageBackground @"clear.png"
#define ImageNextButton @"nextBtn.png"
#define ImageAudioButton @"voiceBtn.png"


#endif
