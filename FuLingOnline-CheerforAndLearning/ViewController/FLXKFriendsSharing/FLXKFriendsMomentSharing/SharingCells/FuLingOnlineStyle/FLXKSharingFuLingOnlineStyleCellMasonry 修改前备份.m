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
//IBOutlet
//@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
//@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
//@property (weak, nonatomic) IBOutlet UITextView *mainSharingContentLabel;
//@property (weak, nonatomic) IBOutlet UIButton *sharingContentShowAllButton;
//@property (strong, nonatomic) IBOutlet FLXKBaseSharingPictureLayoutView *sharingImagesContainerView;
//@property (weak, nonatomic) IBOutlet UIButton *locationRecordButton;
//@property (weak, nonatomic) IBOutlet UIView *sharingMainOperationsContainerView;
//
//@property (weak, nonatomic) IBOutlet UIButton *thumberUpButton;
//
//
//@property (weak, nonatomic) IBOutlet FLXKHeaderImageSharingLikeCollectionView *likeTheSharingRecordScrollView;
//@property (weak, nonatomic) IBOutlet UIView *bottomSeparatorLineView;
//@property (weak, nonatomic) IBOutlet FLXKBaseSharingCommentTableView *sharingCommentsTableView;


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

//
////mainSharingContentLabel
//@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *mainSharingContentLabelConstraints;
//
////sharingContentShowAllButton
//@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *sharingContentShowAllButtonConstraints;
//
//
////sharingImagesContainerView
//@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *sharingImagesContainerViewConstraints;
//
//
//
////locationRecordButton
//@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *locationRecordButtonConstraints;
//
////likeTheSharingRecordScrollView
//@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *likeTheSharingRecordScrollViewConstraints;
//
////bottomSeparatorLineView
//@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *bottomSeparatorLineViewConstraints;
//
////sharingCommentsTableView
//@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *sharingCommentsTableViewConstraints;

//IBAction

//点赞
//- (IBAction)Addthumbup:(id)sender;

//评论

//分享

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
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
//        self.translatesAutoresizingMaskIntoConstraints=YES;
//          self.translatesAutoresizingMaskIntoConstraints=NO;
//          self.contentView.translatesAutoresizingMaskIntoConstraints=NO;
//        [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
//        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;//**这句话很重要
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(self.contentView);
            make.height.mas_equalTo(self.avatarImageView.mas_width).multipliedBy(1);
            make.height.mas_equalTo(46);
            //                make.bottom.mas_equalTo(self.mas_bottom);
        }];
        
        [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.avatarImageView.mas_top);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
        }];
        
        [self.timestampLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.avatarImageView.mas_bottom);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
        }];
        
        
