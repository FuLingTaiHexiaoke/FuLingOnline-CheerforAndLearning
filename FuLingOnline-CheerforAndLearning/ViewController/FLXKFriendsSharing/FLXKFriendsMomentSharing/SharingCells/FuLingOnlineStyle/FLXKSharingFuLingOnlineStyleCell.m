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
#import "NSString+Extensions.h"
//#import "JHChainableAnimations.h"
//child viewController
//subviews
#import "FLXKHeaderImageSharingLikeCollectionView.h"
#import "FuLingStyleMainOperationContainerView.h"
#import "FuLingStyleMainOperationContainerView.h"
#import "FLXKTwoSharingPictureLayoutView.h"

@interface FLXKSharingFuLingOnlineStyleCell ()

@property (strong, nonatomic)  UIImageView *avatarImageView;
@property (strong, nonatomic)  UILabel *nickNameLabel;
@property (strong, nonatomic)  UILabel *timestampLabel;
@property (strong, nonatomic)  UITextView *mainSharingContentLabel;
@property (strong, nonatomic)  UIButton *sharingContentShowAllButton;
@property (strong, nonatomic)  FLXKTwoSharingPictureLayoutView *sharingImagesContainerView;
@property (strong, nonatomic)  UIButton *locationRecordButton;
@property (strong, nonatomic)  FuLingStyleMainOperationContainerView *sharingMainOperationsContainerView;

@property (strong, nonatomic)  UIButton *thumberUpButton;


@property (strong, nonatomic)  FLXKHeaderImageSharingLikeCollectionView *likeTheSharingRecordScrollView;
@property (strong, nonatomic)  UIView *bottomSeparatorLineView;
@property (strong, nonatomic)  FLXKBaseSharingCommentTableView *sharingCommentsTableView;

//IBOutlet Constraints

//IBAction


//child viewController
//subviews
//models
//UI state record properties
@end

@implementation FLXKSharingFuLingOnlineStyleCell

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
            [self setupUI];
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - Delegate
#pragma mark - Public methods
-(void)setSharingCellModel:(FLXKSharingCellModel *)model  WithIndexPath:(NSIndexPath *)indexPath{

}


-(void)setupNewSharingImagesContainerViewWithImageArray:(NSArray<FLXKSharingImagesModel*>*)imageArray{

}

-(void)setupLocationRecordButtonWithLocation:(NSString*)location{

}


