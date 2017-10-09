//
//  UITextView+Extensions.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/6/12.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extensions)
-(CGFloat)getTextViewWithAttributes:(NSDictionary*)attributes rows:(NSInteger)rows;
+(CGFloat)getTextViewWithAttributes:(NSDictionary*)attributes rows:(NSInteger)rows;
@end
