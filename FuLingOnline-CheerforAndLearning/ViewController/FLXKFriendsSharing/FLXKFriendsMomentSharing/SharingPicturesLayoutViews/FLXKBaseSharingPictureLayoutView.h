//
//  FLXKBaseSharingPictureLayoutView.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "FLXKBaseSharingPictureLayoutView.h"

#import "FLXKSharingImagesModel.h"


@interface FLXKBaseSharingPictureLayoutView : UIView

@property(nonatomic)NSArray<NSString*>* imageArray;

+(FLXKBaseSharingPictureLayoutView*)setupSharingPictureLayoutViewWithImageArray:(NSArray<FLXKSharingImagesModel*>*)imageArray;

@end
