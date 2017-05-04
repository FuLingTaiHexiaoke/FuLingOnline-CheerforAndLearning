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

@property (weak, nonatomic) IBOutlet UIButton *thumberUpButton;


@property (weak, nonatomic) IBOutlet FLXKHeaderImageSharingLikeCollectionView *likeTheSharingRecordScrollView;
@property (weak, nonatomic) IBOutlet UIView *bottomSeparatorLineView;
@property (weak, nonatomic) IBOutlet FLXKBaseSharingCommentTableView *sharingCommentsTableView;


//IBOutlet Constraints


//mainSharingContentLabel
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *mainSharingContentLabelConstraints;

//sharingContentShowAllButton
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *sharingContentShowAllButtonConstraints;


//sharingImagesContainerView
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *sharingImagesContainerViewConstraints;



//locationRecordButton
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *locationRecordButtonConstraints;

//likeTheSharingRecordScrollView
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *likeTheSharingRecordScrollViewConstraints;

//bottomSeparatorLineView
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *bottomSeparatorLineViewConstraints;

//sharingCommentsTableView
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *sharingCommentsTableViewConstraints;

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
    if (imageArray.count>0) {
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
    else{
        [self hideView:self.sharingImagesContainerView  withConstraints:self.sharingImagesContainerViewConstraints];
    }
}

-(void)setupLocationRecordButtonWithLocation:(NSString*)location{
    if ([location isEqualToString:@"显示位置"]||isEmptyString(location)) {
        [self hideView:self.locationRecordButton  withConstraints:self.locationRecordButtonConstraints];
    }
    else{
        [self.locationRecordButton setTitle:location forState:UIControlStateNormal];
        [self showView:self.locationRecordButton withConstraints:self.locationRecordButtonConstraints topConstant:8.0 bottomConstant:8.0 heightConstant:0.0];
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

-(void)setupMainSharingContentLabel{
    self.mainSharingContentLabel.backgroundColor=[UIColor yellowColor];
    self.sharingContentShowAllButton.backgroundColor=[UIColor blueColor];
    if (self.model.mainSharingContent.length>0) {
        [self showView:self.mainSharingContentLabel withConstraints:self.mainSharingContentLabelConstraints topConstant:8.0 bottomConstant:0.0 heightConstant:0.0];
        self.mainSharingContentLabel.attributedText=[NSAttributedString attributedStringWithPlainString: self.model.mainSharingContent];
        CGSize size=  [self.mainSharingContentLabel sizeThatFits:CGSizeMake(self.mainSharingContentLabel.frame.size.width, INT_MAX)];
        if (size.height>FBTweakValue(@"FuLingOnlineStyleCell", @"setupMainSharingContentLabel",  @"size.height", 30.0)) {
            [self showView:self.sharingContentShowAllButton withConstraints:self.sharingContentShowAllButtonConstraints topConstant:0.0 bottomConstant:8.0 heightConstant:0.0];
        }
        else{
            [self hideView:self.sharingContentShowAllButton withConstraints:self.sharingContentShowAllButtonConstraints];
            [self.sharingContentShowAllButton setTitle:@"" forState:UIControlStateNormal];
            
        }
    }
    else{
        [self hideView:self.mainSharingContentLabel withConstraints:self.mainSharingContentLabelConstraints];
        [self hideView:self.sharingContentShowAllButton withConstraints:self.sharingContentShowAllButtonConstraints];
    }
}

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
    [super setModel:model];
    //    self.avatarImageView.image=[UIImage imageNamed:model.avatarImageUrl];
    [self.avatarImageView sd_setImageWithURL:NSURL_BaseURL(model.avatarImageUrl) placeholderImage:[UIImage imageNamed:@"Spark"]];
    self.nickNameLabel.text=model.nickName;
    self.timestampLabel.text=model.timestamp;
    //    self.mainSharingContentLabel.text=model.mainSharingContent;
    [self setupMainSharingContentLabel];
    //    [self setupNewSharingImagesContainerViewWithImageArray:(model.sharingImages.count>0?@[model.sharingImages[0]]:nil)];
    [self setupNewSharingImagesContainerViewWithImageArray:model.sharingImages];
    //       [self.locationRecordButton setTitle:model.locationRecord forState:UIControlStateNormal];
//    [self setupLocationRecordButtonWithLocation:model.locationRecord];
    [self.likeTheSharingRecordScrollView setLikeTheSharingUserRecords:model.likeTheSharingUserRecords];
    
    
    [self setupSharingCommentsTableViewWithCellModels:model.sharingComments];
    //    [self.sharingCommentsTableView setModels:model.sharingComments];
    
    if (model.isThumberuped==1) {
        [self.thumberUpButton setImage:[UIImage imageNamed:@"sharing_thumbup_s"]  forState:UIControlStateNormal];
    }
    else{
        [self.thumberUpButton setImage:[UIImage imageNamed:@"sharing_thumbup_n"]  forState:UIControlStateNormal];
        
    }
    
    
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

-(void)hideView:(UIView*)view withConstraints:( NSArray<NSLayoutConstraint*> *)contraints{
    //for masonry
    //    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.top.bottom.height.mas_equalTo(0);
    //    }];
    
    
    [contraints enumerateObjectsUsingBlock:^(NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.constant=0;
    }];
    if (view.constraints.count>0) {
        __block  BOOL hasHeightConstraint=NO;
        [view.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //            NSLog(@"obj.firstAttribute %ld", (long)obj.firstAttribute);
            if (obj.firstAttribute==NSLayoutAttributeHeight) {
                hasHeightConstraint=YES;
                obj.constant=0;
            }
        }];
        if (!hasHeightConstraint) {
            NSLayoutConstraint *heightCos = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0 constant:0];
            [view addConstraint:heightCos];
        }
    }
    else{
        NSLayoutConstraint *heightCos = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0 constant:0];
        [view addConstraint:heightCos];
    }
    view.hidden=YES;
    [self setNeedsLayout];
}

-(void)showView:(UIView*)view withConstraints:( NSArray<NSLayoutConstraint*> *)contraints topConstant:(CGFloat)topConstant bottomConstant:(CGFloat)bottomConstant heightConstant:(CGFloat)heightConstant {
    //for masonry
    //    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
    //
    //    }];
    
    
    [view.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.firstAttribute==NSLayoutAttributeHeight) {
            if (obj.constant==0&&heightConstant==0) {
                [view removeConstraint:obj];
            }
            else if (obj.constant==0&&heightConstant!=0){
                obj.constant=heightConstant;
            }
        }
    }];
    
    [contraints enumerateObjectsUsingBlock:^(NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (idx) {
            case 0:
                obj.constant=topConstant;
                break;
            case 1:
                obj.constant=bottomConstant;
                break;
                
            default:
                obj.constant=8;
                break;
        }
    }];
    
    view.hidden=NO;
    [self setNeedsLayout];
}

#pragma mark - Overriden methods

#pragma mark - Navigation

@end
