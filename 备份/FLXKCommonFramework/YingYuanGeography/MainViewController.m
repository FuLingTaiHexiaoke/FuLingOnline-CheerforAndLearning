//
//  MainViewController.m
//  YingYuanGeography
//
//  Created by 肖科 on 17/7/21.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "MainViewController.h"

//Views
#import "CircleProgressButton.h"

//Entiy
#import "UserGameLockState.h"
//-(void)createTables
#import "EntitiesBridge.h"
#import <AVFoundation/AVFoundation.h>


@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic)UIImageView* animateBackgroundImageView;
@property (strong, nonatomic)AVAudioPlayer* musicPlayer;
@property (weak, nonatomic) IBOutlet UIImageView *starImageView;

//View Frame Placeholder
@property (weak, nonatomic) IBOutlet UIView *shiJieXingPlaceholder;
@property (weak, nonatomic) IBOutlet UIView *diMaoXingPlaceholder;
@property (weak, nonatomic) IBOutlet UIView *yuZhouXingPlaceholder;
@property (weak, nonatomic) IBOutlet UIView *sheHuiXingPlaceholder;
@property (weak, nonatomic) IBOutlet UIView *mingZuXingPlaceholder;
@property (weak, nonatomic) IBOutlet UIView *quYuXingPlaceholder;
@property (weak, nonatomic) IBOutlet UIView *qiHouXingPlaceholder;
@property (strong, nonatomic)NSArray<UIView*>*   viewsPlaceholder;

//ButtonImages
@property (strong, nonatomic) NSArray<NSString*>* circleButtonImages;
@property (strong, nonatomic) NSArray<NSString*>* circleButtonCoverImages;

//circleButton layers colors
@property (strong, nonatomic) NSArray<UIColor*>* circleButtonProgressColors;
@property (strong, nonatomic) NSArray<UIColor*>* circleButtonBGColors;

@property (strong, nonatomic) NSArray<UIColor*>* circleButtonFrontLabelColors;
@property (strong, nonatomic) NSArray<UIColor*>* circleButtonBGLabelColors;

//circleButton
@property (strong, nonatomic) NSMutableArray<CircleProgressButton*>* circleButtons;
@property (assign, nonatomic) BOOL isFirstAppear;
@end

@implementation MainViewController

#pragma mark - ViewController LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加返回按钮
    [self setupBackButton];
    
    //初始化UI
    [self setupUI];
    
    //初始化基础数据
    [self initBaseData];
    
    //添加CircleProgressButtons
    [self setupCircleProgressButtons];
    
    //创建数据表
    [self deleteTables];
    [self createTables];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self.view bringSubviewToFront:self.starImageView];
    
    //获取当前用户游戏数据
    if (!self.isFirstAppear) {
        [[FLXKSharedAppSingleton sharedSingleton]caculateUserGameLockStateWithCompleteBlock:^{
            //给CircleProgressButtons添加动画
            [self  animateCircleProgressButtons];
        }];
    }
    self.isFirstAppear=NO;
    
    [self.musicPlayer play];
}

#pragma mark - Public Methods

#pragma mark - Delegates

#pragma mark - Private Methods
//初始化UI
- (void)setupUI{
    self.animateBackgroundImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 2048, 1536)];
    self.animateBackgroundImageView.image=ImageNamed(@"MainViewController_background");
    self.animateBackgroundImageView.center=CGPointMake(1024, 0);
    [self.view insertSubview:self.animateBackgroundImageView belowSubview:self.backgroundImageView];
    
    //添加平移动画
    UIBezierPath* path=[UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(1024, 0)];
    [path addLineToPoint:CGPointMake(0, 768)];
    
    CAKeyframeAnimation * animation=[CAKeyframeAnimation animation];
    animation.keyPath=@"position";
    animation.path=path.CGPath;
    animation.calculationMode = kCAAnimationPaced;
    animation.fillMode=kCAFillModeForwards;
    animation.duration= 50.0f;
    animation.repeatCount=CGFLOAT_MAX;
    animation.removedOnCompletion = NO;
    // 始终保持最新的效果
    animation.fillMode = kCAFillModeForwards;
    
    [self.animateBackgroundImageView.layer addAnimation:animation forKey:@"imageView.layer"];
}

//初始化基础数据
- (void)initBaseData{
    
    self.circleButtons=[NSMutableArray array];
    //View Frame Placeholder
    self.viewsPlaceholder=@[self.shiJieXingPlaceholder,self.diMaoXingPlaceholder,self.yuZhouXingPlaceholder,self.sheHuiXingPlaceholder,self.mingZuXingPlaceholder,self.quYuXingPlaceholder,self.qiHouXingPlaceholder];
    
    //circleButton layers colors
    self.circleButtonProgressColors=@[shiJieXing_ProgressColor,diMaoXing_ProgressColor,yuZhouXing_ProgressColor,sheHuiXing_ProgressColor,mingZuXing_ProgressColor,quYuXing_ProgressColor,qiHouXing_ProgressColor];
    self.circleButtonBGColors=@[shiJieXing_BGColor,diMaoXing_BGColor,yuZhouXing_BGColor,sheHuiXing_BGColor,mingZuXing_BGColor,quYuXing_BGColor,qiHouXing_BGColor];
    
    self.circleButtonFrontLabelColors=@[shiJieXing_FrontLabelColor,diMaoXing_FrontLabelColor,yuZhouXing_FrontLabelColor,sheHuiXing_FrontLabelColor,mingZuXing_FrontLabelColor,quYuXing_FrontLabelColor,qiHouXing_FrontLabelColor];
    self.circleButtonBGLabelColors=@[shiJieXing_BGLabelColor,diMaoXing_BGLabelColor,yuZhouXing_BGLabelColor,sheHuiXing_BGLabelColor,mingZuXing_BGLabelColor,quYuXing_BGLabelColor,qiHouXing_BGLabelColor];
    
    //ButtonImages
    self.circleButtonImages=@[@"世界星球",@"地貌星球",@"宇宙星球",@"社会星球",@"民族星球",@"区域星球",@"气候星球"];
    self.circleButtonCoverImages=@[@"世界星球未解锁",@"地貌星球未解锁",@"宇宙星球未解锁",@"社会星球未解锁",@"民族星球未解锁",@"区域星球未解锁",@"气候星球未解锁"];
}

