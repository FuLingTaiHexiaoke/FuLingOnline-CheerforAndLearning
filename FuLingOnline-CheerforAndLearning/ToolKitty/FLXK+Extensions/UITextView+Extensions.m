//
//  UITextView+Extensions.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/6/12.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "UITextView+Extensions.h"

@implementation UITextView (Extensions)

-(CGFloat)getTextViewWithAttributes:(NSDictionary*)attributes rows:(NSInteger)rows{
    NSMutableAttributedString *newText =[[NSMutableAttributedString alloc]initWithString:@"-" ];
    for (int i = 1; i < rows; ++i){
        [newText  appendAttributedString:[[NSMutableAttributedString alloc]initWithString:@"\n|W|"]];
    }
    [newText addAttributes:attributes range:NSMakeRange(0, newText.length)];
    self.attributedText = newText;
    CGFloat Full_Width=[UIScreen mainScreen].bounds.size.width;
    return ceilf([self sizeThatFits:CGSizeMake(Full_Width, MAXFLOAT)].height);
}

+(CGFloat)getTextViewWithAttributes:(NSDictionary*)attributes rows:(NSInteger)rows{
       CGFloat Full_Width=[UIScreen mainScreen].bounds.size.width;
    UITextView* textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, Full_Width, 100)];
    NSMutableAttributedString *newText =[[NSMutableAttributedString alloc]initWithString:@"-" ];
    for (int i = 1; i < rows; ++i){
        [newText  appendAttributedString:[[NSMutableAttributedString alloc]initWithString:@"\n|W|"]];
    }
    [newText addAttributes:attributes range:NSMakeRange(0, newText.length)];
    textView.attributedText = newText;
    return ceilf([textView sizeThatFits:CGSizeMake(Full_Width, MAXFLOAT)].height);
}


@end
