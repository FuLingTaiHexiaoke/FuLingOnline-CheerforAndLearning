//
//  FLXKSharingFuLingOnlineStyleCell.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKSharingFuLingOnlineStyleCelltest.h"
//utilites
#import "Masonry.h"
//child viewController
//subviews
#import "FLXKOneSharingPictureLayoutView.h"



@interface FLXKSharingFuLingOnlineStyleCelltest ()
//IBOutlet
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainSharingContentLabel;
@property (strong, nonatomic) IBOutlet FLXKBaseSharingPictureLayoutView *sharingImagesContainerView;
@property (weak, nonatomic) IBOutlet UIButton *locationRecordButton;
//@property (weak, nonatomic) IBOutlet UIImageView *sharingImageView;
//@property (weak, nonatomic) IBOutlet UIView *sharingMainOperationsContainerView;
//@property (weak, nonatomic) IBOutlet UIScrollView *likeTheSharingRecordScrollView;
//@property (weak, nonatomic) IBOutlet UIView *bottomSeparatorLineView;
//@property (weak, nonatomic) IBOutlet UITableView *sharingCommentsTableView;


//IBAction
//child viewController
//subviews
//models
//UI state record properties
@end


@implementation FLXKSharingFuLingOnlineStyleCelltest

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - Delegate
#pragma mark - Public methods

-(void)setSharingCellModel:(FLXKSharingCellModel *)model{
    [super setSharingCellModel:model];
    //     _sharingCellModel=sharingCellModel;
    self.avatarImageView.image=[UIImage imageNamed:model.avatarImageUrl];
    //        self.sharingImageView.image=[UIImage imageNamed:model.avatarImageUrl];
    self.nickNameLabel.text=model.avatarImageUrl;
    self.timestampLabel.text=model.avatarImageUrl;
    self.mainSharingContentLabel.text=model.avatarImageUrl;
    //    self.sharingImagesContainerView=[FLXKBaseSharingPictureLayoutView setupSharingPictureLayoutViewWithImageArray:@[@"Spark"]];
    [self.locationRecordButton setTitle:model.locationRecord forState:UIControlStateNormal];
    [self.locationRecordButton.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"_sharingImagesContainerView.constraints %lu,%@",(unsigned long)idx,obj);
    }];
    
    [self setupNewSharingImagesContainerViewWithImageArray:@[@"Spark"]];
    
    
}

#pragma mark - View Event
#pragma mark - Model Event
#pragma mark - Private methods
-(void)setupNewSharingImagesContainerViewWithImageArray:(NSArray<NSString*>*)imageArray{
    
    FLXKBaseSharingPictureLayoutView*  newView=   [FLXKBaseSharingPictureLayoutView setupSharingPictureLayoutViewWithImageArray:@[@"Spark"]];
    [self addSubview:newView];
    [newView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.locationRecordButton.mas_bottom).offset(8);
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom).offset(8);
        make.left.mas_equalTo(self.nickNameLabel.left);
    }];
    [self.sharingImagesContainerView removeFromSuperview];
    self.sharingImagesContainerView=newView;
}
#pragma mark - getter/setter
#pragma mark - Overriden methods

#pragma mark - Navigation
@end
