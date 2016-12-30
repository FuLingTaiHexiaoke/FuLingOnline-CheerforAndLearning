//
//  HPGrowingTextView+Extension.m
//  Psy-TeachersTerminal
//
//  Created by 肖科 on 16/9/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HPGrowingTextView+Extension.h"

@implementation HPGrowingTextView (Extension)

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化Manager

        // 获取所有表情
        NSString * path = [[NSBundle mainBundle]pathForResource:@"Faces" ofType:@"plist"];
        self.faceArray = [NSArray arrayWithContentsOfFile:path];

        self.functionKeyboard = [[FunctionKeyboard alloc]initWithFrame:CGRectMake(0, 0,FULL_WIDTH, 271)];
        self.functionKeyboard.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //      __block  __weak  __typeof(self) * copy_self = self;
        //        self.functionKeyboard.functionKeyboardBlock = ^(NSInteger index){
        //            if ([copy_self.delegate respondsToSelector:@selector(myTextView:didTapFunctionKeyboardButton:)])
        //            {
        //                [copy_self.myTextViewDelegate myTextView:copy_self didTapFunctionKeyboardButton:index];
        //            }
        //        };

        self.faceKeyboard = [[FaceViewController alloc]initWithFrame:CGRectMake(0, 0,FULL_WIDTH, 271)];
        self.faceKeyboard.backgroundColor = [UIColor greenColor];
        //        self.faceKeyboard.faceKeyboadDelegate = self;
        //        self.faceKeyboard.faceKeyboadDataSource = self;
        //        self.faceKeyboard.faceKeyboardBlock = ^(NSInteger tag){
        //            if (copy_self.myTextViewBlock) {
        //                copy_self.myTextViewBlock(copy_self.text);
        //                copy_self.text = nil;
        //            }
        //        };
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%@ is dealloc",[self class]);
}

#pragma mark - changeKeyBoard
- (void)changeKeyboardType:(InputViewType)type
{
    switch (type)
    {
        case KeyboardSystem:
        {
            self.internalTextView.inputView = nil;
            break;
        }
        case KeyboardFunction:
        {
            self.internalTextView.inputView = self.functionKeyboard;
            break;
        }
        case KeyboardEmotion:
        {
            self.internalTextView.inputView = self.faceKeyboard;
            break;
        }
        default:
            break;
    }
    //    [self.inputView removeFromSuperview];
    
    
    if (self.isFirstResponder)
    {
        [self reloadInputViews];
    }else
    {
        [self becomeFirstResponder];
    }
}
@end
