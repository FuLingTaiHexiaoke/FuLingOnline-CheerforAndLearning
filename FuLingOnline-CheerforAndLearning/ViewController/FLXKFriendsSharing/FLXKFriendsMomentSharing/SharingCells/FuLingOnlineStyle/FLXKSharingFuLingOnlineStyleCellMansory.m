//
//  FLXKSharingFuLingOnlineStyleCell.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKSharingFuLingOnlineStyleCellMansory.h"

//utilites
#import "FriendsMomentSharingConfig.h"
#import "Masonry.h"
#import "NSString+Extensions.h"
#import "MLLinkLabel.h"

//subviews
#import "FLXKHeaderImageSharingLikeCollectionView.h"
#import "FuLingStyleMainOperationContainerView.h"
#import "FuLingStyleMainOperationContainerView.h"
#import "FLXKSharingPicturesShowingView.h"

#import "FLXKBaseCommentCell.h"


@interface FLXKSharingFuLingOnlineStyleCellMansory ()
//基础布局控件声明
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

//models
@property (strong, nonatomic)NSArray<SharingCommentCellModel *> *  models;

@end

@implementation FLXKSharingFuLingOnlineStyleCellMansory

#pragma mark - 初始化方法

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setupUI];
    }
    return self;
}

#pragma mark - 加载数据

-(void)setModel:(FLXKSharingCellModel *)model{
    [super setModel:model];

    [self.avatarImageView sd_setImageWithURL:NSURL_BaseURL(model.avatarImageUrl) placeholderImage:ImageNamed(@"Spack")];
    self.nickNameLabel.text=model.nickName;
    self.timestampLabel.text=model.timestamp;
    
     //mainSharingContentLabel

    if (self.model.mainSharingContent.length>0) {
        self.mainSharingContentLabel.attributedText=[NSAttributedString attributedStringWithPlainString: self.model.mainSharingContent];
        self.sharingContentShowAllButton.selected=model.isMainSharingContentLabelExpand;
        
        CGFloat width=[UIScreen mainScreen].bounds.size.width-avatarImageViewHeight;
        CGSize size=  [self.mainSharingContentLabel sizeThatFits:CGSizeMake(width, INT_MAX)];
        
        CGFloat height=model.isMainSharingContentLabelExpand?size.height:CONTENT_LABEL_DEFAULT_HEIGHT;
        
        [self.mainSharingContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.timestampLabel.mas_bottom).offset(DEFAULT_VIEW_SPACING);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-DEFAULT_VIEW_SPACING);
            make.left.mas_equalTo(self.avatarImageView.mas_right).offset(DEFAULT_VIEW_SPACING);
            make.height.mas_equalTo(height).priorityHigh();;
        }];
        
        if (size.height>CONTENT_LABEL_DEFAULT_HEIGHT)
        {
            self.sharingContentShowAllButton.hidden=NO;
            [self.sharingContentShowAllButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom);
                make.left.mas_equalTo(self.avatarImageView.mas_right).offset(DEFAULT_VIEW_SPACING);
            }];
        }
        else{
            self.sharingContentShowAllButton.hidden=YES;
            [self.sharingContentShowAllButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom);
                make.left.mas_equalTo(self.avatarImageView.mas_right).offset(DEFAULT_VIEW_SPACING);
                make.height.mas_equalTo(0).priorityHigh();
            }];
        }
    }
    //隐藏
    else{
        [self.mainSharingContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.timestampLabel.mas_bottom);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-DEFAULT_VIEW_SPACING);
            make.left.mas_equalTo(self.avatarImageView.mas_right).offset(DEFAULT_VIEW_SPACING);
            make.height.mas_equalTo(0).priorityHigh();;
        }];
        
        self.sharingContentShowAllButton.hidden=YES;
        [self.sharingContentShowAllButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom);
            make.left.mas_equalTo(self.avatarImageView.mas_right).offset(DEFAULT_VIEW_SPACING);
            make.height.mas_equalTo(0).priorityHigh();
        }];
    }
    
    //self.sharingImagesContainerView
    [self.sharingImagesContainerView setImageArray:model.sharingImages];
