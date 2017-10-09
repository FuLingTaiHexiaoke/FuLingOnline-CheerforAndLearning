//
//  UIViewController+Extensions.h
//  Psy-CommonFramework
//
//  Created by 肖科 on 17/1/3.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extensions)

//Alert
- (void)showAlertWithMessage:(NSString*)message  comfirmAction:(dispatch_block_t)comfirmAction;
- (void)showAlertWithTitle:(NSString *)title message:(NSString*)message comfirmAction:(dispatch_block_t)comfirmAction;

//手势
-(void)registerGestureForResignViewEditing;

/**
 *  判断某个类是否有某个参数，防止 setvalue forkey 崩溃
 *
 */
- (BOOL)hasVariableWithClass:(Class) myClass varName:(NSString *)name;
@end
