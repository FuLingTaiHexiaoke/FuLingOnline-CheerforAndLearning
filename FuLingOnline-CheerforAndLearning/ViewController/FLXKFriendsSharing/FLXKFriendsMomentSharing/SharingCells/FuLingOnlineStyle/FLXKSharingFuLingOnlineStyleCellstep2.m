//
//  FLXKSharingFuLingOnlineStyleCell.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKSharingFuLingOnlineStyleCellstep2.h"
//utilites
#import "Masonry.h"
//child viewController
//subviews
#import "FLXKBaseSharingCommentTableView.h"

@interface FLXKSharingFuLingOnlineStyleCellstep2 ()<UITableViewDataSource,UITableViewDelegate>
//IBOutlet
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainSharingContentLabel;
@property (strong, nonatomic) IBOutlet FLXKBaseSharingPictureLayoutView *sharingImagesContainerView;
@property (weak, nonatomic) IBOutlet UIButton *locationRecordButton;
@property (weak, nonatomic) IBOutlet UIView *sharingMainOperationsContainerView;
@property (weak, nonatomic) IBOutlet UIScrollView *likeTheSharingRecordScrollView;
@property (weak, nonatomic) IBOutlet UIView *bottomSeparatorLineView;
@property (weak, nonatomic) IBOutlet FLXKBaseSharingCommentTableView *sharingCommentsTableView;
//IBAction
//child viewController
//subviews
//models
//UI state record properties
@end


@implementation FLXKSharingFuLingOnlineStyleCellstep2

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Delegate
#pragma mark - Public methods

-(void)setSharingCellModel:(FLXKSharingCellModel *)model{
    [super setSharingCellModel:model];
    self.avatarImageView.image=[UIImage imageNamed:model.avatarImageUrl];
    self.nickNameLabel.text=model.avatarImageUrl;
    self.timestampLabel.text=model.avatarImageUrl;
    self.mainSharingContentLabel.text=model.avatarImageUrl;
    [self setupNewSharingImagesContainerViewWithImageArray:@[@"Spark"]];
    [self.locationRecordButton setTitle:model.locationRecord forState:UIControlStateNormal];
    [self.sharingCommentsTableView setModels:@[@"Spark",@"Spark",@"Spark",@"Spark",@"Spark",@"Spark",@"Spark",@"Spark",@"Spark"]];
}

-(void)setupNewSharingImagesContainerViewWithImageArray:(NSArray<NSString*>*)imageArray{
    
    FLXKBaseSharingPictureLayoutView*  newView=   [FLXKBaseSharingPictureLayoutView setupSharingPictureLayoutViewWithImageArray:@[@"Spark"]];
    [self.contentView addSubview:newView];
    [newView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom).offset(8);
        make.bottom.mas_equalTo(self.locationRecordButton.mas_top).offset(-8);
        make.left.mas_equalTo(self.nickNameLabel.mas_left);
    }];
    [self.sharingImagesContainerView removeFromSuperview];
    self.sharingImagesContainerView=newView;
}


#pragma mark - View Event
#pragma mark - Model Event
#pragma mark - Private methods
#pragma mark - getter/setter
#pragma mark - Overriden methods

#pragma mark - Navigation
@end
