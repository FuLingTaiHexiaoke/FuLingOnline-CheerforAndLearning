//
//  FLXKSharingFuLingOnlineStyleCell.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKSharingFuLingOnlineStyleCellautolayouttest.h"

//utilites
#import "Masonry.h"
//child viewController
//subviews
#import "FLXKHeaderImageSharingLikeCollectionView.h"
#import "FuLingStyleMainOperationContainerView.h"



@interface FLXKSharingFuLingOnlineStyleCellautolayouttest ()
//IBOutlet
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UITextView *mainSharingContentLabel;
@property (weak, nonatomic) IBOutlet UIButton *sharingContentShowAllButton;
@property (strong, nonatomic) IBOutlet FLXKBaseSharingPictureLayoutView *sharingImagesContainerView;
@property (weak, nonatomic) IBOutlet UIButton *locationRecordButton;
@property (weak, nonatomic) IBOutlet UIView *sharingMainOperationsContainerView;

@property (weak, nonatomic) IBOutlet UIButton *thumberUpButton;


@property (weak, nonatomic) IBOutlet FLXKHeaderImageSharingLikeCollectionView *likeTheSharingRecordScrollView;
@property (weak, nonatomic) IBOutlet UIView *bottomSeparatorLineView;
@property (weak, nonatomic) IBOutlet FLXKBaseSharingCommentTableView *sharingCommentsTableView;


//IBAction

//点赞
//- (IBAction)sharingThumbup:(id)sender;

//评论

//分享

//child viewController
//subviews
//models
//UI state record properties
@end


@implementation FLXKSharingFuLingOnlineStyleCellautolayouttest

- (void)awakeFromNib {
    [super awakeFromNib];
    self.avatarImageView.layer.cornerRadius= self.avatarImageView.bounds.size.width/2;
    self.avatarImageView.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - Delegate
#pragma mark - Public methods
-(void)setmodel:(FLXKSharingCellModel *)model  WithIndexPath:(NSIndexPath *)indexPath{
    //    self.model=model;
    //    [self.sharingMainOperationsContainerView setModel:model WithIndexPath:indexPath];
}


-(void)setupNewSharingImagesContainerViewWithImageArray:(NSArray<FLXKSharingImagesModel*>*)imageArray{
    
    FLXKBaseSharingPictureLayoutView*  newView=[FLXKBaseSharingPictureLayoutView setupSharingPictureLayoutViewWithImageArray:imageArray];
    [self.contentView addSubview:newView];
        [self.sharingImagesContainerView removeFromSuperview];
        self.sharingImagesContainerView=newView;
    [newView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom).offset(8);
        make.bottom.mas_equalTo(self.locationRecordButton.mas_top).offset(-8);
        make.left.mas_equalTo(self.nickNameLabel.mas_left);
    }];

}

-(void)setupSharingCommentsTableViewWithCellModels{
    //get height
    CGFloat height= [self.sharingCommentsTableView setCellModels:[self setupSharingCommentCellModels]];
    [self.sharingCommentsTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
}

-(void)setupMainSharingContentLabel{
    CGSize size=  [self.mainSharingContentLabel sizeThatFits:CGSizeMake(self.mainSharingContentLabel.frame.size.width, INT_MAX)];
    [self.mainSharingContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height);
    }];
}

-(NSArray*)setupSharingCommentCellModels{
    NSMutableArray<SharingCommentCellModel*> * models=[NSMutableArray array];
    for (int i=0; i<3; i++) {
        SharingCommentCellModel* model=[[SharingCommentCellModel alloc]init];
        model.fromUserName=@"nickName";
        [models addObject:model];
    }
    return       [NSArray arrayWithArray:models];
}
#pragma mark - View Event
- (IBAction)sharingThumbup:(UIButton*)sender {
    if (self.model.isThumberuped==1) {
        [sender setImage:[UIImage imageNamed:@"sharing_thumbup_s"]  forState:UIControlStateNormal];
    }
    else{
        [sender setImage:[UIImage imageNamed:@"sharing_thumbup_n"]  forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:1.0 animations:^{
        sender.imageView.transform=CGAffineTransformScale(CGAffineTransformIdentity, 4, 4);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            sender.imageView.layer.affineTransform=CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
        }];
    }];
   [super addFriendsharingThumbup];
}
#pragma mark - Model Event
#pragma mark - Private methods
#pragma mark - getter/setter

-(void)setModel:(FLXKSharingCellModel *)model{
    [super setModel:model];
    //    self.avatarImageView.image=[UIImage imageNamed:model.avatarImageUrl];
    [self.avatarImageView sd_setImageWithURL:NSURL_BaseURL(model.avatarImageUrl) placeholderImage:[UIImage imageNamed:@"Spark"]];
    self.nickNameLabel.text=model.nickName;
    self.timestampLabel.text=model.timestamp;
    self.mainSharingContentLabel.text=model.mainSharingContent;
//        [self setupMainSharingContentLabel];
    //    [self setupNewSharingImagesContainerViewWithImageArray:(model.sharingImages.count>0?@[model.sharingImages[0]]:nil)];
    [self setupNewSharingImagesContainerViewWithImageArray:model.sharingImages];
    
    [self.likeTheSharingRecordScrollView setLikeTheSharingUserRecords:model.likeTheSharingUserRecords];

    [self.locationRecordButton setTitle:model.locationRecord forState:UIControlStateNormal];
    [self setupSharingCommentsTableViewWithCellModels];
    
    if (model.isThumberuped==1) {
        [self.thumberUpButton setImage:[UIImage imageNamed:@"sharing_thumbup_s"]  forState:UIControlStateNormal];
    }
    else{
        [self.thumberUpButton setImage:[UIImage imageNamed:@"sharing_thumbup_n"]  forState:UIControlStateNormal];
        
    }

    
}
#pragma mark - Overriden methods

#pragma mark - Navigation

@end
