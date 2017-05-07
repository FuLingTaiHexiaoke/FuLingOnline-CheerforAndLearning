//
//  FLXKtestTableViewCell.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by xiaoke on 17/5/6.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKtestTableViewCell.h"

#import "Masonry.h"

#import "FLXKTwoSharingPictureLayoutView.h"

#import "FLXKSharingCellModel.h"

#import "UIImageView+WebCache.h"

@interface FLXKtestTableViewCell ()
@property (strong, nonatomic)  UIImageView *avatarImageView;
@property (strong, nonatomic)  UILabel *nickNameLabel;
@property (strong, nonatomic)  UILabel *timestampLabel;
@property(nonatomic)FLXKTwoSharingPictureLayoutView* imagesView;

@end

@implementation FLXKtestTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

//        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
////            make.top.left.mas_equalTo(self.contentView);
//            make.top.mas_equalTo(self.contentView.mas_top);
//            make.left.mas_equalTo(self.contentView.mas_left);
//             make.height.mas_equalTo(46);
//               make.width.mas_equalTo(46);
////            make.width.mas_equalTo(self.avatarImageView.mas_height).multipliedBy(1);
//
//            //                make.bottom.mas_equalTo(self.mas_bottom);
//        }];

//        [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.avatarImageView.mas_top);
//            make.left.mas_equalTo(self.avatarImageView.mas_right);
//        }];

//        [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.contentView.mas_top);
//            make.left.mas_equalTo(self.contentView.mas_left);
//        }];
//
//        [self.timestampLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.nickNameLabel.mas_bottom);
//            make.left.mas_equalTo(self.nickNameLabel.mas_left);
//        }];

//                [self.textview mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.top.mas_equalTo(self.timestampLabel.mas_bottom).offset(8);
//                     make.left.mas_equalTo(self.contentView.mas_left);
////                    make.bottom.mas_equalTo(self.contentView.mas_bottom);
////                    make.height.mas_equalTo(0);
//                }];

//        [self.textview mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.right.left.mas_equalTo(self.contentView);
//            
////            make.bottom.mas_equalTo(self.contentView.mas_bottom);
//        }];

        [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
make.top.left.mas_equalTo(self.contentView);

            make.top.mas_equalTo(self.contentView.mas_top).offset(8);
            make.left.mas_equalTo(self.contentView.mas_left);
//            make.top.mas_equalTo(self.textview.mas_bottom);
            make.height.mas_equalTo(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];


//        self.contentView.translatesAutoresizingMaskIntoConstraints=NO;
//        //高度约束
//        //        containerHeight=self.emotionSwithButtonContainer.frame.size.height;
//        NSLayoutConstraint *heightCos = [NSLayoutConstraint constraintWithItem:self.imagesView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0 constant:0];
//        [self.imagesView addConstraint:heightCos];
//
//        NSLayoutConstraint *bottomCos1 = [NSLayoutConstraint constraintWithItem:self.imagesView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
//        [self.contentView addConstraint:bottomCos1];
//
//        //左边约束
//        NSLayoutConstraint *leftCos = [NSLayoutConstraint constraintWithItem:self.imagesView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
//        [self.contentView addConstraint:leftCos];
//
//        //底部约束
//        NSLayoutConstraint *bottomCos = [NSLayoutConstraint constraintWithItem:self.imagesView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
//        [self.contentView addConstraint:bottomCos];
//
//        //右边约束
//        NSLayoutConstraint *rightCos = [NSLayoutConstraint constraintWithItem:self.imagesView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
//        [self.contentView addConstraint:rightCos];
//

    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(FLXKSharingCellModel *)model{
//    [self.contentView setNeedsLayout];

//    [self.contentView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (obj.firstItem==self.contentView&& obj.firstAttribute==NSLayoutAttributeHeight) {
//            [self.contentView removeConstraint:obj];
//        }
//    }];
    _model=model;
//       [self.avatarImageView sd_setImageWithURL:NSURL_BaseURL(model.avatarImageUrl) placeholderImage:[UIImage imageNamed:@"Spark"]];
//        [self.avatarImageView setImage:[UIImage imageNamed:@"Spark"]];
//    self.nickNameLabel.text=model.nickName;
//    self.nickNameLabel.text=model.nickName;

//    self.timestampLabel.text=model.timestamp;

//    self.textview.text=model.mainSharingContent;
   [self.imagesView setImageArray:model.sharingImages];
    if (model.sharingImages.count>0) {
//        [self.imagesView setImageArray:model.sharingImages];
        CGFloat height=self.imagesView.viewHeight;
//            [self.imagesView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                if ( obj.firstAttribute==NSLayoutAttributeHeight) {
//                    obj.constant=height;
//                }
//            }];
        [self.imagesView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.left.mas_equalTo(self.contentView);
//            make.top.mas_equalTo(self.contentView.mas_top);
            make.height.mas_equalTo(height);
//            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
    }
    else{
//        [self.textview mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.right.left.mas_equalTo(self.contentView);
//           make.bottom.mas_equalTo(self.contentView.mas_bottom);
//        }];
        [self.imagesView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.left.mas_equalTo(self.contentView);
//            make.top.mas_equalTo(self.textview.mas_bottom);
            make.height.mas_equalTo(0);
//            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];

//        [self.imagesView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if ( obj.firstAttribute==NSLayoutAttributeHeight) {
//                obj.constant=0;
//            }
//        }];
    }
//    [self.contentView layoutIfNeeded];
}

-( UIImageView *)avatarImageView{
    if (!_avatarImageView) {
        _avatarImageView= [[UIImageView alloc]init];
        _avatarImageView.backgroundColor=[UIColor yellowColor];
        [self.contentView addSubview:_avatarImageView];
    }
    return   _avatarImageView;
}

-( UILabel *)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel= [[UILabel alloc]init];
           _avatarImageView.backgroundColor=[UIColor yellowColor];
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

-(UITextView*)textview{
    if (!_textview) {
      _textview=  [[UITextView alloc]init];
        _textview.scrollEnabled=NO;
        [self.contentView addSubview:_textview];
    }
    return _textview;
}
-(FLXKTwoSharingPictureLayoutView*)imagesView{
    if (!_imagesView) {
        _imagesView=  [[FLXKTwoSharingPictureLayoutView alloc]init];
       _imagesView.translatesAutoresizingMaskIntoConstraints=NO;
       [self.contentView addSubview:_imagesView];
    }
    return _imagesView;
}

@end
