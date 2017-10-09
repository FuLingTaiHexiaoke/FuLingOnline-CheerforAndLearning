//
//  TimeCountDownView.m
//  YingYuanGeography
//
//  Created by 肖科 on 2017/8/17.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "TimeCountDownView.h"

@interface TimeCountDownView ()
@property(nonatomic,strong) UILabel* timeLabel;
@property (nonatomic, assign) NSInteger  timeout;
@property (nonatomic, assign) NSInteger lastReminderTime;
@property (nonatomic, copy) void (^timeEndedEventBlock)();
@property (nonatomic, copy) void (^lastReminderBlock)();//最后提醒用户的时间事件
@property(nonatomic,strong) NSTimer* timer;
@property(nonatomic,strong) dispatch_source_t dispatch_source_timer;
@end

@implementation TimeCountDownView

-(instancetype)initWithFrame:(CGRect)frame timeout:(NSInteger)timeout timeEndedEventBlock:(void(^)())timeEndedEventBlock lastReminderTime:(NSInteger)lastReminderTime   lastReminderBlock:(void(^)())lastReminderBlock{
    self= [super initWithFrame:frame];
    if (self) {
        self.timeLabel=[[UILabel alloc]initWithFrame:self.bounds];
        self.timeLabel.font=[UIFont boldSystemFontOfSize:28.0];
        self.timeLabel.textColor=[UIColor whiteColor];
        self.timeLabel.textAlignment=NSTextAlignmentCenter;
        self.timeout=timeout;
        self.lastReminderTime=lastReminderTime;
        self.timeEndedEventBlock=timeEndedEventBlock;
        self.lastReminderBlock=lastReminderBlock;
        [self addSubview:self.timeLabel];
        
    }
    return self;
}

//启动
- (void)startTimer{
    __block int timeout=self.timeout; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.dispatch_source_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(self.dispatch_source_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //没秒执行
    dispatch_source_set_event_handler(self.dispatch_source_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(self.dispatch_source_timer);
            NSString *strTime = [NSString stringWithFormat:@"0:00"];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.timeLabel.text=strTime;
                //设置界面的按钮显示 根据自己需求设置
                if (self.timeEndedEventBlock) {
                    self.timeEndedEventBlock();
                }
            });
        }else{
            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d:%.2d",minutes, seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.timeLabel.text=strTime;
            });
            
            if (timeout==self.lastReminderTime && self.lastReminderTime>0 ) {
                //
                if (self.lastReminderBlock) {
                    self.lastReminderBlock();
                }
            }
            
            timeout--;
        }
    });
    dispatch_resume(self.dispatch_source_timer);
}

//停止
- (void)stop{
    dispatch_suspend(self.dispatch_source_timer);
}

//取消
- (void)cancel{
    dispatch_source_cancel(self.dispatch_source_timer);
    self.timeEndedEventBlock=nil;
    self.lastReminderBlock=nil;
}
@end
