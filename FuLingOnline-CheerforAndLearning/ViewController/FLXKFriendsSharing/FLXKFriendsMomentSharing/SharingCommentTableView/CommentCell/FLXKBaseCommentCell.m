//
//  FLXKCommentCell.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/31.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKBaseCommentCell.h"

#import "Masonry.h"

#import "MLLinkLabel.h"

@interface FLXKBaseCommentCell()<UITextViewDelegate>
@property(nonatomic,strong) MLLinkLabel* label;
@end

@implementation FLXKBaseCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setModel:(SharingCommentCellModel *)model{
    _model=model;
    self.label.attributedText=model.resultContent;
    [self.label setDidClickLinkBlock:^(MLLink *link, NSString *linkText, MLLinkLabel *label) {
        Router(Router_Launch_NotificationCenter)
        NSString *url = [NSString stringWithFormat:@"telprompt://%@",link.linkValue];
        NSLog(@"URL %@", url);
    }];
}

-(void)setupUI{
    _label=[MLLinkLabel new];
    _label.opaque=YES;
    _label.layer.masksToBounds=YES;
    _label.backgroundColor = [UIColor whiteColor];
    _label.numberOfLines=0;
    [self.contentView addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}

@end
