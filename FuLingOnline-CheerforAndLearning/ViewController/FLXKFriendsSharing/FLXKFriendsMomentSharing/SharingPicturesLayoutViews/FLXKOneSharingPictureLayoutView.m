//
//  FLXKOneSharingPictureLayoutView.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKOneSharingPictureLayoutView.h"
#import "UIImageView+WebCache.h"

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

-(void)setImageArray:(NSArray<FLXKSharingImagesModel *> *)imageArray{
    [imageArray enumerateObjectsUsingBlock:^(FLXKSharingImagesModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [( (UIImageView*)(_SharingImageViews[idx])) sd_setImageWithURL:NSURL_BaseURL(obj.thumbnailPictureUrl) placeholderImage:[UIImage imageNamed:@"Spark"]];
        
        [( (UIImageView*)(_SharingImageViews[idx]))  mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(obj.thumberImageWidth);
            make.height.mas_equalTo(obj.thumberImageHeight);
        }];
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
