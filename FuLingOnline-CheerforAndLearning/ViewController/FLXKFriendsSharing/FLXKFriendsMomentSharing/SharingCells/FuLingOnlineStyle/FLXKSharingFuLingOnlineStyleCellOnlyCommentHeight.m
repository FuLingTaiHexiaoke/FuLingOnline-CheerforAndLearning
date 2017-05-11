//
//  FLXKSharingFuLingOnlineStyleCell.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#pragma mark - Declarations and macros


#import "FLXKSharingFuLingOnlineStyleCellOnlyCommentHeight.h"

//utilites
#import "FriendsMomentSharingConfig.h"
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

#import "FLXKBaseCommentCell.h"


@interface FLXKSharingFuLingOnlineStyleCellOnlyCommentHeight ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)  UIImageView *avatarImageView;
@property (strong, nonatomic)  UILabel *nickNameLabel;
@property (strong, nonatomic)  UILabel *timestampLabel;
@property (strong, nonatomic)  MLLinkLabel *mainSharingContentLabel;
@property (strong, nonatomic)  UIButton *sharingContentShowAllButton;
@property (strong, nonatomic)  FLXKTwoSharingPictureLayoutView *sharingImagesContainerView;
@property (strong, nonatomic)  UIButton *locationRecordButton;
@property (strong, nonatomic)  FuLingStyleMainOperationContainerView *sharingMainOperationsContainerView;

@property (strong, nonatomic)  UIButton *thumberUpButton;


@property (strong, nonatomic)  FLXKHeaderImageSharingLikeCollectionView *likeTheSharingRecordScrollView;
@property (strong, nonatomic)  UIView *bottomSeparatorLineView;
//@property (strong, nonatomic)  FLXKBaseSharingCommentTableView *sharingCommentsTableView;
@property (strong, nonatomic)  FLXKBaseSharingCommentTableView *sharingCommentsTableView;

//IBOutlet Constraints

//IBAction


//child viewController
//subviews
//models
@property (strong, nonatomic)NSArray<SharingCommentCellModel *> *  models;
//UI state record properties
@property (assign, nonatomic)BOOL isMainSharingContentLabelExpand;
@end

@implementation FLXKSharingFuLingOnlineStyleCellOnlyCommentHeight

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

#pragma mark - Delegate
#pragma mark - Public methods

//
//-(void)setupSharingCommentsTableViewWithCellModels:(NSArray<SharingCommentCellModel*>*)models{
//    //get height
//    CGFloat height= [self.sharingCommentsTableView setCellModels:models];
//    [self.sharingCommentsTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(height);
//    }];
//    
//    __weak __typeof(self) weakSelf=self;
//    self.sharingCommentsTableView.addCommentRequsetBlock=^(SharingCommentCellModel* model){
//        weakSelf.currentCommentCellModel=model;
//        if ( weakSelf.addCommentRequestBlock) {
//            weakSelf.addCommentRequestBlock([NSString stringWithFormat:@"回复:%@",model.toUserName],weakSelf);
//        }
//    };
//}


#pragma mark - View Event

#pragma mark - Model Event



#pragma mark - getter/setter

