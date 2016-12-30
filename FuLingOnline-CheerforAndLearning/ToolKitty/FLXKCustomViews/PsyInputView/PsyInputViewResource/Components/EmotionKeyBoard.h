//
//  FaceViewController.h
//  psylife
//
//  Created by 肖科 on 16/9/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DeleteEmotionOrText)();
typedef void (^ClickEmotion)(NSString* emotionName,NSString* imageName);

@interface EmotionKeyBoard : UIView

@property(nonatomic,strong)NSMutableArray *faces;
@property(nonatomic,strong)UIScrollView *faceScroll;

@property(nonatomic)ClickEmotion clickEmotionBlock;
@property(nonatomic)DeleteEmotionOrText deleteEmotionOrTextBlock;
//@property(nonatomic,strong)void (^block1)(NSString* name);

-(id)initWithFrame:(CGRect)frame;

@end
