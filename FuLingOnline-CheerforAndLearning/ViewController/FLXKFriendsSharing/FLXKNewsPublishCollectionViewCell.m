//
//  FLXKPublishCollectionViewCell.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/12/6.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "FLXKNewsPublishCollectionViewCell.h"

@implementation FLXKNewsPublishCollectionViewCell

//
//#pragma mark Keyboard
//-(void)keyboardWillChangeFrame:(NSNotification*)notif{
//    NSLog(@"keyboardChange:%@",[notif userInfo]);
//    float keyboadHeightBegin = 0;
//    float keyboadHeightEnd = 0;
//    float animationDuration = [[[notif userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    UIViewAnimationCurve animationCurve = [[[notif userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
//#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_3_2
//    CGRect keyboardBeginFrame = [[[notif userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    CGRect keyboardEndFrame = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    keyboadHeightBegin = 480 - keyboardBeginFrame.origin.y;
//    keyboadHeightEnd = 480 - keyboardEndFrame.origin.y;
//#else
//    //these deprecated after iOS 3.2
//    CGRect keyboardBounds = [[[notif userInfo] objectForKey:UIKeyboardBoundsUserInfoKey] CGRectValue];
//    CGPoint keybordCenterBegin = [[[notif userInfo] objectForKey:UIKeyboardCenterBeginUserInfoKey] CGPointValue];
//    CGPoint keybordCenterEnd = [[[notif userInfo] objectForKey:UIKeyboardCenterEndUserInfoKey] CGPointValue];
//    keyboadHeightBegin = 480 - (keybordCenterBegin.y - keyboardBounds.size.height / 2);
//    keyboadHeightEnd = 480 - (keybordCenterEnd.y - keyboardBounds.size.height / 2);
//#endif
//    NSLog(@"keyboardHeightChangeFrom:%.2f,To:%.2f",keyboadHeightBegin,keyboadHeightEnd);
//    return;
//    if (keyboadHeightEnd > 0) {
//        //keyboard show or change frame
//        [UIView animateWithDuration:animationDuration delay:0 options:animationCurve animations:^{
//        } completion:^(BOOL finished) {
//        }];
//    } else {
//        //keyboard hide
//    }
//}
//-(void)keyboardDidChangeFrame:(NSNotification*)notif{
//    //info like willChangeFrame
//}
//-(void)keyboardWillShow:(NSNotification*)notif{
//    //keyboard height will be 216, on iOS version older than 5.0
//    [UIView animateWithDuration:0.3f animations:^{
//        self.contentTableView.height = 480 - 44 - 216;
//    }];
//}
//-(void)keyboardWillHide:(NSNotification*)notif{
//    [UIView animateWithDuration:0.3f animations:^{
//        self.contentTableView.height = 480 - 44 - 28;
//    }];
//}
//-(void)registerKeyboardEvent{
//    float systemVer = [[[UIDevice currentDevice] systemVersion] floatValue];
//    if(systemVer >= 5.0) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
//    } else {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//    }
//}
//-(void)unregisterKeyboardEvent{
//    if([[[UIDevice currentDevice] systemVersion] floatValue] > 5.0) {
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
//    } else {
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//    }
//}

@end
