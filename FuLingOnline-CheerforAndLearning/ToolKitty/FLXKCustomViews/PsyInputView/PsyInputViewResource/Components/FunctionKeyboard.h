//
//  FuncKeyboard.h
//  MyKeyboard
//
//  Created by 张鹏 on 16/1/1.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FunctionKeyboardBlock)(NSInteger index);

@interface FunctionKeyboard : UIView

@property (nonatomic,strong) FunctionKeyboardBlock functionKeyboardBlock;

@end