//        [self.sharingImagesContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.timestampLabel.mas_bottom).offset(8);
//            make.left.mas_equalTo(self.avatarImageView.mas_right);
//            make.bottom.mas_equalTo(self.contentView.mas_bottom);
//            make.height.mas_equalTo(0);
//        }];
        
        //
        //            [self.mainSharingContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //                make.top.mas_equalTo(self.timestampLabel.mas_bottom).offset(8);
        //                make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
        //                make.left.mas_equalTo(self.avatarImageView.mas_right);
        //            }];
        //
        //
        //                [self.sharingContentShowAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //                    make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom).offset(8);
        //                    make.left.mas_equalTo(self.avatarImageView.mas_right);
        ////                       make.bottom.mas_equalTo(self.mas_bottom);
        //                }];
        
        
        //            [self.sharingImagesContainerView  mas_makeConstraints:^(MASConstraintMaker *make) {
        //                make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom).offset(8);
        //                make.left.mas_equalTo(self.avatarImageView.mas_right);
        //                   make.bottom.mas_equalTo(self.mas_bottom);
        //            }];
        //
        //            [self.locationRecordButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        //                make.top.mas_equalTo(self.sharingImagesContainerView.mas_bottom).offset(8);
        //                make.left.mas_equalTo(self.avatarImageView.mas_right);
        //            }];
        //
        //        [self.sharingMainOperationsContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        //            make.top.mas_equalTo(self.locationRecordButton.mas_bottom).offset(8);
        //            make.right.mas_equalTo(self.mas_right).offset(-8);
        //            make.left.mas_equalTo(self.avatarImageView.mas_right);
        //            make.height.mas_equalTo(44.0);
        //        }];
        //
        //
        //            [self.likeTheSharingRecordScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        //                make.top.mas_equalTo(self.sharingMainOperationsContainerView.mas_bottom).offset(8);
        //                make.right.mas_equalTo(self.mas_right).offset(-8);
        //                make.left.mas_equalTo(self.avatarImageView.mas_right);
        //                make.height.mas_equalTo(44.0);
        //            }];
        //
        //            [self.bottomSeparatorLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        //                make.top.mas_equalTo(self.likeTheSharingRecordScrollView.mas_bottom).offset(8);
        //                make.right.mas_equalTo(self.mas_right).offset(-8);
        //                make.left.mas_equalTo(self.avatarImageView.mas_right);
        //                make.height.mas_equalTo(1.0);
        //            }];
        //
        //            [self.sharingCommentsTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        //                make.top.mas_equalTo(self.bottomSeparatorLineView.mas_bottom).offset(8);
        //                make.right.mas_equalTo(self.mas_right).offset(-8);
        //                make.bottom.mas_equalTo(self.mas_bottom).offset(-8);
        //                make.left.mas_equalTo(self.avatarImageView.mas_right);
        //                make.height.mas_equalTo(0);
        //            }];
        
        //
        
        //                [self.mainSharingContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //                    make.top.mas_equalTo(self.timestampLabel.mas_bottom).offset(8);
        //                    make.right.mas_equalTo(self.mas_right).offset(-8);
        ////                    make.bottom.mas_equalTo(self.sharingContentShowAllButton.mas_top).offset(-8);
        //                    make.left.mas_equalTo(self.avatarImageView.mas_right);
        ////                         make.bottom.mas_equalTo(self.mas_bottom);
        //                }];
        //
        //                [self.sharingContentShowAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //                    make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom);
        //                    //        make.right.mas_equalTo(self.mas_right).offset(8);
        ////                    make.bottom.mas_equalTo(self.sharingImagesContainerView.mas_top).offset(-8);
        //                    make.left.mas_equalTo(self.avatarImageView.mas_right);
        ////                        make.bottom.mas_equalTo(self.mas_bottom);
        //                }];
        //
        //                [self.sharingImagesContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        //                    make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom).offset(8);
        //                    //        make.right.mas_equalTo(self.mas_right).offset(8);
        ////                    make.bottom.mas_equalTo(self.locationRecordButton.mas_top).offset(-8);
        //                    make.left.mas_equalTo(self.avatarImageView.mas_right);
        //
        //                }];
        //
        //                [self.locationRecordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //                    make.top.mas_equalTo(self.sharingImagesContainerView.mas_bottom).offset(8);
        ////                    make.bottom.mas_equalTo(self.sharingMainOperationsContainerView.mas_top).offset(-8);
        //                    make.left.mas_equalTo(self.avatarImageView.mas_right);
        //                }];
        //
        //                [self.sharingMainOperationsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        //                    make.top.mas_equalTo(self.locationRecordButton.mas_bottom).offset(8);
        //                    make.right.mas_equalTo(self.mas_right).offset(-8);
        ////                    make.bottom.mas_equalTo(self.likeTheSharingRecordScrollView.mas_top).offset(-8);
        //
        //                    make.left.mas_equalTo(self.avatarImageView.mas_right);
        //                }];
        //
        //                [self.likeTheSharingRecordScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        //                    make.top.mas_equalTo(self.sharingMainOperationsContainerView.mas_bottom).offset(8);
        //                    make.right.mas_equalTo(self.mas_right).offset(-8);
        //                    make.bottom.mas_equalTo(self.bottomSeparatorLineView.mas_top).offset(-8);
        //                    make.left.mas_equalTo(self.avatarImageView.mas_right);
        //                        make.height.mas_equalTo(44.0);
        //                }];
        //
        //                [self.bottomSeparatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        //                    make.top.mas_equalTo(self.likeTheSharingRecordScrollView.mas_bottom).offset(8);
        //                    make.right.mas_equalTo(self.mas_right).offset(-8);
        //                    make.bottom.mas_equalTo(self.sharingCommentsTableView.mas_top).offset(-8);
        //                    make.left.mas_equalTo(self.avatarImageView.mas_right);
        //                }];
        //
        //                [self.sharingCommentsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        //                    make.top.mas_equalTo(self.bottomSeparatorLineView.mas_bottom).offset(8);
        //                    make.right.mas_equalTo(self.mas_right).offset(-8);
        //                    make.bottom.mas_equalTo(self.mas_bottom).offset(-8);
        //                    make.left.mas_equalTo(self.avatarImageView.mas_right);
        //                }];
    }
    return self;
}



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
-(void)setSharingCellModel:(FLXKSharingCellModel *)model  WithIndexPath:(NSIndexPath *)indexPath{
    //    self.sharingCellModel=model;
    //    [self.sharingMainOperationsContainerView setModel:model WithIndexPath:indexPath];
}


