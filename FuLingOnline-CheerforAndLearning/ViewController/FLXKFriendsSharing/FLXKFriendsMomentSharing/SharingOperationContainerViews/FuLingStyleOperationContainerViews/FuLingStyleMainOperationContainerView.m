//
//  FuLingStyleMainOperationContainerView.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/17.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//
#pragma mark - Declarations and macros

#import "FuLingStyleMainOperationContainerView.h"

@interface FuLingStyleMainOperationContainerView ()
//IBOutlet
@property (weak, nonatomic) IBOutlet UIButton *thumberupThisNewsButton;

//IBAction
- (IBAction)broadcastThisNewsButtonAction:(UIButton *)sender;
- (IBAction)thumberupThisNewsButtonAction:(UIButton *)sender;
- (IBAction)CommentThisNewsButtonAction:(UIButton *)sender;

@end

@implementation FuLingStyleMainOperationContainerView

#pragma mark -  LifeCircle

- (instancetype)init {
    if ([super init]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"FuLingStyleMainOperationContainerView" owner:nil options:nil].lastObject;
    }
    return self;
}

#pragma mark - View Event
- (IBAction)addThumbupAction:(UIButton *)sender{
   __block UIButton* button=sender;
    if (self.addThumbupBlock) {
        self.addThumbupBlock(button);
    }
}

- (IBAction)addCommentRequestAction:(UIButton *)sender{
    if (self.addCommentRequestBlock) {
        self.addCommentRequestBlock();
    }
}

#pragma mark - getter/setter

-(void)setModel:(FLXKSharingCellModel *)model{
    if (model.isThumberuped==1) {
        [self.thumberupThisNewsButton setImage:[UIImage imageNamed:@"sharing_thumbup_s"]  forState:UIControlStateNormal];
    }
    else{
        [self.thumberupThisNewsButton setImage:[UIImage imageNamed:@"sharing_thumbup_n"]  forState:UIControlStateNormal];
    }
}

@end
