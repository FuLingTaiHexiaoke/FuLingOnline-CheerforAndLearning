//
//  FLXKEmotionConfig.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/20.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#ifndef FLXKEmotionConfig_h
#define FLXKEmotionConfig_h

#define Screen_Width   [[UIScreen mainScreen] bounds].size.width
#define Screen_Height   [[UIScreen mainScreen] bounds].size.height

#define RGBA(r,g,b,a)         [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define CollectionViewHeight 161

#define CollectionViewFrame CGRectMake(0, 0, Screen_Width, CollectionViewHeight)
#define Cell_FLXKEmotionCollectionViewNomalCell @"FLXKEmotionCollectionViewNomalCell"
#define Cell_FLXKNormalEmotionGroupCollectionViewCell @"FLXKNormalEmotionGroupCollectionViewCell"

#endif /* FLXKEmotionConfig_h */