-(void)setModel:(FLXKSharingCellModel *)model{
    [super setModel:model];

    [self.sharingImagesContainerView setImageArray:model.sharingImages];
    CGFloat height=  self.sharingImagesContainerView.viewHeight;
    [self.sharingImagesContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom).offset(model.sharingImages.count>0?DEFAULT_VIEW_SPACING:0);
        make.height.mas_equalTo(height).priorityHigh();
    }];
    
    
    [self.avatarImageView sd_setImageWithURL:NSURL_BaseURL(model.avatarImageUrl) placeholderImage:[UIImage imageNamed:@"Spark"]];
    self.nickNameLabel.text=model.nickName;
    self.timestampLabel.text=model.timestamp;
    
    self.mainSharingContentLabel.attributedText=[NSAttributedString attributedStringWithPlainString: self.model.mainSharingContent];
    if (self.model.mainSharingContent.length>0) {
        self.sharingContentShowAllButton.selected=model.isMainSharingContentLabelExpand;
        
        CGFloat width=[UIScreen mainScreen].bounds.size.width-avatarImageViewHeight;
        CGSize size=  [self.mainSharingContentLabel sizeThatFits:CGSizeMake(width, INT_MAX)];
        if (size.height>CONTENT_LABEL_DEFAULT_HEIGHT)
        {
            self.sharingContentShowAllButton.hidden=NO;
            CGFloat height=model.isMainSharingContentLabelExpand?size.height:CONTENT_LABEL_DEFAULT_HEIGHT;
            
            [self.mainSharingContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.timestampLabel.mas_bottom).offset(DEFAULT_VIEW_SPACING);
                make.right.mas_equalTo(self.contentView.mas_right).offset(-DEFAULT_VIEW_SPACING);
                make.left.mas_equalTo(self.avatarImageView.mas_right);
                make.height.mas_equalTo(height);
            }];
            
            
            [self.sharingContentShowAllButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom);
                make.left.mas_equalTo(self.avatarImageView.mas_right);
            }];
        }
        else{
            
            [self.mainSharingContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.timestampLabel.mas_bottom).offset(DEFAULT_VIEW_SPACING);
                make.right.mas_equalTo(self.contentView.mas_right).offset(-DEFAULT_VIEW_SPACING);
                make.left.mas_equalTo(self.avatarImageView.mas_right);
            }];
            
            self.sharingContentShowAllButton.hidden=YES;
            [self.sharingContentShowAllButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom);
                make.left.mas_equalTo(self.avatarImageView.mas_right);
                make.height.mas_equalTo(0).priorityHigh();
            }];
        }
    }
    else{
        [self.mainSharingContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.timestampLabel.mas_bottom);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-DEFAULT_VIEW_SPACING);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
            make.height.mas_equalTo(0);
        }];
        
        self.sharingContentShowAllButton.hidden=YES;
        [self.sharingContentShowAllButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
            make.height.mas_equalTo(0).priorityHigh();
        }];
    }
    

    
    if ([model.locationRecord isEqualToString:@"显示位置"]||isEmptyString(model.locationRecord )) {
        self.locationRecordButton.hidden=YES;
        [self.locationRecordButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.sharingImagesContainerView.mas_bottom);
//                make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
            make.height.mas_equalTo(0);
        }];
    }
    else{
        self.locationRecordButton.hidden=NO;
        [self.locationRecordButton setTitle:model.locationRecord  forState:UIControlStateNormal];
        [self.locationRecordButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.sharingImagesContainerView.mas_bottom).offset(DEFAULT_VIEW_SPACING);
//             make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom).offset(DEFAULT_VIEW_SPACING);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
        }];
    }
    
    [self.sharingMainOperationsContainerView setModel:model];
    
    [self.likeTheSharingRecordScrollView setLikeTheSharingUserRecords:model.likeTheSharingUserRecords];
        [self.likeTheSharingRecordScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.sharingMainOperationsContainerView.mas_bottom).offset(model.likeTheSharingUserRecords.count>0?DEFAULT_VIEW_SPACING:0.0);
            make.height.mas_equalTo(model.likeTheSharingUserRecords.count>0?likeTheSharingRecordScrollViewHeight:0.0 ).priorityHigh();
        }];

    
    [self.bottomSeparatorLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.likeTheSharingRecordScrollView.mas_bottom).offset(model.sharingComments.count>0?DEFAULT_VIEW_SPACING:0.0);
        make.height.mas_equalTo(model.sharingComments.count>0?bottomSeparatorLineViewHeight:0.0).priorityHigh();
//                           make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-DEFAULT_VIEW_SPACING);
    }];
    
  dispatch_async(dispatch_get_global_queue(0, 0), ^{
       [self.sharingCommentsTableView setModels:model.sharingComments];
  });

//   CGFloat  sharingCommentHeight=  [self.sharingCommentsTableView setCellModels:model.sharingComments];
    [self.sharingCommentsTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomSeparatorLineView.mas_bottom).offset(model.sharingImages.count>0?DEFAULT_VIEW_SPACING:0);
        make.height.mas_equalTo(model.sharingComments_Height).priorityHigh();
//          make.height.mas_equalTo(sharingCommentHeight).priorityHigh();
    }];
//    if (model.sharingComments.count>0) {
//        self.models=model.sharingComments;
//        [self.sharingCommentsTableView reloadData];
//    }
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
        _nickNameLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_timestampLabel];
    }
    return   _timestampLabel;
}