-(void)setupSharingCommentsTableViewWithCellModels:(NSArray<SharingCommentCellModel*>*)models{
    //get height
    CGFloat height= [self.sharingCommentsTableView setCellModels:models];
    [self.sharingCommentsTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
    __weak __typeof(self) weakSelf=self;
    self.sharingCommentsTableView.addCommentRequsetBlock=^(SharingCommentCellModel* model){
        weakSelf.currentCommentCellModel=model;
        if ( weakSelf.addCommentRequestBlock) {
            weakSelf.addCommentRequestBlock([NSString stringWithFormat:@"回复:%@",model.toUserName],weakSelf);
        }
    };
}


////评论
//-(void)addFriendsharingComment:(NSDictionary*)parameters{
//    [super addFriendsharingComment:parameters];
//}

#pragma mark - View Event
- (IBAction)addThumbup:(UIButton*)sender {
    [super addThumbup:sender];
}

- (IBAction)addCommentRequest:(UIButton*)sender {
    [super addCommentRequest];
}

#pragma mark - Model Event



#pragma mark - getter/setter

-(void)setModel:(FLXKSharingCellModel *)model{
    [super setModel:model];
    
    [self.avatarImageView sd_setImageWithURL:NSURL_BaseURL(model.avatarImageUrl) placeholderImage:[UIImage imageNamed:@"Spark"]];
    self.nickNameLabel.text=model.nickName;
    self.timestampLabel.text=model.timestamp;

    self.mainSharingContentLabel.attributedText=[NSAttributedString attributedStringWithPlainString: self.model.mainSharingContent];
    if (self.model.mainSharingContent.length>0) {
        [self.mainSharingContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.timestampLabel.mas_bottom).offset(8);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
        }];
        CGFloat width=[UIScreen mainScreen].bounds.size.width-46;
        CGSize size=  [self.mainSharingContentLabel sizeThatFits:CGSizeMake(width, INT_MAX)];
        if (size.height>FBTweakValue(@"FuLingOnlineStyleCell", @"setupMainSharingContentLabel",  @"size.height", 30.0)) {
            self.sharingContentShowAllButton.hidden=NO;
            [_sharingContentShowAllButton setTitle:@"展开" forState:UIControlStateNormal];
            [self.sharingContentShowAllButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom).offset(8);
                make.left.mas_equalTo(self.avatarImageView.mas_right);
                //                make.bottom.mas_equalTo(self.contentView.mas_bottom);
            }];
        }
        else{
            self.sharingContentShowAllButton.hidden=YES;
            [_sharingContentShowAllButton setTitle:@"" forState:UIControlStateNormal];
            [self.sharingContentShowAllButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom);
                make.left.mas_equalTo(self.avatarImageView.mas_right);
                make.height.mas_equalTo(0).priorityHigh();
                //                make.bottom.mas_equalTo(self.contentView.mas_bottom);
            }];
        }
    }
    else{
        //        self.mainSharingContentLabel.attributedText=[NSAttributedString attributedStringWithPlainString: self.model.mainSharingContent];
        [self.mainSharingContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.timestampLabel.mas_bottom);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
            make.height.mas_equalTo(0).priorityHigh();
        }];
        self.sharingContentShowAllButton.hidden=YES;
        [_sharingContentShowAllButton setTitle:@"" forState:UIControlStateNormal];
        [self.sharingContentShowAllButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
            make.height.mas_equalTo(0).priorityHigh();
            //            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
    }
    
    [self.sharingImagesContainerView setImageArray:model.sharingImages];
    CGFloat height=  self.sharingImagesContainerView.viewHeight;
    [self.sharingImagesContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom).offset(8);
        make.left.mas_equalTo(self.avatarImageView.mas_right);
        make.height.mas_equalTo(height).priorityHigh();
    }];
    
    
    if ([model.locationRecord isEqualToString:@"显示位置"]||isEmptyString(model.locationRecord )) {
        self.locationRecordButton.hidden=YES;
        [self.locationRecordButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.sharingImagesContainerView.mas_bottom);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
            make.height.mas_equalTo(0);
        }];
    }
    else{
          self.locationRecordButton.hidden=NO;
        [self.locationRecordButton setTitle:model.locationRecord  forState:UIControlStateNormal];
        [self.locationRecordButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.sharingImagesContainerView.mas_bottom).offset(8);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
        }];
    }
    
    
    
    [self.sharingMainOperationsContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.locationRecordButton.mas_bottom).offset(8);
        make.right.mas_equalTo(self.mas_right).offset(-8);
        make.left.mas_equalTo(self.avatarImageView.mas_right);
        make.height.mas_equalTo(44.0);
    }];
    
    if ( model.likeTheSharingUserRecords.count>0) {
        [self.likeTheSharingRecordScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.sharingMainOperationsContainerView.mas_bottom).offset(8);
            make.right.mas_equalTo(self.mas_right).offset(-8);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
            make.height.mas_equalTo(44.0).priorityHigh();
        }];
    }
    else{
        [self.likeTheSharingRecordScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.sharingMainOperationsContainerView.mas_bottom);
            make.right.mas_equalTo(self.mas_right);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
            make.height.mas_equalTo(0).priorityHigh();
        }];
    }
 
    if ( model.sharingComments.count>0) {
        [self.bottomSeparatorLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.likeTheSharingRecordScrollView.mas_bottom).offset(8);
            make.right.mas_equalTo(self.mas_right).offset(-8);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
            make.height.mas_equalTo(1.0).priorityHigh();
        }];
    }
    else{
        [self.bottomSeparatorLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.likeTheSharingRecordScrollView.mas_bottom);
            make.right.mas_equalTo(self.mas_right).offset(-8);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
            make.height.mas_equalTo(0.0).priorityHigh();
        }];
    }
    
    if ( model.sharingComments.count>0) {
        CGFloat height= [self.sharingCommentsTableView setCellModels:model.sharingComments];
        [self.sharingCommentsTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bottomSeparatorLineView.mas_bottom).offset(8);
            make.right.mas_equalTo(self.mas_right).offset(-8);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-8);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
            make.height.mas_equalTo(height).priorityHigh();
        }];
        
    }
    else{
        [self.sharingCommentsTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bottomSeparatorLineView.mas_bottom);
            make.right.mas_equalTo(self.mas_right).offset(-8);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
            make.height.mas_equalTo(0.0).priorityHigh();
        }];
    }
    
}


-( UIImageView *)avatarImageView{
    if (!_avatarImageView) {
        _avatarImageView= [[UIImageView alloc]init];
        [self.contentView addSubview:_avatarImageView];
    }
    return   _avatarImageView;
}

-( UILabel *)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel= [[UILabel alloc]init];
        [self.contentView addSubview:_nickNameLabel];
    }
    return   _nickNameLabel;
}

-( UILabel *)timestampLabel{
    if (!_timestampLabel) {
        _timestampLabel= [[UILabel alloc]init];
        [self.contentView addSubview:_timestampLabel];
    }
    return   _timestampLabel;
}

-( UITextView *)mainSharingContentLabel{
    if (!_mainSharingContentLabel) {
        _mainSharingContentLabel= [[UITextView alloc]init];
        _mainSharingContentLabel.scrollEnabled=NO;
        [self.contentView addSubview:_mainSharingContentLabel];
    }
    return   _mainSharingContentLabel;
}

-( UIButton *)sharingContentShowAllButton{
    if (!_sharingContentShowAllButton) {
        _sharingContentShowAllButton= [[UIButton alloc]init];
        [_sharingContentShowAllButton setTitle:@"展开" forState:UIControlStateNormal];
        [self.contentView addSubview:_sharingContentShowAllButton];
    }
    return   _sharingContentShowAllButton;
}