//添加CircleProgressButtons
- (void)setupCircleProgressButtons{
    [self.viewsPlaceholder enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CircleProgressButton *btn=[[CircleProgressButton alloc]initWithFrame:obj.frame withBuilder:^(CircleProgressButton *builder) {
            builder.frontColor=self.circleButtonProgressColors[idx];
            builder.backColor=self.circleButtonBGColors[idx];
            builder.frontLabelColor=self.circleButtonFrontLabelColors[idx];
            //            builder.backColor=self.circleButtonBGColors[idx];
            builder.imageName=self.circleButtonImages[idx];
            builder.coverImageName=self.circleButtonCoverImages[idx];
            
            UserGameLockState* userState = [self getRightUserGameLockStateWithIndex:idx];
            
            //            builder.taskPercent=idx/10.f;
            //            builder.isUnLock=idx%2?NO:NO;
            builder.taskPercent=userState.currentVCScore.integerValue/userState.for_expand3.floatValue;
            builder.taskScore=userState.currentVCScore.integerValue;
            //            builder.taskPercent=userState.currentVCScore.integerValue;
            builder.isUnLock=userState.currentVCIsUnlocked;
            builder.progressAnimationRepeatCount=1;
            builder.progressAnimationDuration=0.25;
        }];
        btn.tag=idx+10000;
        [btn addTarget:self action:@selector(circleProgressButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [self.view bringSubviewToFront:btn];
        [self.circleButtons addObject:btn];
    }];
}

//给CircleProgressButtons添加动画
- (void)animateCircleProgressButtons{
    [self.circleButtons enumerateObjectsUsingBlock:^(CircleProgressButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UserGameLockState* userState = [self getRightUserGameLockStateWithIndex:idx];
        obj.taskPercent=userState.currentVCScore.integerValue/userState.for_expand3.floatValue;
        obj.taskScore=userState.currentVCScore.integerValue;
        obj.isUnLock=userState.currentVCIsUnlocked;
        [obj addCircleProgressAnimationToShaperLayer];
    }];
}

//给CircleProgressButtons添加动画
- (void)circleProgressButtonClickAction:(CircleProgressButton *)sender{
    if (!sender.isUnLock && !DEBUG) {
        return;
    }
    [self.musicPlayer pause];
    [[FLXKSharedAppSingleton sharedSingleton] playButtonClickSound];
    UIViewController * vc;
    switch (sender.tag-10000) {
        case 0:
            vc=InstantiateVCWithName(@"ShiJieXingVC")
            break;
        case 1:
            vc=InstantiateVCWithName(@"DiMaoXingVC")
            break;
        case 2:
            vc=InstantiateVCWithName(@"YuZhouXingVC")
            break;
        case 3:
            vc=InstantiateVCWithName(@"SheHuiXingVC")
            break;
        case 4:
            vc=InstantiateVCWithName(@"MingZuXingVC")
            break;
        case 5:
            vc=InstantiateVCWithName(@"QuYuXingVC")
            break;
        case 6:
            vc=InstantiateVCWithName(@"QiHouXingVC")
            break;
        default:
            vc=InstantiateVCWithName(@"ShiJieXingVC")
            break;
            break;
    }
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (UserGameLockState*)getRightUserGameLockStateWithIndex:(NSInteger)index{
    __block UserGameLockState* userState;
    //找到正确对应的userGameLockState
    [[FLXKSharedAppSingleton sharedSingleton].userGameLockStates enumerateObjectsUsingBlock:^(UserGameLockState * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.currentVCNameDescription isEqualToString: self.circleButtonImages[index]]) {
            userState=obj;
            *stop=YES;
        }
    }];
    return userState;
}

//创建数据表
-(void)deleteTables{
    
}
-(void)createTables{
    
}

////添加返回按钮
//- (void)setupBackButton{
//    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(13+30, 4, 44, 44)];
//    [btn setImage:ImageNamed(@"返回") forState:UIControlStateNormal];
//    [btn setTitle:@""  forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//    [self.view bringSubviewToFront:btn];
//}

//添加返回按钮
- (void)setupBackButton{
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(2, 2, 74, 74)];
    btn.imageView.contentMode=UIViewContentModeCenter;
    [btn setImage:ImageNamed(@"返回") forState:UIControlStateNormal];
    [btn setTitle:@""  forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [self.view bringSubviewToFront:btn];
}

- (void)backAction:(UIButton *)sender {
    [self.animateBackgroundImageView.layer removeAllAnimations];
    self.animateBackgroundImageView.center=CGPointMake(0, 768);

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
