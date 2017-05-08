//
//  FLXKSharingFuLingOnlineStyleCell.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//
//文本展开
//样式设置和调整
#pragma mark - Declarations and macros
#define avatarImageViewHeight 46
#define contentLabelFontSize 14
#define contentLabelDefaultHeight 60
#import "FLXKSharingFuLingOnlineStyleCell.h"

//utilites
#import "Masonry.h"
#import "NSString+Extensions.h"
#import "MLLinkLabel.h"
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
@property (strong, nonatomic)  MLLinkLabel *mainSharingContentLabel;
@property (strong, nonatomic)  UIButton *sharingContentShowAllButton;
@property (strong, nonatomic)  FLXKBaseSharingPictureLayoutView *sharingImagesContainerView;
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
@property (assign, nonatomic)BOOL isMainSharingContentLabelExpand;
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
        self.sharingContentShowAllButton.selected=model.isMainSharingContentLabelExpand;

        [self.mainSharingContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.timestampLabel.mas_bottom).offset(8);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
        }];
        CGFloat width=[UIScreen mainScreen].bounds.size.width-46;
        CGSize size=  [self.mainSharingContentLabel sizeThatFits:CGSizeMake(width, INT_MAX)];
//        if (size.height>FBTweakValue(@"FuLingOnlineStyleCell", @"setupMainSharingContentLabel",  @"size.height", 30.0))
          if (size.height>contentLabelDefaultHeight)
        {
            model.shouldShowSharingContentShowAllButton=YES;
            [self.sharingContentShowAllButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom);
                make.left.mas_equalTo(self.avatarImageView.mas_right);            }];
        }
        else{
            model.shouldShowSharingContentShowAllButton=NO;
            [_sharingContentShowAllButton setTitle:@"" forState:UIControlStateNormal];
            [self.sharingContentShowAllButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom);
                make.left.mas_equalTo(self.avatarImageView.mas_right);
                make.height.mas_equalTo(0).priorityHigh();
                //                make.bottom.mas_equalTo(self.contentView.mas_bottom);
            }];
        }
        self.sharingContentShowAllButton.hidden=!model.shouldShowSharingContentShowAllButton;
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
        [self.sharingContentShowAllButton mas_updateConstraints:^(MASConstraintMaker *make) {
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
        _nickNameLabel= [[MLLabel alloc]init];
        _nickNameLabel.font = [UIFont systemFontOfSize:14];
        _nickNameLabel.textColor = [UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9];
        [self.contentView addSubview:_nickNameLabel];
    }
    return   _nickNameLabel;
}

-( UILabel *)timestampLabel{
    if (!_timestampLabel) {
        _timestampLabel= [[UILabel alloc]init];
        _nickNameLabel.font = [UIFont systemFontOfSize:14];
        _nickNameLabel.textColor = [UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9];
        [self.contentView addSubview:_timestampLabel];
    }
    return   _timestampLabel;
}

-( MLLinkLabel *)mainSharingContentLabel{
    if (!_mainSharingContentLabel) {
        _mainSharingContentLabel= [[MLLinkLabel alloc]init];
        _mainSharingContentLabel.numberOfLines=0;
        _mainSharingContentLabel.font = [UIFont systemFontOfSize:contentLabelFontSize];
        [self.contentView addSubview:_mainSharingContentLabel];
    }
    return   _mainSharingContentLabel;
}

-( UIButton *)sharingContentShowAllButton{
    if (!_sharingContentShowAllButton) {
        _sharingContentShowAllButton= [[UIButton alloc]init];

        [_sharingContentShowAllButton setTitle:@"全文" forState:UIControlStateNormal];
        [_sharingContentShowAllButton setTitle:@"收起" forState:UIControlStateSelected];
        [_sharingContentShowAllButton setTitleColor:[UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_sharingContentShowAllButton setTitleColor:[UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0] forState:UIControlStateSelected];

        _sharingContentShowAllButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _sharingContentShowAllButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _sharingContentShowAllButton.selected = NO;
        [_sharingContentShowAllButton addTarget:self action:@selector(showAllSharingContentAction:) forControlEvents:UIControlEventTouchUpInside];

        [self.contentView addSubview:_sharingContentShowAllButton];
    }
    return   _sharingContentShowAllButton;
}

-( FLXKBaseSharingPictureLayoutView *)sharingImagesContainerView{
    if (!_sharingImagesContainerView) {
        _sharingImagesContainerView= [[FLXKBaseSharingPictureLayoutView alloc]init];
        [self.contentView addSubview:_sharingImagesContainerView];
    }
    return   _sharingImagesContainerView;
}

//-( FLXKTwoSharingPictureLayoutView *)sharingImagesContainerView{
//    if (!_sharingImagesContainerView) {
//        _sharingImagesContainerView= [[FLXKTwoSharingPictureLayoutView alloc]init];
//        [self.contentView addSubview:_sharingImagesContainerView];
//        //        _sharingImagesContainerView.translatesAutoresizingMaskIntoConstraints=NO;
//    }
//    return   _sharingImagesContainerView;
//}

-( UIButton *)locationRecordButton{
    if (!_locationRecordButton) {
        _locationRecordButton= [[UIButton alloc]init];
        [self.contentView addSubview:_locationRecordButton];
        _locationRecordButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _locationRecordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_locationRecordButton setTitleColor:[UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0] forState:UIControlStateNormal];
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
-(void)showAllSharingContentAction:(UIButton*)sender{
    CGFloat width=SCREEN_WIDTH - avatarImageViewHeight;
    CGSize size=  [self.mainSharingContentLabel sizeThatFits:CGSizeMake(width, INT_MAX)];
    self.model.isMainSharingContentLabelExpand=!self.model.isMainSharingContentLabelExpand;
    BOOL isExpanded=sender.selected;
    sender.selected=!isExpanded;
    CGFloat height=isExpanded?contentLabelDefaultHeight:size.height;
    [self.mainSharingContentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height).priorityHigh();
    }];

}
-(void)setupUI{

    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.avatarImageView.mas_width).multipliedBy(1);
        make.height.mas_equalTo(avatarImageViewHeight);
        //                make.bottom.mas_equalTo(self.mas_bottom);
    }];
    _avatarImageView.layer.cornerRadius= avatarImageViewHeight/2;
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
        make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom);
        make.left.mas_equalTo(self.avatarImageView.mas_right);
        make.height.mas_equalTo(0).priorityHigh();
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