//    CGFloat height=  self.sharingImagesContainerView.viewHeight;
    [self.sharingImagesContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom).offset(model.sharingImages.count>0?DEFAULT_VIEW_SPACING:0);
        make.height.mas_equalTo(self.model.sharingImages_Height).priorityHigh();
    }];
    
    if ([model.locationRecord isEqualToString:@"显示位置"]||isEmptyString(model.locationRecord )){
        self.locationRecordButton.hidden=YES;
        [self.locationRecordButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.sharingImagesContainerView.mas_bottom);
            make.left.mas_equalTo(self.avatarImageView.mas_right).offset(DEFAULT_VIEW_SPACING);
            make.height.mas_equalTo(0);
        }];
    }
    else{
        self.locationRecordButton.hidden=NO;
        [self.locationRecordButton setTitle:model.locationRecord  forState:UIControlStateNormal];
        [self.locationRecordButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.sharingImagesContainerView.mas_bottom).offset(DEFAULT_VIEW_SPACING);
            make.left.mas_equalTo(self.avatarImageView.mas_right).offset(DEFAULT_VIEW_SPACING);
        }];
    }
    
    [self.sharingMainOperationsContainerView setModel:model];

    self.likeTheSharingRecordScrollView.alpha=1.0;
    [self.likeTheSharingRecordScrollView setLikeTheSharingUserRecords:model.likeTheSharingUserRecords];
    [self.likeTheSharingRecordScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sharingMainOperationsContainerView.mas_bottom).offset(model.likeTheSharingUserRecords.count>0?DEFAULT_VIEW_SPACING:0.0);
        make.height.mas_equalTo(model.likeTheSharingUserRecords.count>0?likeTheSharingRecordScrollViewHeight:0.0 ).priorityHigh();
    }];
    
    
    [self.bottomSeparatorLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.likeTheSharingRecordScrollView.mas_bottom).offset(model.sharingComments.count>0?DEFAULT_VIEW_SPACING:0.0);
        make.height.mas_equalTo(model.sharingComments.count>0?bottomSeparatorLineViewHeight:0.0).priorityHigh();
    }];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.sharingCommentsTableView setModels:model.sharingComments];
    });
    
    //   CGFloat  sharingCommentHeight=  [self.sharingCommentsTableView setCellModels:model.sharingComments];
    [self.sharingCommentsTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomSeparatorLineView.mas_bottom).offset(model.sharingImages.count>0?DEFAULT_VIEW_SPACING:0);
        make.height.mas_equalTo(model.sharingComments_Height).priorityHigh();
    }];
    if (model.sharingComments.count>0) {
        self.models=model.sharingComments;
        [self.sharingCommentsTableView reloadData];
    }
}


#pragma mark - Private methods
//点赞人数显示控件的动态显示和隐藏
-(void)showLikeTheSharingPeopleInfo{
    [super showLikeTheSharingPeopleInfo];
    self.likeTheSharingRecordScrollView.alpha=1.0;
    if (self.model.shouldShow_likeTheSharingUserRecords) {
        [UIView animateWithDuration:0.1 animations:^{
            self.likeTheSharingRecordScrollView.alpha=1.0;
        } completion:^(BOOL finished) {
            [self reloadCurrentCell];
        }];
    }
    else{
        [UIView animateWithDuration:0.1 animations:^{
            self.likeTheSharingRecordScrollView.alpha=0.0;
        } completion:^(BOOL finished) {
            [self reloadCurrentCell];
        }];
    }
    
}

//动态显示超长的文本信息
-(void)showAllSharingContentAction:(UIButton*)sender{
    self.model.isMainSharingContentLabelExpand=!self.model.isMainSharingContentLabelExpand;
    [self reloadCurrentCell];
}

#pragma mark - 初始化控件布局信息

-(void)setupUI{
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.contentView).offset(DEFAULT_VIEW_SPACING);
        make.height.mas_equalTo(self.avatarImageView.mas_width).multipliedBy(1);
        make.height.mas_equalTo(avatarImageViewHeight);
    }];
    _avatarImageView.layer.cornerRadius= avatarImageViewHeight/2;
    _avatarImageView.layer.masksToBounds=YES;
    
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarImageView.mas_top);
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(DEFAULT_VIEW_SPACING);
    }];
    
    [self.timestampLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.avatarImageView.mas_bottom);
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(DEFAULT_VIEW_SPACING);
    }];
    
    [self.mainSharingContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timestampLabel.mas_bottom).offset(DEFAULT_VIEW_SPACING);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-DEFAULT_VIEW_SPACING);
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(DEFAULT_VIEW_SPACING);
        make.height.mas_equalTo(0);
    }];
    
    
    [self.sharingContentShowAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom).offset(DEFAULT_VIEW_SPACING);
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(DEFAULT_VIEW_SPACING);
        make.height.mas_equalTo(0).priorityHigh();
    }];
    
    
    [self.sharingImagesContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom).offset(DEFAULT_VIEW_SPACING);
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(DEFAULT_VIEW_SPACING);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-DEFAULT_VIEW_SPACING);
        make.height.mas_equalTo(0).priorityHigh();
    }];
    
    [self.locationRecordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sharingImagesContainerView.mas_bottom).offset(DEFAULT_VIEW_SPACING);
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(DEFAULT_VIEW_SPACING);
    }];
    
    [self.sharingMainOperationsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.locationRecordButton.mas_bottom).offset(DEFAULT_VIEW_SPACING);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-DEFAULT_VIEW_SPACING);
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(DEFAULT_VIEW_SPACING);
        make.height.mas_equalTo(sharingMainOperationsContainerViewHeight).priorityHigh();
    }];
    //
    [self.likeTheSharingRecordScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sharingMainOperationsContainerView.mas_bottom).offset(DEFAULT_VIEW_SPACING);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-DEFAULT_VIEW_SPACING);
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(DEFAULT_VIEW_SPACING);
        make.height.mas_equalTo(likeTheSharingRecordScrollViewHeight).priorityHigh();
    }];
    
    [self.bottomSeparatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.likeTheSharingRecordScrollView.mas_bottom).offset(DEFAULT_VIEW_SPACING);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-DEFAULT_VIEW_SPACING);
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(DEFAULT_VIEW_SPACING);
        make.height.mas_equalTo(bottomSeparatorLineViewHeight).priorityHigh();
    }];
    //
    [self.sharingCommentsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomSeparatorLineView.mas_bottom).offset(DEFAULT_VIEW_SPACING);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-DEFAULT_VIEW_SPACING);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-DEFAULT_VIEW_SPACING);
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(DEFAULT_VIEW_SPACING);
        make.height.mas_equalTo(0).priorityHigh();
    }];
}


