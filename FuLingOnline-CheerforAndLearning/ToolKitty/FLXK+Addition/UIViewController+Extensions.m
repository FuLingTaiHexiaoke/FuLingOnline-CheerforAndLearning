//
//  UIViewController+Extensions.m
//  Psy-CommonFramework
//
//  Created by 肖科 on 17/1/3.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "UIViewController+Extensions.h"

@implementation UIViewController (Extensions)
//提示框
- (void)showAlertWithMessage:(NSString*)message  comfirmAction:(dispatch_block_t)comfirmAction {
    [self showAlertWithTitle:@"系统提示" message:message comfirmAction:comfirmAction];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString*)message comfirmAction:(dispatch_block_t)comfirmAction {
    if (iOS8Later) {
        UIAlertController*   alertControllerVersionCheck = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [ alertControllerVersionCheck addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            
        }]];
        [alertControllerVersionCheck addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            if (comfirmAction) {
                comfirmAction();
            }
        }]];
        [self presentViewController:alertControllerVersionCheck animated:YES completion:nil];
    } else {
        __weak __typeof(self) weakSelf=self;
        UIAlertView*  alerViewVersionCheck= [[UIAlertView alloc] initWithTitle:title message:message delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alerViewVersionCheck show];
    }
}
//手势
-(void)registerGestureForResignViewEditing{
    UITapGestureRecognizer* tapGestureRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignViewEditing)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
-(void)resignViewEditing{
    [self.view endEditing:YES];
}

@end
