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

#import "FLXKtestUICollectionView.h"

static int viewTag=0;
@interface FLXKtestTableViewCell ()
@property(nonatomic)FLXKTwoSharingPictureLayoutView* imagesView;
@end

@implementation FLXKtestTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self.textview mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.right.left.mas_equalTo(self.contentView);
//            //                        make.bottom.mas_equalTo(self.contentView.mas_bottom);
//        }];
        [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView.mas_top);
            make.height.mas_equalTo(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];

        self.tag=viewTag;
        viewTag++;

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
    //    [self.contentView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        NSLog(@"self.tag: %lu self.contentView %lu , %@",self.tag,(unsigned long)idx, obj);
    //    }];
    //    [self.imagesView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        NSLog(@"self.tag: %lu self.sharingImagesContainerView %lu , %@",self.tag,(unsigned long)idx, obj);
    //    }];

    _model=model;
//    self.textview.text=model.mainSharingContent;


    //    [_imagesView removeFromSuperview];
    //    _imagesView=  [[FLXKTwoSharingPictureLayoutView alloc]init];
    //    [self.contentView addSubview:_imagesView];


    [self.imagesView setImageArray:model.sharingImages];
    CGFloat height=self.imagesView.viewHeight;
    //    CGFloat width=self.imagesView.viexwWidth;
    [self.imagesView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView.mas_top);
        //            make.height.mas_equalTo(height).priorityMedium();
        make.height.mas_equalTo(height);
        //        make.width.mas_equalTo(width);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];


    //    [self.contentView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        NSLog(@"-----22222   self.tag: %lu self.contentView %lu , %@",self.tag,(unsigned long)idx, obj);
    //    }];
    //    [self.imagesView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        NSLog(@"-----22222   self.tag: %lu self.sharingImagesContainerView %lu , %@",self.tag,(unsigned long)idx, obj);
    //    }];






    //    if (model.sharingImages.count>0) {
    ////        [self.imagesView setImageArray:model.sharingImages];
    //        CGFloat height=self.imagesView.viewHeight;
    //        [self.imagesView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //            make.right.left.mas_equalTo(self.contentView);
    //            make.top.mas_equalTo(self.textview.mas_bottom);
    ////            make.height.mas_equalTo(height).priorityMedium();
    //             make.height.mas_equalTo(height);
    //            make.bottom.mas_equalTo(self.contentView.mas_bottom);
    //        }];
    //    }
    //    else{
    ////        [self.textview mas_remakeConstraints:^(MASConstraintMaker *make) {
    ////            make.top.right.left.mas_equalTo(self.contentView);
    ////           make.bottom.mas_equalTo(self.contentView.mas_bottom);
    ////        }];
    //        [self.imagesView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //            make.right.left.mas_equalTo(self.contentView);
    //            make.top.mas_equalTo(self.textview.mas_bottom);
    ////            make.height.mas_equalTo(0).priorityMedium();
    // make.height.mas_equalTo(0);
    //            make.bottom.mas_equalTo(self.contentView.mas_bottom);
    //        }];
    //    }

}


// THIS IS THE MOST IMPORTANT METHOD
//
// This method tells the auto layout
// You cannot calculate the collectionView content size in any other place,
// because you run into race condition issues.
// NOTE: Works for iOS 8 or later
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority {

    // With autolayout enabled on collection view's cells we need to force a collection view relayout with the shown size (width)
//    self.imagesView.frame = CGRectMake(0, 0, targetSize.width, MAXFLOAT);
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
    CGFloat height=0;
//    [self.imagesView layoutIfNeeded];
   height+= self.imagesView.viewHeight;
//    height+= self.textview.bounds.size.height;
    // If the cell's size has to be exactly the content
    // Size of the collection View, just return the
    // collectionViewLayout's collectionViewContentSize.

    return CGSizeMake(width, height) ;
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
        _imagesView.backgroundColor=[UIColor yellowColor];
        //         _imagesView.translatesAutoresizingMaskIntoConstraints=NO;
        [self.contentView addSubview:_imagesView];
    }
    return _imagesView;
}

@end
