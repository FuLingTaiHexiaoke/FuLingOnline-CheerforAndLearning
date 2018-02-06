//
//  FLXKSectionHeaderView.m
//  Psy-CommonFramework
//
//  Created by 肖科 on 17/1/6.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "FLXKSectionHeaderView.h"
#import "SectionHeaderViewModel.h"
@interface FLXKSectionHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation FLXKSectionHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.contentView.backgroundColor=[UIColor yellowColor];
//    self.titleLabel.layer.cornerRadius=15;
    self.titleLabel.layer.cornerRadius= self.titleLabel.size.height/2;
    self.titleLabel.layer.masksToBounds=YES;
    [self addGestureRecognizer];
}

-(void)addGestureRecognizer{
    UITapGestureRecognizer* tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerViewTaped:)];
    [self addGestureRecognizer:tapGesture];
}

-(void)setTitleModel:(SectionHeaderViewModel*)titleModel{
    self.titleLabel.text=titleModel.mainTitle;
}
-(void)headerViewTaped:(UITapGestureRecognizer *)tap{
    FLXKSectionHeaderView* tapedHeaderView=(  FLXKSectionHeaderView*) tap.view;
    if ([self.delegate respondsToSelector:@selector(headerView:didTapedAtIndex:)]) {
        [self.delegate headerView:tapedHeaderView didTapedAtIndex:tapedHeaderView.titleModel.sectionIndex];
    }
}
@end
