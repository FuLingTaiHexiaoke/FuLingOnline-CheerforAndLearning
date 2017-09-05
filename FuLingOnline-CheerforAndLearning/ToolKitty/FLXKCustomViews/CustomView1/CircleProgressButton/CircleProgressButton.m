//
//  CircleProgressButton.m
//  test
//
//  Created by 肖科 on 17/7/19.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "CircleProgressButton.h"
#define ImageNamed1(name)  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:([name componentsSeparatedByString:@"."].count>1?nil:@"png")]]

@interface CircleProgressButton ()
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (strong,nonatomic) CAGradientLayer *circleLayer;
@property (weak,nonatomic)   NSTimer *circleTimer;
@property (strong,nonatomic) UIImageView* coverImageView;

@property (strong,nonatomic) UILabel* backgroundLabel;
@property (strong,nonatomic) UILabel* frontLabel;
@end


@implementation CircleProgressButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    
    //添加底图layer
    [self addBackgroundLayerWithFrame:self.frame];
    //添加shaper layer
    [self addShaperLayerWithFrame:self.frame];
    //给shaper layer 添加动画效果
    [self addCircleProgressAnimationToShaperLayer];
    //给button添加显示数据的label
    [self addProgressLabel:self.frame];
    
    //添加蒙版
    [self maskCoverImageViewWithFrame:self.frame];
    
    return self;
}



- (instancetype)initWithFrame:(CGRect)frame withBuilder:(InitBuilderBlock)initBuilderBlock{
    self=[super initWithFrame:frame];
    if (initBuilderBlock) {
        initBuilderBlock(self);
    }
    //添加底图
    [self setImage:ImageNamed1(self.imageName) forState:UIControlStateNormal];
    //添加layer底图
    [self addBackgroundLayerWithFrame:frame];
    //添加转动的shaper layer
    [self addShaperLayerWithFrame:frame];
    
    //    //给shaper layer 添加动画效果
    //    [self addCircleProgressAnimationToShaperLayer];
    
    //给button添加显示数据的label
    [self addProgressLabel:frame];
    
    //添加蒙版
    if (!self.isUnLock) {
        [self maskCoverImageViewWithFrame:frame];
    }
    
    return self;
}

//添加底图layer
- (void)addBackgroundLayerWithFrame:(CGRect)frame{
    //设定参数
    CGFloat defaultOffset=10;
    CGFloat buttonWidth=CGRectGetWidth(frame);
    CGFloat radius=buttonWidth/2-defaultOffset;
    CGRect shapeLayerFrame=CGRectMake(0, 0, buttonWidth, buttonWidth);
    
    UIBezierPath* path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(buttonWidth/2 ,buttonWidth/2) radius:radius startAngle:-M_PI/2  endAngle:M_PI/2*3 clockwise:YES];
    
    CAShapeLayer* shapeLayer=[CAShapeLayer layer];
    shapeLayer.path=path.CGPath;
    shapeLayer.frame=shapeLayerFrame;
    shapeLayer.strokeColor=[UIColor clearColor].CGColor;
    shapeLayer.fillColor=self.backColor?self.backColor.CGColor:default_backColor.CGColor;
    shapeLayer.strokeStart=0.0f;
    shapeLayer.strokeEnd=1.0f;
    shapeLayer.zPosition=-110;
    
    [self.layer addSublayer:shapeLayer];
}

//添加shaper layer
- (void)addShaperLayerWithFrame:(CGRect)frame{
    //设定参数
    CGFloat buttonWidth=CGRectGetWidth(frame);
    CGFloat radius=buttonWidth/2;
    CGFloat shapeLayerOriginX=buttonWidth*0.5/2;
    CGRect shapeLayerFrame=CGRectMake(shapeLayerOriginX, shapeLayerOriginX, radius, radius);
    
    UIBezierPath* path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(radius/2 ,radius/2) radius:radius*0.5 startAngle:(85/90.0f)*(-M_PI/2)  endAngle:M_PI/2*3 clockwise:YES];
    
    CAShapeLayer* shapeLayer=[CAShapeLayer layer];
    shapeLayer.path=path.CGPath;
    shapeLayer.frame=shapeLayerFrame;
    shapeLayer.strokeColor=self.frontColor?self.frontColor.CGColor:default_backColor.CGColor;
    shapeLayer.fillColor=[UIColor clearColor].CGColor;
    shapeLayer.lineWidth=70.0f;
    shapeLayer.strokeStart=0.0f;
    shapeLayer.strokeEnd=self.taskPercent?self.taskPercent:0.8f;
    shapeLayer.zPosition=-100;
    
    self.shapeLayer=shapeLayer;
    [self.layer addSublayer:shapeLayer];
}

