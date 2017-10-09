//
//  TimeCountDownView.h
//  YingYuanGeography
//
//  Created by 肖科 on 2017/8/17.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeCountDownView : UIView

-(instancetype)initWithFrame:(CGRect)frame timeout:(NSInteger)timeout timeEndedEventBlock:(void(^)())timeEndedEventBlock lastReminderTime:(NSInteger)lastReminderTime   lastReminderBlock:(void(^)())lastReminderBlock;

//启动
- (void)startTimer;

//停止
- (void)stop;

//取消
- (void)cancel;
@end
