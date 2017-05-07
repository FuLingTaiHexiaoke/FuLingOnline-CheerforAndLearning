//
//  FLXKSharingFuLingOnlineStyleCell.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKSharingFuLingOnlineStyleCellmasonry.h"

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

@interface FLXKSharingFuLingOnlineStyleCellmasonry ()

@property (strong, nonatomic)  UIImageView *avatarImageView;
@property (strong, nonatomic)  UILabel *nickNameLabel;
@property (strong, nonatomic)  UILabel *timestampLabel;
@property (strong, nonatomic)  UITextView *mainSharingContentLabel;
@property (strong, nonatomic)  UIButton *sharingContentShowAllButton;
@property (strong, nonatomic)  FLXKTwoSharingPictureLayoutView *sharingImagesContainerView;

//child viewController
//subviews
//models
//UI state record properties
@end

@implementation FLXKSharingFuLingOnlineStyleCellmasonry

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
        //        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        //self.contentView.bounds = CGRectMake(0, 0, 99999, 99999);
        
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
        
                [self.sharingImagesContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.timestampLabel.mas_bottom).offset(8);
                    make.left.mas_equalTo(self.avatarImageView.mas_right);
//                    make.bottom.mas_equalTo(self.contentView.mas_bottom);
                    make.height.mas_equalTo(100);
                }];
    }
    return self;
}

#pragma mark - Delegate
#pragma mark - Public methods

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
//    [self.contentView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (obj.firstItem==self.contentView&& obj.firstAttribute==NSLayoutAttributeHeight) {
//            [self.contentView removeConstraint:obj];
//        }
//    }];

    [super setModel:model];
    //
    [self.contentView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //                if ( obj.firstAttribute==NSLayoutAttributeHeight) {
        //                    NSLog(@"self.contentView %lu , %@",(unsigned long)idx, obj);
        //                }
        NSLog(@"self.contentView %lu , %@",(unsigned long)idx, obj);
    }];
    [self.sharingImagesContainerView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //        if ( obj.firstAttribute==NSLayoutAttributeHeight) {
        //            NSLog(@"self.sharingImagesContainerView %lu , %@",(unsigned long)idx, obj);
        //        }
        NSLog(@"self.sharingImagesContainerView %lu , %@",(unsigned long)idx, obj);
    }];
    
    [self.avatarImageView sd_setImageWithURL:NSURL_BaseURL(model.avatarImageUrl) placeholderImage:[UIImage imageNamed:@"Spark"]];
    self.nickNameLabel.text=model.nickName;
    self.timestampLabel.text=model.timestamp;
    
    if (self.model.mainSharingContent.length>0) {
        self.mainSharingContentLabel.hidden=NO;
        self.sharingContentShowAllButton.hidden=NO;
        
        self.mainSharingContentLabel.backgroundColor=[UIColor yellowColor];
        self.sharingContentShowAllButton.backgroundColor=[UIColor blueColor];
        self.mainSharingContentLabel.attributedText=[NSAttributedString attributedStringWithPlainString: self.model.mainSharingContent];
        [self.mainSharingContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.timestampLabel.mas_bottom).offset(8);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
            make.height.mas_equalTo(100);
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

//        self.mainSharingContentLabel.attributedText=[NSAttributedString attributedStringWithPlainString: self.model.mainSharingContent];
        [self.mainSharingContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.timestampLabel.mas_bottom);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
            make.height.mas_equalTo(0);
        }];
                 self.mainSharingContentLabel.hidden=YES;
        self.sharingContentShowAllButton.hidden=YES;
        [_sharingContentShowAllButton setTitle:@"" forState:UIControlStateNormal];
        [self.sharingContentShowAllButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mainSharingContentLabel.mas_bottom);
            make.left.mas_equalTo(self.avatarImageView.mas_right);
            make.height.mas_equalTo(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
    }
    
    [self.contentView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"self.contentView---2 %lu , %@",(unsigned long)idx, obj);
        //        if ( obj.firstAttribute==NSLayoutAttributeHeight) {
        //            NSLog(@"self.contentView--2 %lu , %@",(unsigned long)idx, obj);
        //        }
    }];
    [self.sharingImagesContainerView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"self.sharingImagesContainerView---2 %lu , %@",(unsigned long)idx, obj);
        //        if ( obj.firstAttribute==NSLayoutAttributeHeight) {
        //            NSLog(@"self.sharingImagesContainerView--2 %lu , %@",(unsigned long)idx, obj);
        //        }
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
//        _mainSharingContentLabel.scrollEnabled=NO;
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

//-( FLXKTwoSharingPictureLayoutView *)sharingImagesContainerView{
//    if (!_sharingImagesContainerView) {
//        _sharingImagesContainerView= [[FLXKTwoSharingPictureLayoutView alloc]init];
//        [self.contentView addSubview:_sharingImagesContainerView];
////        _sharingImagesContainerView.translatesAutoresizingMaskIntoConstraints=NO;
//    }
//    return   _sharingImagesContainerView;
//}


#pragma mark - Overriden methods

#pragma mark - Navigation

@end
