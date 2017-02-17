//
//  UIAlertController+Extensions.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/12/6.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "UIAlertController+Extensions.h"

@implementation UIAlertController (Extensions)
+ (void)showAlertWithTitle:(NSString *)title withPresentingController:(UIViewController*)presentingController {
    if (iOS8Later) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [presentingController presentViewController:alertController animated:YES completion:nil];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
#pragma clang diagnostic pop
    }
}
@end
