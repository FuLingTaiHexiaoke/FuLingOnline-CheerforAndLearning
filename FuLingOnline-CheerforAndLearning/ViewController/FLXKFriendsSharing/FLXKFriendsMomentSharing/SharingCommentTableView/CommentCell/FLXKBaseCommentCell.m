//
//  FLXKCommentCell.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/31.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKBaseCommentCell.h"

@implementation FLXKBaseCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SharingCommentCellModel *)model{
    _model=model;
    self.testlabel.text=model.nickName;
}


@end
