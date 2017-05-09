//
//  FuLingStyleMainOperationContainerView.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/17.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//
#pragma mark - Declarations and macros

#import "FuLingStyleMainOperationContainerView.h"
//utilites
//child viewController
//models
//subviews
@interface FuLingStyleMainOperationContainerView ()
//IBOutlet
@property (weak, nonatomic) IBOutlet UIButton *thumberupThisNewsButton;

//IBAction
- (IBAction)broadcastThisNewsButtonAction:(UIButton *)sender;
- (IBAction)thumberupThisNewsButtonAction:(UIButton *)sender;
- (IBAction)CommentThisNewsButtonAction:(UIButton *)sender;
//models
//UI state record properties
//subviews
//child viewController
@end

@implementation FuLingStyleMainOperationContainerView

#pragma mark -  LifeCircle

- (instancetype)init {
    if ([super init]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"FuLingStyleMainOperationContainerView" owner:nil options:nil].lastObject;
    }
    return self;
}

//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if ([super initWithCoder:aDecoder]) {
//        self = [[NSBundle mainBundle] loadNibNamed:@"FuLingStyleMainOperationContainerView" owner:nil options:nil].lastObject;
//    }
//    return self;
//}

//-(void)dealloc{
//    NSLog(@"%@ 销毁",NSStringFromClass(self.class));
//}
//


#pragma mark - Delegate
#pragma mark - Public methods
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

#pragma mark - Model Event
#pragma mark - Private methods
#pragma mark - getter/setter
//-(void)setModel:(FLXKSharingCellModel *)model WithIndexPath:(NSIndexPath*)indexPath{
//    [super setModel:model WithIndexPath:indexPath];
//    if (model.isThumberuped==1) {
//        [self.thumberupThisNewsButton setImage:[UIImage imageNamed:@"sharing_thumbup_s"]  forState:UIControlStateNormal];
//    }
//    else{
//        [self.thumberupThisNewsButton setImage:[UIImage imageNamed:@"sharing_thumbup_n"]  forState:UIControlStateNormal];
//    }
//}
-(void)setModel:(FLXKSharingCellModel *)model{
    if (model.isThumberuped==1) {
        [self.thumberupThisNewsButton setImage:[UIImage imageNamed:@"sharing_thumbup_s"]  forState:UIControlStateNormal];
    }
    else{
        [self.thumberupThisNewsButton setImage:[UIImage imageNamed:@"sharing_thumbup_n"]  forState:UIControlStateNormal];
    }
}
#pragma mark - Overriden methods

#pragma mark - Navigation

@end
