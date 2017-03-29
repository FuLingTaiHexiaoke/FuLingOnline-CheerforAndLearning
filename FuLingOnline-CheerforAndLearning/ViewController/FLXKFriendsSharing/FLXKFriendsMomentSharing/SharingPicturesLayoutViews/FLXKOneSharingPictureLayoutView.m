//
//  FLXKOneSharingPictureLayoutView.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKOneSharingPictureLayoutView.h"

@interface FLXKOneSharingPictureLayoutView ()
//IBOutlet
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray<UIImageView*> *SharingImageViews;

//IBAction
//child viewController
//subviews
//models
//UI state record properties
@end

@implementation FLXKOneSharingPictureLayoutView

- (instancetype)init {
    if ([super init]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"FLXKOneSharingPictureLayoutView" owner:nil options:nil].lastObject;
    }
    return self;
}

-(void)setImageArray:(NSArray<NSString *> *)imageArray{
    [imageArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        _SharingImageViews[idx].image=[UIImage imageNamed:obj];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