-(void)setupNewSharingImagesContainerViewWithImageArray:(NSArray<FLXKSharingImagesModel*>*)imageArray{
    //    if (imageArray.count>0) {
    //        FLXKBaseSharingPictureLayoutView*  newView=[FLXKBaseSharingPictureLayoutView setupSharingPictureLayoutViewWithImageArray:imageArray];
    //        [self.contentView addSubview:newView];
    //        [self.sharingImagesContainerView removeFromSuperview];
    //        self.sharingImagesContainerView=newView;
    //        [newView mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom).offset(8);
    //            make.bottom.mas_equalTo(self.locationRecordButton.mas_top).offset(-8);
    //            make.left.mas_equalTo(self.nickNameLabel.mas_left);
    //        }];
    //    }
    //    else{
    //        [self.sharingImagesContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom);
    //            make.bottom.mas_equalTo(self.locationRecordButton.mas_top);
    //            make.height.mas_equalTo(0);
    //        }];
    //    }
}

-(void)setupLocationRecordButtonWithLocation:(NSString*)location{
    if ([location isEqualToString:@"显示位置"]||isEmptyString(location)) {
        //        [self hideView:self.locationRecordButton  withConstraints:self.locationRecordButtonConstraints];
    }
    else{
        [self.locationRecordButton setTitle:location forState:UIControlStateNormal];
        //        [self showView:self.locationRecordButton withConstraints:self.locationRecordButtonConstraints topConstant:8.0 bottomConstant:8.0 heightConstant:0.0];
    }
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

//-(void)setupMainSharingContentLabel{
//        self.mainSharingContentLabel.backgroundColor=[UIColor yellowColor];
//        self.sharingContentShowAllButton.backgroundColor=[UIColor blueColor];
//        if (self.model.mainSharingContent.length>0) {
//
////            [self.mainSharingContentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
////                make.top.mas_equalTo(self.timestampLabel.mas_bottom).offset(8);
////                make.right.mas_equalTo(self.mas_right).offset(-8);
////                make.bottom.mas_equalTo(self.sharingContentShowAllButton.mas_top).offset(-8);
////                make.left.mas_equalTo(self.avatarImageView.mas_right);
////            }];
////
//            CGFloat width=[UIScreen mainScreen].bounds.size.width-46;
////            NSLog(@"self.mainSharingContentLabel.frame.size.width %f", self.mainSharingContentLabel.frame.size.width);
//            self.mainSharingContentLabel.attributedText=[NSAttributedString attributedStringWithPlainString: self.model.mainSharingContent];
//            CGSize size=  [self.mainSharingContentLabel sizeThatFits:CGSizeMake(width, INT_MAX)];
////              NSLog(@"size.width %f", size.width);
//            if (size.height>FBTweakValue(@"FuLingOnlineStyleCell", @"setupMainSharingContentLabel",  @"size.height", 30.0)) {
////                [self.sharingContentShowAllButton mas_remakeConstraints:^(MASConstraintMaker *make) {
////                    make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom).offset(8);
////                    make.bottom.mas_equalTo(self.sharingImagesContainerView.mas_top).offset(-8);
////                    make.left.mas_equalTo(self.avatarImageView.mas_right);
////                }];
//                            [self.mainSharingContentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//    make.height.mas_equalTo(size.height);
//                            }];
//
//            }
//            else{
//[self.sharingContentShowAllButton mas_updateConstraints:^(MASConstraintMaker *make) {
//    make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom);
////    make.bottom.mas_equalTo(self.sharingImagesContainerView.mas_top);
//    make.height.mas_equalTo(0);
//}];
//                [self.sharingContentShowAllButton setTitle:@"" forState:UIControlStateNormal];
//
//            }
//        }
//        else{
//            [self.mainSharingContentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(self.timestampLabel.mas_bottom);
//                make.bottom.mas_equalTo(self.sharingContentShowAllButton.mas_top);
//                make.height.mas_equalTo(0);
//            }];
//
//            [self.sharingContentShowAllButton mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom);
////                make.bottom.mas_equalTo(self.sharingImagesContainerView.mas_top);
//                make.height.mas_equalTo(0);
//            }];
//        }
//}

//-(NSArray*)setupSharingCommentCellModels{
//    NSMutableArray<SharingCommentCellModel*> * models=[NSMutableArray array];
//    for (int i=0; i<3; i++) {
//        SharingCommentCellModel* model=[[SharingCommentCellModel alloc]init];
//        model.toUserID=@"nickName";
//        [models addObject:model];
//    }
//    return       [NSArray arrayWithArray:models];
//}

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
    [self.contentView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.firstItem==self.contentView&& obj.firstAttribute==NSLayoutAttributeHeight) {
            [self.contentView removeConstraint:obj];
        }
    }];
    [super setModel:model];
    //    self.avatarImageView.image=[UIImage imageNamed:model.avatarImageUrl];
    //    [self.avatarImageView sd_setImageWithURL:NSURL_BaseURL(model.avatarImageUrl) placeholderImage:[UIImage imageNamed:@"Spark"]];
    //    self.nickNameLabel.text=model.nickName;
    //    self.timestampLabel.text=model.timestamp;
    //    //    self.mainSharingContentLabel.text=model.mainSharingContent;
    //    [self setupMainSharingContentLabel];
    //    //    [self setupNewSharingImagesContainerViewWithImageArray:(model.sharingImages.count>0?@[model.sharingImages[0]]:nil)];
    //    [self setupNewSharingImagesContainerViewWithImageArray:model.sharingImages];
    //    //       [self.locationRecordButton setTitle:model.locationRecord forState:UIControlStateNormal];
    //    //    [self setupLocationRecordButtonWithLocation:model.locationRecord];
    //    [self.likeTheSharingRecordScrollView setLikeTheSharingUserRecords:model.likeTheSharingUserRecords];
    //
    //
    //    [self setupSharingCommentsTableViewWithCellModels:model.sharingComments];
    //    //    [self.sharingCommentsTableView setModels:model.sharingComments];
    //
    //    if (model.isThumberuped==1) {
    //        [self.thumberUpButton setImage:[UIImage imageNamed:@"sharing_thumbup_s"]  forState:UIControlStateNormal];
    //    }
    //    else{
    //        [self.thumberUpButton setImage:[UIImage imageNamed:@"sharing_thumbup_n"]  forState:UIControlStateNormal];
    //
    //    }
    [self.contentView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"self.contentView %lu , %@",(unsigned long)idx, obj);
    }];
    [self.sharingImagesContainerView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"self.sharingImagesContainerView %lu , %@",(unsigned long)idx, obj);
    }];
    
    [self.avatarImageView sd_setImageWithURL:NSURL_BaseURL(model.avatarImageUrl) placeholderImage:[UIImage imageNamed:@"Spark"]];
    self.nickNameLabel.text=model.nickName;
    self.timestampLabel.text=model.timestamp;
    
    if (self.model.mainSharingContent.length>0) {
        self.mainSharingContentLabel.backgroundColor=[UIColor yellowColor];
        self.sharingContentShowAllButton.backgroundColor=[UIColor blueColor];
        self.mainSharingContentLabel.attributedText=[NSAttributedString attributedStringWithPlainString: self.model.mainSharingContent];
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
                               make.bottom.mas_equalTo(self.contentView.mas_bottom);
            }];
        }
        else{
            self.sharingContentShowAllButton.hidden=YES;
            
            [_sharingContentShowAllButton setTitle:@"" forState:UIControlStateNormal];
            [self.sharingContentShowAllButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom);
                make.left.mas_equalTo(self.avatarImageView.mas_right);
                make.height.mas_equalTo(0);
                               make.bottom.mas_equalTo(self.contentView.mas_bottom);
            }];
        }
    }
    else{
        self.mainSharingContentLabel.attributedText=[NSAttributedString attributedStringWithPlainString: self.model.mainSharingContent];
        [self.mainSharingContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.timestampLabel.mas_bottom);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
            make.height.mas_equalTo(0);
        }];
        self.sharingContentShowAllButton.hidden=YES;
        [_sharingContentShowAllButton setTitle:@"" forState:UIControlStateNormal];
        [self.sharingContentShowAllButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
            make.height.mas_equalTo(0);
                           make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
    }