//-( FLXKBaseSharingPictureLayoutView *)sharingImagesContainerView{
//    if (!_sharingImagesContainerView) {
//        _sharingImagesContainerView= [[FLXKBaseSharingPictureLayoutView alloc]init];
//        [self.contentView addSubview:_sharingImagesContainerView];
//    }
//    return   _sharingImagesContainerView;
//}
-( FLXKTwoSharingPictureLayoutView *)sharingImagesContainerView{
    if (!_sharingImagesContainerView) {
        _sharingImagesContainerView= [[FLXKTwoSharingPictureLayoutView alloc]init];
        [self.contentView addSubview:_sharingImagesContainerView];
        //        _sharingImagesContainerView.translatesAutoresizingMaskIntoConstraints=NO;
    }
    return   _sharingImagesContainerView;
}

-( UIButton *)locationRecordButton{
    if (!_locationRecordButton) {
        _locationRecordButton= [[UIButton alloc]init];
        [self.contentView addSubview:_locationRecordButton];
        
    }
    return   _locationRecordButton;
}

-( FuLingStyleMainOperationContainerView *)sharingMainOperationsContainerView{
    if (!_sharingMainOperationsContainerView) {
        _sharingMainOperationsContainerView= [[FuLingStyleMainOperationContainerView alloc]init];
        [self.contentView addSubview:_sharingMainOperationsContainerView];
    }
    return   _sharingMainOperationsContainerView;
}

-( FLXKHeaderImageSharingLikeCollectionView *)likeTheSharingRecordScrollView{
    if (!_likeTheSharingRecordScrollView) {
        _likeTheSharingRecordScrollView= [[FLXKHeaderImageSharingLikeCollectionView alloc]init];
        [self.contentView addSubview:_likeTheSharingRecordScrollView];
    }
    return   _likeTheSharingRecordScrollView;
}

-( UIView *)bottomSeparatorLineView{
    if (!_bottomSeparatorLineView) {
        _bottomSeparatorLineView= [[UIView alloc]init];
        [self.contentView addSubview:_bottomSeparatorLineView];
    }
    return   _bottomSeparatorLineView;
}

-( FLXKBaseSharingCommentTableView *)sharingCommentsTableView{
    if (!_sharingCommentsTableView) {
        _sharingCommentsTableView= [[FLXKBaseSharingCommentTableView alloc]init];
        [self.contentView addSubview:_sharingCommentsTableView];
    }
    return   _sharingCommentsTableView;
}


#pragma mark - Private methods

-(void)setupUI{
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.avatarImageView.mas_width).multipliedBy(1);
        make.height.mas_equalTo(46);
        //                make.bottom.mas_equalTo(self.mas_bottom);
    }];
    _avatarImageView.layer.cornerRadius= 46/2;
    _avatarImageView.layer.masksToBounds=YES;
    
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarImageView.mas_top);
        make.left.mas_equalTo(self.avatarImageView.mas_right);
    }];
    
    [self.timestampLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.avatarImageView.mas_bottom);
        make.left.mas_equalTo(self.avatarImageView.mas_right);
    }];
    
    [self.mainSharingContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timestampLabel.mas_bottom).offset(8);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
        make.left.mas_equalTo(self.avatarImageView.mas_right);
    }];
    
    
    [self.sharingContentShowAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom).offset(8);
        make.left.mas_equalTo(self.avatarImageView.mas_right);
    }];
    
    
    [self.sharingImagesContainerView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom).offset(8);
        make.left.mas_equalTo(self.avatarImageView.mas_right);
    }];
    
    [self.locationRecordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sharingImagesContainerView.mas_bottom).offset(8);
        make.left.mas_equalTo(self.avatarImageView.mas_right);
    }];
    
    [self.sharingMainOperationsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.locationRecordButton.mas_bottom).offset(8);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
        make.left.mas_equalTo(self.avatarImageView.mas_right);
        make.height.mas_equalTo(44.0).priorityHigh();
    }];
    
    
    [self.likeTheSharingRecordScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sharingMainOperationsContainerView.mas_bottom).offset(8);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
        make.left.mas_equalTo(self.avatarImageView.mas_right);
        make.height.mas_equalTo(44.0).priorityHigh();
    }];
    
    [self.bottomSeparatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.likeTheSharingRecordScrollView.mas_bottom).offset(8);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
        make.left.mas_equalTo(self.avatarImageView.mas_right);
        make.height.mas_equalTo(1.0).priorityHigh();
    }];
    
    [self.sharingCommentsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomSeparatorLineView.mas_bottom).offset(8);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-8);
        make.left.mas_equalTo(self.avatarImageView.mas_right);
        make.height.mas_equalTo(0).priorityHigh();
    }];
}

-(void)setMainSharingContentLabelText:(NSString*)string{
    self.mainSharingContentLabel.text=string;
    CGFloat height=  [string getBoundingHeightWithWidth:self.mainSharingContentLabel.width font:self.mainSharingContentLabel.font];
    if (height>content_default_height) {
        self.sharingContentShowAllButton.hidden=NO;
    }
    else{
        self.sharingContentShowAllButton.hidden=YES;
    }
    
}
#pragma mark - Overriden methods

#pragma mark - Navigation

@end
