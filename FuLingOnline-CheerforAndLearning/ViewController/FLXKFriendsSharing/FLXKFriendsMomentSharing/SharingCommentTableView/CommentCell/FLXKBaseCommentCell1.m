//
//  FLXKCommentCell.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/31.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKBaseCommentCell1.h"

#import "NSAttributedString+EmotionExtension.h"


#define FONT_COLOR [UIColor colorWithRed:73/255.0 green:119/255.0 blue:154/255.0 alpha:1.0]

@interface FLXKBaseCommentCell1()<UITextViewDelegate>

@end

@implementation FLXKBaseCommentCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    self.commentTextView.backgroundColor=[UIColor blueColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(SharingCommentCellModel *)model{
    _model=model;
    self.commentTextView.scrollEnabled=NO;
    self.commentTextView.backgroundColor=[UIColor yellowColor];
    self.commentTextView.editable=NO;
    self.commentTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.commentTextView.delegate = self;
    self.commentTextView.attributedText=[self getCommentString:model];
}

-(NSAttributedString*)getCommentString:(SharingCommentCellModel *)model{
    NSMutableAttributedString* content=[[NSMutableAttributedString alloc]initWithString:@""];
    [content appendAttributedString:[self getURLInteractAttributeString:model.fromUserName]];
    if (model.toUserName) {
        [content appendAttributedString:[[NSAttributedString alloc]initWithString:@"回复"]];
        [content appendAttributedString:[self getURLInteractAttributeString:model.toUserName]];
    }
    [content appendAttributedString:[[NSAttributedString alloc]initWithString:@":"]];
    [content appendAttributedString:[NSAttributedString attributedStringWithPlainString: model.content]];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.paragraphSpacing =0;
    
    [content addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0],NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, content.length)];
    return content;
}

// 网址链接
-(NSAttributedString* )getURLInteractAttributeString:(NSString*)string{
    NSAttributedString* astr=[[NSAttributedString alloc]initWithString:string attributes:@{NSLinkAttributeName:@"www.baidu.com",NSForegroundColorAttributeName:FONT_COLOR}];
    return astr;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    __block    NSMutableAttributedString* str=[[NSMutableAttributedString alloc]initWithAttributedString: textView.attributedText];
    [str  setAttributes:@{NSBackgroundColorAttributeName:[UIColor whiteColor]} range:characterRange];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [str  setAttributes:@{NSBackgroundColorAttributeName:FONT_COLOR} range:characterRange];
    });
    NSLog(@"URL %@", URL);
    return YES;
}

@end
