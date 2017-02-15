//
//  FLXKEmotionConfig.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/20.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#ifndef FLXKEmotionConfig_h
#define FLXKEmotionConfig_h
//-----------------------------------------Utilities-----------------------------------------
#define FLXKUserDefaults ([NSUserDefaults standardUserDefaults])
#define FLXKUserDefaultsObjForKey(key) (  [[NSUserDefaults standardUserDefaults]objectForKey:key] )
#define FLXKUserDefaultsSetObjForKey(obj,key) ( [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key] )
#define FLXKUserDefaultsRemoveObjForKey(key) ( [[NSUserDefaults standardUserDefaults]removeObjectForKey:key] )
#define FLXKUserDefaultsSynchronize [ [NSUserDefaults standardUserDefaults] synchronize];

#define RGBA(r,g,b,a)         [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//-----------------------------------------UIScreen-----------------------------------------
#define Screen_Width   [[UIScreen mainScreen] bounds].size.width
#define Screen_Height   [[UIScreen mainScreen] bounds].size.height

//-----------------------------------------Data-----------------------------------------
#define CollectionViewHeight 161

#define CollectionViewFrame CGRectMake(0, 0, Screen_Width, CollectionViewHeight)
#define Cell_FLXKEmotionCollectionViewNomalCell @"FLXKEmotionCollectionViewNomalCell"
#define Cell_FLXKNormalEmotionGroupCollectionViewCell @"FLXKNormalEmotionGroupCollectionViewCell"

#define SelectedEmotionGroupOptionsSQLUserDefaultsKey @"SelectedEmotionGroupOptions"
#define SelectedEmotionGroupOptionsUserDefaultsKey @"SelectedEmotionGroupOptions"
#endif /* FLXKEmotionConfig_h */
