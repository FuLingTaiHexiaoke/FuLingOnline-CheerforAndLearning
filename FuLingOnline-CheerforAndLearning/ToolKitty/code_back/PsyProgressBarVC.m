////
////  ProgressBarVC.m
////  XKTestMathSecond
////
////  Created by 肖科 on 2017/11/14.
////  Copyright © 2017年 apple. All rights reserved.
////
//
//#import "PsyProgressBarVC.h"
//#import "AppDelegate.h"
//
//#define ProgressWidth 1024
//#define ProgressHeigh 13
//
//#define SYSTEM_VERSION        [[[UIDevice currentDevice] systemVersion] floatValue]
//// 屏幕高度
//#define SCREEN_HEIGHT         [[UIScreen mainScreen] bounds].size.height
//// 屏幕宽度
//#define SCREEN_WIDTH          [[UIScreen mainScreen] bounds].size.width
//
//@interface PsyProgressBarVC ()
//@property(nonatomic,strong) CAShapeLayer* maskLayer;
//@property(nonatomic,strong) CALayer* maskLayer1;
//@property(nonatomic,strong) dispatch_source_t timer;
//@property(nonatomic,assign) NSInteger timeUsed;
//@property(nonatomic,strong) UILabel* tipLabel;
//@end
//
//@implementation PsyProgressBarVC
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    //  self.view.backgroundColor=[[UIColor blueColor]colorWithAlphaComponent:0.3];
//    //    self.view.backgroundColor=[UIColor clearColor];
//    //    [self setupProgressBar];
//
////    [self registerNotification];
//    [self addUserInfoTip];
//}
//
//- (void)dealloc{
//    [self removeNotification];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}
//
//- (void)setupProgressBar{
//    CAGradientLayer* grl=[CAGradientLayer layer];
//    grl.frame = CGRectMake(0,0, ProgressWidth, ProgressHeigh);
//    grl.colors=@[(id)[UIColor greenColor].CGColor,(id)[UIColor yellowColor].CGColor,(id)[UIColor redColor].CGColor];
//    grl.locations = @[@(0.65f) ,@(0.8f),@(1.0f)];
//    grl.startPoint=CGPointMake(0.0, 1.0);
//    grl.endPoint=CGPointMake(1.0, 1.0);
//    grl.cornerRadius=5.0;
//    [self.view.layer addSublayer:grl];
//
//    //mask layer
//    self.maskLayer=[CAShapeLayer layer];
//    self.maskLayer.frame = CGRectMake(0,0, ProgressWidth, ProgressHeigh);
//    self.maskLayer.fillColor=[UIColor whiteColor].CGColor;
//    UIBezierPath* path=[UIBezierPath bezierPathWithRoundedRect:self.maskLayer.frame cornerRadius:5.0 ];
//    self.maskLayer.path=path.CGPath;
//    [self.view.layer addSublayer:self.maskLayer];
//    self.maskLayer.position=CGPointMake(-ProgressWidth/2, ProgressHeigh/2);
//    grl.mask=self.maskLayer;
//}
//
//- (void)setupTimer:(NSNotification*)notification{
//    self.timeUsed=0;
//    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
//    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
//    dispatch_source_set_event_handler(timer, ^{
//        [self checkTimeout];
//    });
//    dispatch_resume(timer);
//    self.timer=timer;
//
//    [self addUserInfoTip];
//}
//
//- (void)checkTimeout{
//    CGFloat  testTimeout = [PsySegueJumpHelper sharedInstance].projectParameters.testTimeout.floatValue;
//    if (self.timeUsed<testTimeout) {
//        self.timeUsed++;
//        [PsySegueJumpHelper sharedInstance].currentTestTime=self.timeUsed;
//        //        CGFloat x = self.timeUsed/testTimeout*ProgressWidth-ProgressWidth/2;
//        //        dispatch_async(dispatch_get_main_queue(), ^{
//        //            self.maskLayer.position=CGPointMake(x, ProgressHeigh/2);
//        //        });
//    }
//    else{
//        dispatch_source_cancel(self.timer);
//        self.timer=nil;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //                ((AppDelegate*)[UIApplication sharedApplication].delegate).window1.hidden=YES;
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"TimeEnd" object:@"math"];
//        });
//    }
//}
//
//- (void)cleanTimer:(NSNotification*)notification{
//
//    dispatch_source_cancel(self.timer);
//    self.timer=nil;
//    [self.tipLabel removeFromSuperview];
//
//    self.timeUsed=-10;
//    [self checkTimeout];
//}
//
//- (void)addUserInfoTip{
//    NSString * TestName =  [[NSUserDefaults standardUserDefaults] objectForKey:@"testName"];
//    CGRect frame;
//    if(SYSTEM_VERSION >= 8.0) {
//        frame =CGRectMake(ProgressWidth/2,ProgressHeigh+2, ProgressWidth, 20);
//    }
//    else{
//        frame= CGRectMake(0,SCREEN_WIDTH-80+(ProgressHeigh+2), ProgressWidth, 20);
//    }
//
//    UILabel* label=[[UILabel alloc]initWithFrame:frame];
//    //    label.text=[NSString stringWithFormat:@"  %@-%@-%@-%@  ",testSchool,testGrade,TestClass,TestName];
//    label.text=[NSString stringWithFormat:@"  %@  ",TestName];
//    label.backgroundColor=[[UIColor blueColor]colorWithAlphaComponent:0.5];
//    label.layer.cornerRadius=10.0;
//    label.layer.masksToBounds=YES;
//    label.textColor=[UIColor whiteColor];
//    [label sizeToFit];
//    CGPoint center = label.center;
//    label.center=CGPointMake(ProgressWidth/2, center.y);
//    [self.view addSubview:label];
//    self.tipLabel=label;
//}
//
//
//
//- (void)applicationDidChangeStatusBarOrientation:(NSNotification*)notification{
//    UIInterfaceOrientation orientation =  [UIApplication sharedApplication].statusBarOrientation;
//    switch (orientation) {
//        case UIInterfaceOrientationLandscapeLeft:
//            if(SYSTEM_VERSION >= 8.0) {
//                ((AppDelegate*)[UIApplication sharedApplication].delegate).window1.frame=CGRectMake(0,0, 1024, 50);
//            }
//            else{
//                ((AppDelegate*)[UIApplication sharedApplication].delegate).window1.frame=CGRectMake(0, 0, 80, SCREEN_HEIGHT);
//                self.tipLabel.center=CGPointMake(self.tipLabel.center.x,ProgressHeigh+2+10);
//            }
//            break;
//        case UIInterfaceOrientationLandscapeRight:
//            if(SYSTEM_VERSION >= 8.0) {
//                ((AppDelegate*)[UIApplication sharedApplication].delegate).window1.frame=CGRectMake(0,0, 1024, 50);
//            }
//            else{
//                ((AppDelegate*)[UIApplication sharedApplication].delegate).window1.frame=CGRectMake(SCREEN_WIDTH-80, 0, 80, SCREEN_HEIGHT);
//                self.tipLabel.center=CGPointMake(self.tipLabel.center.x,SCREEN_WIDTH-80+(ProgressHeigh+2)+10);
//            }
//
//            break;
//        default:
//            break;
//    }
//    if(SYSTEM_VERSION < 8.0) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            ((AppDelegate*)[UIApplication sharedApplication].delegate).window1.hidden=NO;
//        });
//    }
//}
//- (void)applicationWillChangeStatusBarOrientation:(NSNotification*)notification{
//    ((AppDelegate*)[UIApplication sharedApplication].delegate).window1.hidden=YES;
//}
//
//-(void)registerNotification
//{
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidChangeStatusBarOrientation:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
//    if(SYSTEM_VERSION < 8.0) {
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationWillChangeStatusBarOrientation:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
//    }
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setupTimer:) name:@"ProgressBarVCSetupTimerNotification" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cleanTimer:) name:@"ProgressBarVCCleanTimerNotification" object:nil];
//}
//
//-(void)removeNotification
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ProgressBarVCSetupTimerNotification" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ProgressBarVCCleanTimerNotification" object:nil];
//}
//
//@end

