//
//  FLXKBaseSharingPictureLayoutView.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKBaseSharingOperationContainerView.h"
//child views
#import "FLXKOneSharingPictureLayoutView.h"
#import "FLXKTwoSharingPictureLayoutView.h"

@implementation FLXKBaseSharingOperationContainerView


+(FLXKBaseSharingPictureLayoutView*)setupSharingPictureLayoutViewWithImageArray:(NSArray<FLXKSharingImagesModel*>*)imageArray{
    FLXKBaseSharingPictureLayoutView* pictureLayoutView;
    NSInteger imageCount=imageArray.count;
    switch (imageCount) {
        case 0:
            pictureLayoutView=nil;
            break;
//        case 1:
//            pictureLayoutView=[[FLXKOneSharingPictureLayoutView alloc]init];
//            break;
        default:
            pictureLayoutView=[[FLXKTwoSharingPictureLayoutView alloc]init];
            break;
    }
    
    [pictureLayoutView setImageArray:imageArray];
    
    return pictureLayoutView;
}

-(void)setImageArray:(NSArray<FLXKSharingImagesModel *> *)imageArray{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