-( MLLinkLabel *)mainSharingContentLabel{
    if (!_mainSharingContentLabel) {
        _mainSharingContentLabel= [[MLLinkLabel alloc]init];
        _mainSharingContentLabel.numberOfLines=0;
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

-( FLXKTwoSharingPictureLayoutView *)sharingImagesContainerView{
    if (!_sharingImagesContainerView) {
        _sharingImagesContainerView= [[FLXKTwoSharingPictureLayoutView alloc]init];
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
        _sharingMainOperationsContainerView.addCommentRequestBlock=^(){
            [super addCommentRequest];
        };
        [self.contentView addSubview:_sharingMainOperationsContainerView];
    }
    return   _sharingMainOperationsContainerView;
}

-( FLXKHeaderImageSharingLikeCollectionView *)likeTheSharingRecordScrollView{
    if (!_likeTheSharingRecordScrollView) {
        _likeTheSharingRecordScrollView= [[FLXKHeaderImageSharingLikeCollectionView alloc]init];
        _likeTheSharingRecordScrollView.rowHeight=likeTheSharingRecordScrollViewHeight;
        //        _likeTheSharingRecordScrollView.backgroundColor=[UIColor yellowColor];
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
        _sharingCommentsTableView.addCommentRequsetBlock=^(SharingCommentCellModel* model){
            weakSelf.currentCommentCellModel=model;
            if ( weakSelf.addCommentRequestBlock) {
                weakSelf.addCommentRequestBlock([NSString stringWithFormat:@"回复:%@",model.toUserName],weakSelf);
            }
        };
        [self.contentView addSubview:_sharingCommentsTableView];
    }
    return   _sharingCommentsTableView;
}
//
//-( UITableView *)sharingCommentsTableView{
//    if (!_sharingCommentsTableView) {
//        _sharingCommentsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//        _sharingCommentsTableView.delegate = self;
//        _sharingCommentsTableView.dataSource = self;
//            [_sharingCommentsTableView registerNib:[UINib nibWithNibName:@"FLXKBaseCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FLXKBaseCommentCell"];
////        [_sharingCommentsTableView registerClass:[FLXKSharingBaseCell class] forCellReuseIdentifier:@"FLXKSharingBaseCell"];
//        _sharingCommentsTableView.showsVerticalScrollIndicator = NO;
//        _sharingCommentsTableView.backgroundColor = [UIColor clearColor];
//        _sharingCommentsTableView.bounces =NO;
//        _sharingCommentsTableView.scrollEnabled =NO;
//        _sharingCommentsTableView.estimatedRowHeight=17;
//        _sharingCommentsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [self.contentView addSubview:_sharingCommentsTableView];
//        
//    }
//    return _sharingCommentsTableView;
//}

#pragma mark - Delegate
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _models.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    FLXKBaseCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FLXKBaseCommentCell" forIndexPath:indexPath];
//    //    [self configureCell:cell atIndexPath:indexPath];
//    [cell setModel:_models[indexPath.row]];
//    return cell;
//}


#pragma mark - Private methods
-(void)loadComments{
    [self.sharingCommentsTableView reloadData];
}

-(void)showAllSharingContentAction:(UIButton*)sender{
    self.model.isMainSharingContentLabelExpand=!self.model.isMainSharingContentLabelExpand;
    [super reloadCurrentCell];
}
-(void)setupUI{
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.contentView).offset(DEFAULT_VIEW_SPACING);
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
        make.top.mas_equalTo(self.timestampLabel.mas_bottom).offset(DEFAULT_VIEW_SPACING);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-DEFAULT_VIEW_SPACING);
        make.left.mas_equalTo(self.avatarImageView.mas_right);
        make.height.mas_equalTo(0);
    }];
    
    
    [self.sharingContentShowAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom).offset(DEFAULT_VIEW_SPACING);
        make.left.mas_equalTo(self.avatarImageView.mas_right);
        make.height.mas_equalTo(0).priorityHigh();
    }];
    

    [self.sharingImagesContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom).offset(DEFAULT_VIEW_SPACING);
        make.left.mas_equalTo(self.avatarImageView.mas_right);
                make.right.mas_equalTo(self.contentView.mas_right).offset(-DEFAULT_VIEW_SPACING);
          make.height.mas_equalTo(0).priorityHigh();
    }];
    
    [self.locationRecordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sharingImagesContainerView.mas_bottom).offset(DEFAULT_VIEW_SPACING);
        make.left.mas_equalTo(self.avatarImageView.mas_right);
    }];
    
    [self.sharingMainOperationsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.locationRecordButton.mas_bottom).offset(DEFAULT_VIEW_SPACING);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-DEFAULT_VIEW_SPACING);
        make.left.mas_equalTo(self.avatarImageView.mas_right);
        make.height.mas_equalTo(sharingMainOperationsContainerViewHeight).priorityHigh();
    }];
//
    [self.likeTheSharingRecordScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sharingMainOperationsContainerView.mas_bottom).offset(DEFAULT_VIEW_SPACING);
//           make.top.mas_equalTo(self.locationRecordButton.mas_bottom).offset(DEFAULT_VIEW_SPACING);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-DEFAULT_VIEW_SPACING);
        make.left.mas_equalTo(self.avatarImageView.mas_right);
        make.height.mas_equalTo(likeTheSharingRecordScrollViewHeight).priorityHigh();
    }];
    
    [self.bottomSeparatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.likeTheSharingRecordScrollView.mas_bottom).offset(DEFAULT_VIEW_SPACING);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-DEFAULT_VIEW_SPACING);
        make.left.mas_equalTo(self.avatarImageView.mas_right);
        make.height.mas_equalTo(bottomSeparatorLineViewHeight).priorityHigh();
        
//        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-DEFAULT_VIEW_SPACING);
    }];
//    
        [self.sharingCommentsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bottomSeparatorLineView.mas_bottom).offset(DEFAULT_VIEW_SPACING);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-DEFAULT_VIEW_SPACING);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-DEFAULT_VIEW_SPACING);
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