//给button添加显示数据的label
- (void)addProgressLabel:(CGRect)frame{
    //设定参数
    CGFloat defaultOffset=8;
    CGFloat buttonWidth=CGRectGetWidth(frame);
    CGFloat halfWidth=buttonWidth/2;
    //x,y
    CGFloat x=halfWidth+defaultOffset;
    frame = CGRectMake(x, x, 40 , 25);
    CGFloat defaultFontSize = 15.0;
    //添加最底下的label
    UILabel * labelBackground=[[UILabel alloc]initWithFrame:frame];
    labelBackground.text=[NSString stringWithFormat:@"%.f%%", self.taskPercent*100];
    labelBackground.textColor=self.frontLabelColor;
    labelBackground.font=[UIFont boldSystemFontOfSize:defaultFontSize];
    labelBackground.layer.cornerRadius=5;
    //    labelBackground.adjustsFontSizeToFitWidth=YES;
    labelBackground.layer.masksToBounds=YES;
    self.backgroundLabel=labelBackground;
    [self addSubview:labelBackground];
    
    //添加shimmer效果的的label
//    UILabel * label=[[UILabel alloc]initWithFrame:frame];
//    label.text=[NSString stringWithFormat:@"%.f%%", self.taskPercent*100];
//    //    label.backgroundColor=self.frontLabelColor;
//    label.textColor=[UIColor whiteColor];
//    label.font=[UIFont boldSystemFontOfSize:defaultFontSize];
//    //    label.adjustsFontSizeToFitWidth=YES;
//    label.layer.cornerRadius=5;
//    label.layer.masksToBounds=YES;
//    self.frontLabel=label;
//    [self addSubview:label];
    
    //添加shimmer动画层
//    CAGradientLayer *circleLayer = [CAGradientLayer layer];
//    circleLayer.frame    =label.bounds;
//    
//    
//    circleLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
//                           (__bridge id)[UIColor whiteColor].CGColor,
//                           (__bridge id)[UIColor clearColor].CGColor];
//    // 颜色分割点
//    circleLayer.locations  = @[@(-0.4), @(-0.1), @(0.2)];
//    circleLayer.startPoint = CGPointMake(0, 0);
//    circleLayer.endPoint   = CGPointMake(1, 1);
//    
//    
//    label.layer.mask = circleLayer;
    
//    self.circleLayer=circleLayer;
    
//    [self gradientCircle];
}


-(void)gradientCircle{
    CABasicAnimation *rotationAnim = [CABasicAnimation animationWithKeyPath:@"locations"];
    rotationAnim.fromValue =@[@(-0.4), @(-0.1), @(0.2)];
    rotationAnim.toValue   = @[@(1.0), @(1.3), @(1.6)];
    rotationAnim.duration  = 2.0;
    rotationAnim.repeatCount=MAXFLOAT;
    rotationAnim.removedOnCompletion=NO;
    [self.circleLayer addAnimation:rotationAnim forKey:@"rotationAnim"];
}

//添加蒙版
- (void)maskCoverImageViewWithFrame:(CGRect)frame{
    self.coverImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetWidth(frame))];
    self.coverImageView.image=ImageNamed1(self.coverImageName);
    [self addSubview:self.coverImageView];
}

//给shaper layer 添加动画效果
- (void)addCircleProgressAnimationToShaperLayer{
    [self.shapeLayer removeAllAnimations];
    self.frontLabel.text=[NSString stringWithFormat:@"%.f%%", self.taskPercent*100];
    self.backgroundLabel.text=[NSString stringWithFormat:@"%.f%%", self.taskPercent*100];
    
    //remove cover
    if (self.isUnLock) {
        [self.coverImageView removeFromSuperview];
    }
    
    CABasicAnimation* anim=[CABasicAnimation animation];
    anim.keyPath=@"strokeEnd";
    anim.fromValue=@(0.0f);
    anim.toValue=@(self.taskPercent);
    anim.fillMode=kCAFillModeForwards;
    anim.timingFunction=[CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    anim.duration=self.progressAnimationDuration?self.progressAnimationDuration:default_progressAnimationDuration;
    anim.repeatCount=self.progressAnimationRepeatCount?self.progressAnimationRepeatCount:default_progressAnimationRepeatCount;
    anim.removedOnCompletion=NO;
    
    [self.shapeLayer addAnimation:anim forKey:@"addCircleProgressAnimationToShaperLayer"];
}


@end
