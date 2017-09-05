//
//  NSString+Extensions.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/12/22.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "NSString+Extensions.h"


@implementation NSString (Extensions)

//文字固定宽度下，获取动态高度
-(CGFloat)getBoundingHeightWithWidth:(CGFloat)width font:(UIFont*)font {
    //init attribute
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    NSDictionary *attribute = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
    
    //get Rect
    CGSize size=CGSizeMake(width, CGFLOAT_MAX);
    CGRect labelRect= [self boundingRectWithSize:size options: (NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)  attributes:attribute context:nil];
    
    //reture height
   return labelRect.size.height;
    
    
//    //   NSParagraphStyleAttributeName 段落的风格（设置首行，行间距，对齐方式什么的）看自己需要什么属性，写什么
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineSpacing = 10;// 字体的行间距
//    paragraphStyle.firstLineHeadIndent = 20.0f;//首行缩进
//    paragraphStyle.alignment = NSTextAlignmentJustified;//（两端对齐的）文本对齐方式：（左，中，右，两端对齐，自然）
//    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;//结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
//    paragraphStyle.headIndent = 20;//整体缩进(首行除外)
//    paragraphStyle.tailIndent = 20;//
//    paragraphStyle.minimumLineHeight = 10;//最低行高
//    paragraphStyle.maximumLineHeight = 20;//最大行高
//    paragraphStyle.paragraphSpacing = 15;//段与段之间的间距
//    paragraphStyle.paragraphSpacingBefore = 22.0f;//段首行空白空间/* Distance between the bottom of the previous paragraph (or the end of its paragraphSpacing, if any) and the top of this paragraph. */
//    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;//从左到右的书写方向（一共??三种）
//    paragraphStyle.lineHeightMultiple = 15;/* Natural line height is multiplied by this factor (if positive) before being constrained by minimum and maximum line height. */
//    paragraphStyle.hyphenationFactor = 1;//连字属性 在iOS，唯一支持的值分别为0和1
//    
//    
//    
//    
//    
//    
//    
//    /*
//     NSFontAttributeName 字体大小
//     NSParagraphStyleAttributeName 段落的风格（设置首行，行间距，对齐方式什么的）
//     NSKernAttributeName 字间距
//     */
//    NSDictionary *attributes = @{
//                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
//                                 NSParagraphStyleAttributeName:paragraphStyle,
//                                 NSKernAttributeName:@(10),
//                                 
//                                 };
//    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
}


//判断是否为整形：

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：

- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (NSString *)randomText {
    CGFloat length = arc4random() % 150 + 5;
    
    NSMutableString *str = [[NSMutableString alloc] init];
    for (NSUInteger i = 0; i < length; ++i) {
        [str appendString:@" 测试数据，"];
    }
   
    return str;
}



//将数字1，2，3转化成A,B,C
- (NSString*)convertNumToCharacter:(NSInteger)number{
   return  [NSString stringWithFormat:@"%c", 65+number];
    
//    //to convert the selected and right answer index with 'A' 'B' 'C'...
//    NSString* selectedAnswerIndex=@"";
//    NSString*  itemRightAnswerIndex=@"";
//    for (int i=0; i<imagesNameArray.count; i++) {
//        if ([selectedAnswer isEqualToString:imagesNameArray[i]]) {
//            selectedAnswerIndex=[NSString stringWithFormat:@"%c", 65+i];
//        }
//        if ([itemRightAnswer isEqualToString:imagesNameArray[i]]) {
//            itemRightAnswerIndex=[NSString stringWithFormat:@"%c", 65+i];
//        }
//    }
}

- (void)NSlogTest{
    //    NSLog(@"字符串:%@",f);
    //    NSLog(@"字符:%c",f);
    //    NSLog(@"整形:%i",f);
    //    NSLog(@"单精度浮点数： %f",f);
    //    NSLog(@"精度浮点数,且只保留两位小数:%.2f",f);
    //    NSLog(@"科学技术法:%e",f);
    //    NSLog(@"科学技术法(用最简短的方式):%g",f);
    //    NSLog(@"同时打印两个整数：,f=%f",f);
//function:-[CircleProgressButton addCircleProgressAnimationToShaperLayer] line:200 content:单精度浮点数： 5.000000
//    
//function:-[CircleProgressButton addCircleProgressAnimationToShaperLayer] line:201 content:精度浮点数,且只保留两位小数:5.00
//    
//function:-[CircleProgressButton addCircleProgressAnimationToShaperLayer] line:202 content:科学技术法:5.000000e+00
//    
//function:-[CircleProgressButton addCircleProgressAnimationToShaperLayer] line:203 content:科学技术法(用最简短的方式):5
//    
//function:-[CircleProgressButton addCircleProgressAnimationToShaperLayer] line:204 content:同时打印两个整数：,f=5.000000
}

@end