//
//    
//        [self.sharingImagesContainerView setImageArray:model.sharingImages];
//        CGFloat height=  self.sharingImagesContainerView.viewHeight;
//    
//        if (model.sharingImages.count>0) {
//            [self.sharingImagesContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(self.timestampLabel.mas_bottom).offset(8);
//                make.left.mas_equalTo(self.avatarImageView.mas_right);
//                make.bottom.mas_equalTo(self.contentView.mas_bottom);
//                make.height.mas_equalTo(height);
//            }];
//        }
//        else{
//            [self.sharingImagesContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(self.timestampLabel.mas_bottom);
//                make.left.mas_equalTo(self.avatarImageView.mas_right);
//                make.bottom.mas_equalTo(self.contentView.mas_bottom);
//                make.height.mas_equalTo(height);
//            }];
//        }
    
    //    [self.sharingImagesContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom).offset(8);
    //        make.left.mas_equalTo(self.avatarImageView.mas_right);
    //        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    //        make.height.mas_equalTo(self.sharingImagesContainerView.viewHeight);
    //    }];
    
    
//    [self.sharingImagesContainerView setImageArray:model.sharingImages];
//    CGFloat height=  self.sharingImagesContainerView.viewHeight;
//    
//    if (model.sharingImages.count>0) {
//        [self.sharingImagesContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom).offset(8);
//            make.left.mas_equalTo(self.avatarImageView.mas_right);
//            make.bottom.mas_equalTo(self.contentView.mas_bottom);
//            make.height.mas_equalTo(height);
//        }];
//    }
//    else{
//        [self.sharingImagesContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom);
//            make.left.mas_equalTo(self.avatarImageView.mas_right);
//            make.bottom.mas_equalTo(self.contentView.mas_bottom);
//            make.height.mas_equalTo(height);
//        }];
//    }
//    
//   [self.likeTheSharingRecordScrollView setLikeTheSharingUserRecords:model.likeTheSharingUserRecords];
//        if ( model.likeTheSharingUserRecords.count>0) {
//                            [self.likeTheSharingRecordScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                                make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom).offset(8);
//                                make.right.mas_equalTo(self.mas_right).offset(-8);
//                                make.left.mas_equalTo(self.avatarImageView.mas_right);
//                                make.height.mas_equalTo(44.0);
//                                    make.bottom.mas_equalTo(self.contentView.mas_bottom);
//                            }];
//        }
//        else{
//            [self.likeTheSharingRecordScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom);
//                make.right.mas_equalTo(self.mas_right);
//                make.left.mas_equalTo(self.avatarImageView.mas_right);
//                make.height.mas_equalTo(0);
//                    make.bottom.mas_equalTo(self.contentView.mas_bottom);
//            }];
//        }
    
    
    
    
    
    //           if ([model.locationRecord isEqualToString:@"显示位置"]||isEmptyString(model.locationRecord )) {
    //               [self.locationRecordButton mas_remakeConstraints:^(MASConstraintMaker *make) {
    //                   make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom);
    //                   make.left.mas_equalTo(self.avatarImageView.mas_right);
    //                   make.height.mas_equalTo(0);
    //                   make.bottom.mas_equalTo(self.contentView.mas_bottom);
    //               }];
    //        }
    //        else{
    //            [self.locationRecordButton setTitle:model.locationRecord  forState:UIControlStateNormal];
    //            [self.locationRecordButton mas_remakeConstraints:^(MASConstraintMaker *make) {
    //                make.top.mas_equalTo(self.sharingContentShowAllButton.mas_bottom).offset(8);
    //                make.left.mas_equalTo(self.avatarImageView.mas_right);
    //                make.bottom.mas_equalTo(self.contentView.mas_bottom);
    //            }];
    //        }
    
    
    //       if ([model.locationRecord isEqualToString:@"显示位置"]||isEmptyString(model.locationRecord )) {
    //           [self.locationRecordButton mas_remakeConstraints:^(MASConstraintMaker *make) {
    //               make.top.mas_equalTo(self.sharingImagesContainerView.mas_bottom);
    //               make.left.mas_equalTo(self.avatarImageView.mas_right);
    //               make.height.mas_equalTo(0);
    //               make.bottom.mas_equalTo(self.contentView.mas_bottom);
    //           }];
    //    }
    //    else{
    //        [self.locationRecordButton setTitle:model.locationRecord  forState:UIControlStateNormal];
    //        [self.locationRecordButton mas_remakeConstraints:^(MASConstraintMaker *make) {
    //            make.top.mas_equalTo(self.sharingImagesContainerView.mas_bottom).offset(8);
    //            make.left.mas_equalTo(self.avatarImageView.mas_right);
    //            make.bottom.mas_equalTo(self.contentView.mas_bottom);
    //        }];
    //    }
    
    //        [self.sharingMainOperationsContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //                        make.top.mas_equalTo(self.locationRecordButton.mas_bottom).offset(8);
    //                        make.right.mas_equalTo(self.mas_right).offset(-8);
    //                        make.left.mas_equalTo(self.avatarImageView.mas_right);
    //            make.height.mas_equalTo(44.0);
    //                    }];
    
    //    if ( model.likeTheSharingUserRecords.count>0) {
    //                        [self.likeTheSharingRecordScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //                            make.top.mas_equalTo(self.sharingMainOperationsContainerView.mas_bottom).offset(8);
    //                            make.right.mas_equalTo(self.mas_right).offset(-8);
    //                            make.left.mas_equalTo(self.avatarImageView.mas_right);
    //                            make.height.mas_equalTo(44.0);
    //                        }];
    //    }
    //    else{
    //        [self.likeTheSharingRecordScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //            make.top.mas_equalTo(self.sharingMainOperationsContainerView.mas_bottom);
    //            make.right.mas_equalTo(self.mas_right);
    //            make.left.mas_equalTo(self.avatarImageView.mas_right);
    //            make.height.mas_equalTo(0);
    //        }];
    //    }
    //
    //    if ( model.sharingComments.count>0) {
    //                        [self.bottomSeparatorLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //                            make.top.mas_equalTo(self.likeTheSharingRecordScrollView.mas_bottom).offset(8);
    //                            make.right.mas_equalTo(self.mas_right).offset(-8);
    //                            make.left.mas_equalTo(self.avatarImageView.mas_right);
    //                                make.height.mas_equalTo(1.0);
    //                        }];
    //    }
    //    else{
    //        [self.bottomSeparatorLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //            make.top.mas_equalTo(self.likeTheSharingRecordScrollView.mas_bottom);
    //            make.right.mas_equalTo(self.mas_right).offset(-8);
    //            make.left.mas_equalTo(self.avatarImageView.mas_right);
    //            make.height.mas_equalTo(0.0);
    //        }];
    //    }
    //
    //    if ( model.sharingComments.count>0) {
    //          CGFloat height= [self.sharingCommentsTableView setCellModels:model.sharingComments];
    //                        [self.sharingCommentsTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //                            make.top.mas_equalTo(self.bottomSeparatorLineView.mas_bottom).offset(8);
    //                            make.right.mas_equalTo(self.mas_right).offset(-8);
    //                            make.bottom.mas_equalTo(self.mas_bottom).offset(-8);
    //                            make.left.mas_equalTo(self.avatarImageView.mas_right);
    //                              make.height.mas_equalTo(height);
    //                        }];
    //
    //    }
    //    else{
    //        [self.sharingCommentsTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //            make.top.mas_equalTo(self.bottomSeparatorLineView.mas_bottom);
    //            make.right.mas_equalTo(self.mas_right).offset(-8);
    //            make.bottom.mas_equalTo(self.mas_bottom);
    //            make.left.mas_equalTo(self.avatarImageView.mas_right);
    //            make.height.mas_equalTo(0.0);
    //        }];
    //    }
    //
