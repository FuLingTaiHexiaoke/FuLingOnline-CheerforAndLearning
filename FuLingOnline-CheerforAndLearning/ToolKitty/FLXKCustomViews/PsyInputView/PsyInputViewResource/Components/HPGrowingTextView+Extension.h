//
//  HPGrowingTextView+Extension.h
//  Psy-TeachersTerminal
//
//  Created by 肖科 on 16/9/12.
//  Copyright © 2016年 apple. All rights reserved.
//
#import <HPGrowingTextView/HPGrowingTextView.h>
#import "FaceKeyBoard.h"
#import "FunctionKeyboard.h"
#import "FaceViewController.h"

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

@interface HPGrowingTextView (Extension)
//@property (nonatomic,strong) FaceKeyBoard * faceKeyboard;
@property (nonatomic,strong) FaceViewController * faceKeyboard;
@property (nonatomic,strong) FunctionKeyboard * functionKeyboard;

@property (nonatomic,strong) NSManagedObjectContext * managedObjectContext;
//@property (nonatomic,strong) FaceKeyBoard * faceKeyboard;
//@property (nonatomic,strong) FunctionKeyboard * functionKeyboard;
@property (nonatomic,strong) NSArray * faceArray;

- (void)changeKeyboardType:(InputViewType)type;
@end
