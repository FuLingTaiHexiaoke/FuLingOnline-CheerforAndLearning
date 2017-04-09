//
//  FLXKSharingFuLingOnlineStyleCell.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKSharingFuLingOnlineStyleCell.h"
//utilites
#import "Masonry.h"
//child viewController
//subviews
#import "FLXKBaseSharingCommentTableView.h"


@interface FLXKSharingFuLingOnlineStyleCell ()
//IBOutlet
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UITextView *mainSharingContentLabel;
@property (weak, nonatomic) IBOutlet UIButton *sharingContentShowAllButton;
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


@implementation FLXKSharingFuLingOnlineStyleCell

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
    self.avatarImageView.image=[UIImage imageNamed:model.avatarImageUrl];
    self.nickNameLabel.text=model.nickName;
    self.timestampLabel.text=model.timestamp;
    self.mainSharingContentLabel.text=model.mainSharingContent;

    [self setupMainSharingContentLabel];


//    [self setupNewSharingImagesContainerViewWithImageArray:(model.sharingImages.count>0?@[model.sharingImages[0]]:nil)];
       [self setupNewSharingImagesContainerViewWithImageArray:model.sharingImages];
    [self.locationRecordButton setTitle:model.locationRecord forState:UIControlStateNormal];
    [self setupSharingCommentsTableViewWithCellModels];

}

-(void)setupNewSharingImagesContainerViewWithImageArray:(NSArray<FLXKSharingImagesModel*>*)imageArray{
    
    FLXKBaseSharingPictureLayoutView*  newView=[FLXKBaseSharingPictureLayoutView setupSharingPictureLayoutViewWithImageArray:imageArray];
    [self.contentView addSubview:newView];

    [newView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom).offset(8);
        make.bottom.mas_equalTo(self.locationRecordButton.mas_top).offset(-8);
        make.left.mas_equalTo(self.nickNameLabel.mas_left);
    }];
    [self.sharingImagesContainerView removeFromSuperview];
    self.sharingImagesContainerView=newView;
}

-(void)setupSharingCommentsTableViewWithCellModels{
    //get height
    CGFloat height= [self.sharingCommentsTableView setCellModels:[self setupSharingCommentCellModels]];
    [self.sharingCommentsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
}

-(void)setupMainSharingContentLabel{
CGSize size=  [self.mainSharingContentLabel sizeThatFits:CGSizeMake(self.mainSharingContentLabel.frame.size.width, INT_MAX)];
    [self.mainSharingContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height);
    }];
}

-(NSArray*)setupSharingCommentCellModels{
    NSMutableArray<SharingCommentCellModel*> * models=[NSMutableArray array];
    for (int i=0; i<10; i++) {
        SharingCommentCellModel* model=[[SharingCommentCellModel alloc]init];
        model.nickName=@"nickName";
        [models addObject:model];
    }
    return       [NSArray arrayWithArray:models];
}
#pragma mark - View Event
#pragma mark - Model Event
#pragma mark - Private methods
#pragma mark - getter/setter
#pragma mark - Overriden methods

#pragma mark - Navigation
@end
