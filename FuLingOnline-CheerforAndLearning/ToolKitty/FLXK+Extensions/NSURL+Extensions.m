//
//  NSURL+Extensions.m
//  Psy-CommonFramework
//
//  Created by 肖科 on 17/1/11.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "NSURL+Extensions.h"

@implementation NSURL (Extensions)


////文字固定宽度下，获取动态高度
//-(CGFloat)getBoundingHeightWithWidth:(CGFloat)width font:(UIFont*)font {
//    //init attribute
//    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//    [style setLineBreakMode:NSLineBreakByWordWrapping];
//    NSDictionary *attribute = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
//    
//    //get Rect
//    CGSize size=CGSizeMake(width, CGFLOAT_MAX);
//    CGRect labelRect= [self boundingRectWithSize:size options: (NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)  attributes:attribute context:nil];
//    
//    //reture height
//    return labelRect.size.height;
//}


///**
// * 解析URL参数的工具方法。
// */
-(NSDictionary *)parseURLParamsToDic{
    NSArray *pairs = [[self query] componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        if (kv.count == 2) {
            NSString *val =[[kv objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [params setObject:val forKey:[kv objectAtIndex:0]];
        }
    }
    if (params.count==0) {
        params=nil;
    }
    return params;
}

///*
// * 使用传入的baseURL地址和参数集合构造含参数的请求URL的工具方法。
// */
//+ (NSURL*)generateURL:(NSString*)baseURL params:(NSDictionary*)params {
//    if (params) {
//        NSMutableArray* pairs = [NSMutableArray array];
//        for (NSString* key in params.keyEnumerator) {
//            NSString* value = [params objectForKey:key];
//            NSString* escaped_value = (NSString *)CFURLCreateStringByAddingPercentEscapes(
//                                                                                          NULL, /* allocator */
//                                                                                          (CFStringRef)value,
//                                                                                          NULL, /* charactersToLeaveUnescaped */
//                                                                                          (CFStringRef)@"!*'();:@&=+$,/?%#[]",
//                                                                                          kCFStringEncodingUTF8);
//
//            [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
//            [escaped_value release];
//        }
//
//        NSString* query = [pairs componentsJoinedByString:@"&"];
//        NSString* url = [NSString stringWithFormat:@"%@?%@", baseURL, query];
//        return [NSURL URLWithString:url];
//    } else {
//        return [NSURL URLWithString:baseURL];
//    }
//}

/*
 * 根据指定的参数名，从URL中找出并返回对应的参数值。
 */
+ (NSString *)getValueStringFromUrl:(NSString *)url forParam:(NSString *)param {
    NSString * str = nil;
    NSRange start = [url rangeOfString:[param stringByAppendingString:@"="]];
    if (start.location != NSNotFound) {
        NSRange end = [[url substringFromIndex:start.location + start.length] rangeOfString:@"&"];
        NSUInteger offset = start.location+start.length;
        str = end.location == NSNotFound
        ? [url substringFromIndex:offset]
        : [url substringWithRange:NSMakeRange(offset, end.location)];
        str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }

    return str;
}

/**
 * 对输入的字符串进行MD5计算并输出验证码的工具方法。
 */
//+ (NSString *)md5HexDigest:(NSString *)input{
//    const char* str = [input UTF8String];
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(str, strlen(str), result);
//    NSMutableString *returnHashSum = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
//    for (int i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
//        [returnHashSum appendFormat:@"%02x", result[i]];
//    }
//    return returnHashSum;
//}

/**
 * 计算sig码的工具方法。
 */
//+ (NSString *)generateSig:(NSMutableDictionary *)paramsDict secretKey:(NSString *)secretKey{
//    NSMutableString* joined = [NSMutableString string];
//    NSArray* keys = [paramsDict.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
//    for (id obj in [keys objectEnumerator]) {
//        id value = [paramsDict valueForKey:obj];
//        if ([value isKindOfClass:[NSString class]]) {
//            [joined appendString:obj];
//            [joined appendString:@"="];
//            [joined appendString:value];
//        }
//    }
//    [joined appendString:secretKey];
//    return [self md5HexDigest:joined];
//}

/**
 * 对字符串进行URL编码转换。
 */
+ (NSString*)encodeString:(NSString*)string urlEncode:(NSStringEncoding)encoding {
    NSMutableString *escaped = [NSMutableString string];
    [escaped setString:[string stringByAddingPercentEscapesUsingEncoding:encoding]];

    [escaped replaceOccurrencesOfString:@"&" withString:@"%26" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
    [escaped replaceOccurrencesOfString:@"+" withString:@"%2B" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
    [escaped replaceOccurrencesOfString:@"," withString:@"%2C" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
    [escaped replaceOccurrencesOfString:@"/" withString:@"%2F" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
    [escaped replaceOccurrencesOfString:@":" withString:@"%3A" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
    [escaped replaceOccurrencesOfString:@";" withString:@"%3B" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
    [escaped replaceOccurrencesOfString:@"=" withString:@"%3D" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
    [escaped replaceOccurrencesOfString:@"?" withString:@"%3F" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
    [escaped replaceOccurrencesOfString:@"@" withString:@"%40" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
    [escaped replaceOccurrencesOfString:@" " withString:@"+" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
    [escaped replaceOccurrencesOfString:@"\t" withString:@"%09" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
    [escaped replaceOccurrencesOfString:@"#" withString:@"%23" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
    [escaped replaceOccurrencesOfString:@"<" withString:@"%3C" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
    [escaped replaceOccurrencesOfString:@">" withString:@"%3E" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
    [escaped replaceOccurrencesOfString:@"\"" withString:@"%22" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
    [escaped replaceOccurrencesOfString:@"\n" withString:@"%0A" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];

    return escaped;
}

+ (NSDate *)getDateFromString:(NSString *)dateTime
{
    NSDate *expirationDate =nil;
    if (dateTime != nil) {
        int expVal = [dateTime intValue];
        if (expVal == 0) {
            expirationDate = [NSDate distantFuture];
        } else {
            expirationDate = [NSDate dateWithTimeIntervalSinceNow:expVal];
        }
    }
    return expirationDate;
}

//+ (UIImage *)getImageWithWatermark:(UIImage *)inImage{
//    CGRect imageViewFrame = CGRectMake(0, 0, inImage.size.width, inImage.size.height);
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:inImage];
//    imageView.frame = imageViewFrame;
//    UILabel *label = [[UILabel alloc] init];
//    CGRect labelFrame = CGRectMake(10, imageViewFrame.size.height-40, imageViewFrame.size.width-20, 30);
//    label.frame = labelFrame;
//    label.text = kWatermarkString;
//    label.textAlignment = UITextAlignmentRight;
//    label.backgroundColor = [UIColor clearColor];
//    [imageView addSubview:label];
//
//    UIGraphicsBeginImageContext(imageViewFrame.size);
//    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *outImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    return outImage;
//}

@end
