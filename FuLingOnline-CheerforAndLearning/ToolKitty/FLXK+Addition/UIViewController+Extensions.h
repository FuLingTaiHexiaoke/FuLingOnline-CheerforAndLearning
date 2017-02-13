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
@end