#pragma mark - 控件初始化

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
        _nickNameLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_timestampLabel];
    }
    return   _timestampLabel;
}

-( MLLinkLabel *)mainSharingContentLabel{
    if (!_mainSharingContentLabel) {
        _mainSharingContentLabel= [[MLLinkLabel alloc]init];
        _mainSharingContentLabel.numberOfLines=0;
        _mainSharingContentLabel.opaque=YES;
        _mainSharingContentLabel.layer.masksToBounds=YES;
        _mainSharingContentLabel.backgroundColor = [UIColor whiteColor];
        _mainSharingContentLabel.font = [UIFont systemFontOfSize:CONTENT_LABEL_FONT_SIZE];
        [self.contentView addSubview:_mainSharingContentLabel];
    }
    return   _mainSharingContentLabel;
}

-( UIButton *)sharingContentShowAllButton{
    if (!_sharingContentShowAllButton) {
        _sharingContentShowAllButton= [[UIButton alloc]init];
        
        [_sharingContentShowAllButton setTitle:@"全文" forState:UIControlStateNormal];
        [_sharingContentShowAllButton setTitle:@"收起" forState:UIControlStateSelected];
        [_sharingContentShowAllButton setTitleColor:CONTENT_SHOW_BUTTON_NORMAL_COLOR forState:UIControlStateNormal];
        [_sharingContentShowAllButton setTitleColor:CONTENT_SHOW_BUTTON_SELECTED_COLOR forState:UIControlStateSelected];
        
        _sharingContentShowAllButton.titleLabel.font = [UIFont systemFontOfSize:CONTENT_LABEL_FONT_SIZE];
        _sharingContentShowAllButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _sharingContentShowAllButton.selected = NO;
        [_sharingContentShowAllButton addTarget:self action:@selector(showAllSharingContentAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_sharingContentShowAllButton setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
        
        
        [self.contentView addSubview:_sharingContentShowAllButton];
    }
    return   _sharingContentShowAllButton;
}

-( FLXKBaseSharingPictureLayoutView *)sharingImagesContainerView{
    if (!_sharingImagesContainerView) {
        _sharingImagesContainerView= [[FLXKSharingPicturesShowingView alloc]init];
        [self.contentView addSubview:_sharingImagesContainerView];
    }
    return   _sharingImagesContainerView;
}

-( UIButton *)locationRecordButton{
    if (!_locationRecordButton) {
        _locationRecordButton= [[UIButton alloc]init];
        [self.contentView addSubview:_locationRecordButton];
        _locationRecordButton.titleLabel.font = [UIFont systemFontOfSize:LOCATION_BUTTON_FONT_SIZE];
        _locationRecordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_locationRecordButton setTitleColor:LOCATION_BUTTON_NORMAL_COLOR forState:UIControlStateNormal];
        [_locationRecordButton setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    }
    return   _locationRecordButton;
}

-( FuLingStyleMainOperationContainerView *)sharingMainOperationsContainerView{
    if (!_sharingMainOperationsContainerView) {
        _sharingMainOperationsContainerView= [[FuLingStyleMainOperationContainerView alloc]init];
        _sharingMainOperationsContainerView.addThumbupBlock=^(UIButton* sender){
            [super addThumbup:sender];
        };
        _sharingMainOperationsContainerView.addCommentRequestBlock=^(UIView* tapedView){
            [super addCommentRequest:tapedView];
        };
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
        _bottomSeparatorLineView.backgroundColor=[UIColor lightGrayColor];
        [self.contentView addSubview:_bottomSeparatorLineView];
    }
    return   _bottomSeparatorLineView;
}

-( FLXKBaseSharingCommentTableView *)sharingCommentsTableView{
    if (!_sharingCommentsTableView) {
        _sharingCommentsTableView= [[FLXKBaseSharingCommentTableView alloc]init];
        __weak __typeof(self) weakSelf=self;
        _sharingCommentsTableView.addCommentRequsetBlock=^(SharingCommentCellModel* model,UIView* tapedView){
            weakSelf.currentCommentCellModel=model;
            if ( weakSelf.addCommentBlock) {
                weakSelf.addCommentBlock([NSString stringWithFormat:@"回复:%@",model.toUserName],model,tapedView,weakSelf.indexPath);
            }
        };
        [self.contentView addSubview:_sharingCommentsTableView];
    }
    return   _sharingCommentsTableView;
}


@end
