//
//  FLXKSharingCellModel.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "SharingCommentCellModel.h"

#import "NSAttributedString+EmotionExtension.h"

#import "FriendsMomentSharingConfig.h"

@implementation SharingCommentCellModel

+(NSAttributedString*)getCommentString:(SharingCommentCellModel *)model{
    NSMutableAttributedString* content=[[NSMutableAttributedString alloc]initWithString:@""];
    [content appendAttributedString:[self getURLInteractAttributeString:model.fromUserName]];
    if (isNotEmptyString(model.toUserName)) {
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
+(NSAttributedString* )getURLInteractAttributeString:(NSString*)string{
    NSAttributedString* astr=[[NSAttributedString alloc]initWithString:string attributes:@{NSLinkAttributeName:@"www.baidu.com",NSForegroundColorAttributeName:COMMENT_USER_TEXT_FONT_COLOR}];
    return astr;
}

@end
