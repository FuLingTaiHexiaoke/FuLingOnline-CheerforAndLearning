//
//  FLXKBaseSharingPictureLayoutView.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>

//utilites
#import "Masonry.h"
#import "UIImageView+WebCache.h"

#import "FLXKSharingImagesModel.h"


@interface FLXKBaseSharingOperationContainerView : UIView

@property(nonatomic)NSArray<FLXKSharingImagesModel*>* imageArray;

//+(FLXKBaseSharingPictureLayoutView*)setupSharingPictureLayoutViewWithImageArray:(NSArray<FLXKSharingImagesModel*>*)imageArray;

@end
