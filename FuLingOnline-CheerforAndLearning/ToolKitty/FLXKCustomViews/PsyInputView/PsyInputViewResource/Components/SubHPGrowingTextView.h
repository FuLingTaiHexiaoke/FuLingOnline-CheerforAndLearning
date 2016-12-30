//
//  SubHPGrowingTextView.h
//  Psy-TeachersTerminal
//
//  Created by 肖科 on 16/9/12.
//  Copyright © 2016年 apple. All rights reserved.
//
//#import <HPGrowingTextView/HPGrowingTextView.h>
#import "HPGrowingTextView.h"
#import "FaceKeyBoard.h"
#import "FunctionKeyboard.h"
#import "EmotionKeyBoard.h"

typedef enum : NSUInteger {
    //    InputViewTypeVoice,
    //    InputViewTypeText,
    //    InputViewTypeEmotion,
    //    InputViewTypeFunction,
    KeyboardSystem,
    KeyboardVoice,
    KeyboardFunction,
    KeyboardEmotion,
} InputViewType;


@interface SubHPGrowingTextView : HPGrowingTextView
//@property (nonatomic,strong) FaceKeyBoard * faceKeyboard;
@property (nonatomic,strong) EmotionKeyBoard * faceKeyboard;
@property (nonatomic,strong) FunctionKeyboard * functionKeyboard;

@property (nonatomic,strong) NSManagedObjectContext * managedObjectContext;
//@property (nonatomic,strong) FaceKeyBoard * faceKeyboard;
//@property (nonatomic,strong) FunctionKeyboard * functionKeyboard;
@property (nonatomic,strong) NSArray * faceArray;

- (void)changeKeyboardType:(InputViewType)type;
- (NSString*)showPlainText;
@end
