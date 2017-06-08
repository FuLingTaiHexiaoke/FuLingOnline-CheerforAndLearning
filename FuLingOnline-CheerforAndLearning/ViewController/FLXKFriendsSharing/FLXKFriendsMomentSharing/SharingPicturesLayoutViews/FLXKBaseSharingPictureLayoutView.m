//
//  FLXKBaseSharingPictureLayoutView.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKBaseSharingPictureLayoutView.h"
//child views
#import "FLXKSharingPicturesShowingView.h"

@implementation FLXKBaseSharingPictureLayoutView


+(FLXKBaseSharingPictureLayoutView*)setupSharingPictureLayoutViewWithImageArray:(NSArray<FLXKSharingImagesModel*>*)imageArray{
    FLXKBaseSharingPictureLayoutView* pictureLayoutView;
    NSInteger imageCount=imageArray.count;
    switch (imageCount) {
        case 0:
            pictureLayoutView=[[FLXKBaseSharingPictureLayoutView alloc]init];
            break;
        default:
            pictureLayoutView=[[FLXKSharingPicturesShowingView alloc]init];
            break;
    }
    
    [pictureLayoutView setImageArray:imageArray];
    
    return pictureLayoutView;
}

-(void)setImageArray:(NSArray<FLXKSharingImagesModel *> *)imageArray{
    
}

-(void)setModel:(FLXKSharingCellModel *)model{
    
}

@end