//    [self layoutIfNeeded];
    [self.contentView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"self.contentView---2 %lu , %@",(unsigned long)idx, obj);
    }];
    [self.sharingImagesContainerView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"self.sharingImagesContainerView---2 %lu , %@",(unsigned long)idx, obj);
    }];
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
        _sharingImagesContainerView.translatesAutoresizingMaskIntoConstraints=NO;
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

//-(void)hideView:(UIView*)view withConstraints:( NSArray<NSLayoutConstraint*> *)contraints{
//    //for masonry
//    //    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
//    //        make.top.bottom.height.mas_equalTo(0);
//    //    }];
//
//
//    [contraints enumerateObjectsUsingBlock:^(NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        obj.constant=0;
//    }];
//    if (view.constraints.count>0) {
//        __block  BOOL hasHeightConstraint=NO;
//        [view.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            //            NSLog(@"obj.firstAttribute %ld", (long)obj.firstAttribute);
//            if (obj.firstAttribute==NSLayoutAttributeHeight) {
//                hasHeightConstraint=YES;
//                obj.constant=0;
//            }
//        }];
//        if (!hasHeightConstraint) {
//            NSLayoutConstraint *heightCos = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0 constant:0];
//            [view addConstraint:heightCos];
//        }
//    }
//    else{
//        NSLayoutConstraint *heightCos = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0 constant:0];
//        [view addConstraint:heightCos];
//    }
//    view.hidden=YES;
//    [self setNeedsLayout];
//}
//
//-(void)showView:(UIView*)view withConstraints:( NSArray<NSLayoutConstraint*> *)contraints topConstant:(CGFloat)topConstant bottomConstant:(CGFloat)bottomConstant heightConstant:(CGFloat)heightConstant {
//    //for masonry
//    //    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
//    //
//    //    }];
//    
//    
//    [view.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (obj.firstAttribute==NSLayoutAttributeHeight) {
//            if (obj.constant==0&&heightConstant==0) {
//                [view removeConstraint:obj];
//            }
//            else if (obj.constant==0&&heightConstant!=0){
//                obj.constant=heightConstant;
//            }
//        }
//    }];
//    
//    [contraints enumerateObjectsUsingBlock:^(NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        switch (idx) {
//            case 0:
//                obj.constant=topConstant;
//                break;
//            case 1:
//                obj.constant=bottomConstant;
//                break;
//                
//            default:
//                obj.constant=8;
//                break;
//        }
//    }];
//    
//    view.hidden=NO;
//    [self setNeedsLayout];
//}

#pragma mark - Overriden methods

#pragma mark - Navigation

@end
