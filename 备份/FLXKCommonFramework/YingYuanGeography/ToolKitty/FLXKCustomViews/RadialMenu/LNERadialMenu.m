//
//  LNERadialMenuView.m
//  LNERadialMenu
//
//  Created by Giuseppe Lanza on 24/03/13.
//  Copyright (c) 2013 La Nuova Era. All rights reserved.
//
typedef NS_ENUM(NSInteger, YDWavePathType) {
    YDWavePathType_Sin,
    YDWavePathType_Cos
};

#import "LNERadialMenu.h"

@interface LNERadialMenu()

@property (nonatomic, assign) CGFloat maxW;
@property (nonatomic, strong) NSMutableArray *elementsArray;
@property(nonatomic,strong) CAShapeLayer *greenLayerMask;
@property(nonatomic,strong) CADisplayLink *displayLink;
//波浪相关的参数
@property (nonatomic, assign) CGFloat waveWidth;
@property (nonatomic, assign) CGFloat waveHeight;
@property (nonatomic, assign) CGFloat waveMid;
@property (nonatomic, assign) CGFloat maxAmplitude;

@property (nonatomic, assign) CGFloat phaseShift;
@property (nonatomic, assign) CGFloat phase;
@property (nonatomic, assign) CGFloat frequency;

@end

@implementation LNERadialMenu

-(id)initWithFrame:(CGRect)frame{
    return [self initFromPoint:CGPointZero withDataSource:nil andDelegate:nil];
}

-(id)initFromPoint:(CGPoint)centerPoint withDataSource:(id<LNERadialMenuDataSource>)dataSource andDelegate:(id<LNERadialMenuDelegate>)delegate{
    //    self = [super initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].origin.x, [[UIScreen mainScreen] bounds].origin.y, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    if (iOS8Later) {
        self = [super initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].origin.x, [[UIScreen mainScreen] bounds].origin.y, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    }
    else{
        self = [super initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].origin.x, [[UIScreen mainScreen] bounds].origin.y, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width)];
    }
    
    if(self){
        centerPoint.y -= [[UIScreen mainScreen] bounds].origin.y;
        
        //		//Fix the center point in case it is too near the corners of the screen
        //		if(CGRectContainsPoint(CGRectMake(0, 0, 70, 70), centerPoint) && !CGPointEqualToPoint(centerPoint, CGPointZero)){
        //			_centerPoint = CGPointMake(70, 70);
        //		} else if(CGRectContainsPoint(CGRectMake(0, [[UIScreen mainScreen] applicationFrame].size.height-70, 70, 70), centerPoint)){
        //			_centerPoint = CGPointMake(70, [[UIScreen mainScreen] applicationFrame].size.height-70);
        //		} else if(CGRectContainsPoint(CGRectMake([[UIScreen mainScreen] applicationFrame].size.width-70, 0, 70, 70), centerPoint)){
        //			_centerPoint = CGPointMake([[UIScreen mainScreen] applicationFrame].size.width-70, 70);
        //		} else if(CGRectContainsPoint(CGRectMake([[UIScreen mainScreen] applicationFrame].size.width-70, [[UIScreen mainScreen] applicationFrame].size.height-70, 70, 70), centerPoint)){
        //			_centerPoint = CGPointMake([[UIScreen mainScreen] applicationFrame].size.width-70, [[UIScreen mainScreen] applicationFrame].size.height-70);
        //		} else
        _centerPoint = CGPointEqualToPoint(centerPoint, CGPointZero) ? self.center : centerPoint;
        
        _dataSource = dataSource;
        _delegate = delegate;
        
        self.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeRadialMenu:)];
        [self addGestureRecognizer:tapGesture];
        tapGesture.delegate = self;
    }
    
    return self;
}

-(void)dealloc{
    //    NSLog(@"%@ 销毁",NSStringFromClass(self.class));
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    BOOL should = YES;
    if([touch.view isKindOfClass:[UIButton class]]){
        should = NO;
    }
    
    return should;
}

-(void)closeRadialMenu:(UITapGestureRecognizer *)tapGesture{
    //    if([tapGesture.view isEqual:self] && !CGRectContainsPoint(self.radialMenuView.frame, [tapGesture locationInView:self])){
    //        [self closeMenu];
    //    }
    if([tapGesture.view isEqual:self]){
        [self closeMenu];
    }
}

-(void)closeMenuWithCompletion:(void(^)())completion{
    for(int i = 0; i < [self.elementsArray count]; i++){
        UIButton *element = [self.elementsArray objectAtIndex:i];
        double delayInSeconds = 0.025*i;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [UIView animateWithDuration:0.1 animations:^{
                element.alpha = 0;
                element.center = CGPointMake(self.radialMenuView.frame.size.width/2.0, self.radialMenuView.frame.size.height/2.0);
            }];
        });
    }
    
    double delayInSeconds = 0.05+0.025*[self.elementsArray count];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:0.01 animations:^{
            self.radialMenuView.alpha = 0;
            self.alpha = 0;
        } completion:^(BOOL finished) {
            //注册菜单关闭时，外部代理需要完成的额外工作。
            [self.radialMenuView removeFromSuperview];
            [self removeFromSuperview];
            if(completion) completion();
            if([self.delegate respondsToSelector:@selector(radialMenu:willCloseMenuWithCompletion:)]){
                [self.delegate radialMenu:self willCloseMenuWithCompletion:(void(^)()) completion];
            }
            
        }];
    });
}

-(void)closeMenu {
    [self closeMenuWithCompletion:nil];
}

-(void)generateRadialMenu{
    _menuRadius = 50;
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(radiusLenghtForRadialMenu:)]){
        _menuRadius = [self.dataSource radiusLenghtForRadialMenu:self];
    }
    
    _numberOfButtons = [self.dataSource numberOfButtonsForRadialMenu:self];
    
    _elementsArray = [[NSMutableArray alloc] init];
    _radialMenuView = [[UIView alloc] init];
    self.maxW = 0;
    for(int i = 0; i < _numberOfButtons; i++){
        JKPopMenuItem *element = [self.dataSource radialMenu:self elementAtIndex:i];
        if(self.maxW < element.frame.size.width) self.maxW = element.frame.size.width;
        element.userInteractionEnabled = YES;
        element.alpha = 0;
        //修改人:肖科    修改时间:2017-8-23  修改原因:element.tag用数据库中的tag值，方便数据库操作
        //修改前源码:--源码如下。
        element.tag = i;
        //修改前源码:修改如下--。
        //修改内容:--修改如下。
        
        UITapGestureRecognizer* tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapButton:)];
        [element addGestureRecognizer:tapGesture];
        
        [self.elementsArray addObject:element];
        
        [_radialMenuView addSubview:element];
    }
    
    _radialMenuView.frame = CGRectMake(0, 0, _menuRadius*2.0+self.maxW, _menuRadius*2.0+self.maxW);
    _radialMenuView.center = _centerPoint;
    _radialMenuView.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveAround:)];
    panGesture.delegate = self;
    
    if([self.dataSource respondsToSelector:@selector(canDragRadialMenu:)]){
        panGesture.enabled = [self.dataSource canDragRadialMenu:self];
    }
    
    [_radialMenuView addGestureRecognizer:panGesture];
    
    if([self.dataSource respondsToSelector:@selector(viewForCenterOfRadialMenu:)]){
        _centerRadialView = [self.dataSource viewForCenterOfRadialMenu:self];
        
        if(_centerRadialView){
            //修改人:肖科    修改时间:2017-8-9  修改原因:他们要求中间显示图片。此为正确调整中间图片的位置
            //修改前源码:--源码如下。
            //     _centerRadialView.frame = CGRectZero;
            //修改前源码:修改如下--。
            if (self.centerImageViewFrame.size.width<=0) {
                _centerRadialView.frame = CGRectZero;
            }
            //修改内容:--修改如下。
            
            _centerRadialView.center = CGPointMake(self.radialMenuView.frame.size.width/2.0, self.radialMenuView.frame.size.height/2.0);
            
            [_radialMenuView addSubview:_centerRadialView];
        }
    }
    
}

-(void)moveAround:(UIPanGestureRecognizer *)panGesture{
    if ((panGesture.state == UIGestureRecognizerStateChanged) || (panGesture.state == UIGestureRecognizerStateEnded)) {
        CGPoint translation = [panGesture translationInView:self];
        // move something in myself (I’m a UIView) by translation.x and translation.y
        // for example, if I were a graph and my origin was set by an @property called origin self.origin = CGPointMake(self.origin.x+translation.x, self.origin.y+translation.y);
        CGRect radialMenuRect = self.radialMenuView.frame;
        radialMenuRect.origin.x += translation.x;
        radialMenuRect.origin.y += translation.y;
        
        self.radialMenuView.frame = radialMenuRect;
        
        [self placeRadialMenuElementsAnimated:NO];
        
        [panGesture setTranslation:CGPointZero inView:self];
    }
}

-(void)didTapButton:(UITapGestureRecognizer *)gestureRecognizer{
    JKPopMenuItem * elementItem=(JKPopMenuItem *) gestureRecognizer.view;
    [self.delegate radialMenu:self didSelectButton:elementItem];
}

-(void) showMenu{
    [self showMenuWithCompletion:^(){
        //添加波浪效果动画
        //        [self addWaveAnimation];
    }];
}

-(UIColor *) dimBackgroundColor{
    if(!_dimBackgroundColor){
        _dimBackgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    }
    
    return _dimBackgroundColor;
}

-(void)showMenuWithCompletion:(void (^)())completion{
    [self generateRadialMenu];
    
    //    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    
    while (appRootVC.presentedViewController) {
        appRootVC=appRootVC.presentedViewController;
    }
    
    [appRootVC.view addSubview:self];
    [appRootVC.view  bringSubviewToFront:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = self.dimBackgroundColor;
    } completion:^(BOOL finished) {
        [self addSubview:self.radialMenuView];
        
        if([self.dataSource respondsToSelector:@selector(radialMenu:customizationForRadialMenuView:)]){
            [self.dataSource radialMenu:self customizationForRadialMenuView:self.radialMenuView];
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            if(_centerRadialView){
                //修改人:肖科    修改时间:2017-7-31  修改原因:控制中间圆圈的大小，使其更好看一点
                //修改前源码:--源码如下。
                //                CGFloat centerViewRadius = 7.0*self.menuRadius/20.0;
                //修改前源码:源码如下--。
                
                //修改内容:--修改如下。
                CGFloat centerViewRadius =self.maxW/2;
                //修改内容:修改如下--。
                //
                //                self.centerRadialView.layer.cornerRadius = centerViewRadius;
                //                self.centerRadialView.layer.masksToBounds = YES;
                //
                //                self.centerRadialView.frame = CGRectMake(self.radialMenuView.frame.size.width/2.0-centerViewRadius, self.radialMenuView.frame.size.height/2.0-centerViewRadius, centerViewRadius*2.0, centerViewRadius*2.0);
                
                
            }
            
        } completion:^(BOOL finished) {
            [self placeRadialMenuElementsAnimated:YES];
            if(completion)
                completion();
        }];
    }];
}

-(void)placeRadialMenuElementsAnimated:(BOOL)animated{
    CGFloat startingAngle = 0;
    CGFloat usableAngle = 2.0*M_PI;
    BOOL fullCircle = YES;
    
    //if the arc is too small all objects would be too near to be pressed, so we need to recalculate the radius and add something
    CGFloat radiusToAdd = 0;
    
    //Calculating visible circle's arc
    
    //LEFT BORDER
    if(self.radialMenuView.frame.origin.x < 0){
        fullCircle = NO;
        
        //BEGIN
        if(self.radialMenuView.frame.origin.y >0){
            CGFloat d = -(self.radialMenuView.frame.origin.x +self.menuRadius);
            startingAngle = -acosf((d+5)/(self.menuRadius +radiusToAdd));
        } else {
            
            CGFloat d = -(self.radialMenuView.frame.origin.y +self.menuRadius);
            startingAngle = asinf((d+self.maxW/2.0+5)/(self.menuRadius+radiusToAdd));
        }
        
        //END
        if(CGRectGetMaxY(self.radialMenuView.frame) <= self.frame.size.height){
            if(self.radialMenuView.frame.origin.y >0){
                usableAngle = -2*startingAngle;
            } else {
                CGFloat d = -(self.radialMenuView.frame.origin.x +self.menuRadius);
                CGFloat virtualAngle = acosf((d+5)/(self.menuRadius+radiusToAdd));
                usableAngle = 2*virtualAngle -(virtualAngle+startingAngle);
            }
        } else {
            CGFloat d = (CGRectGetMaxY(self.radialMenuView.frame)-self.frame.size.height -self.menuRadius);
            CGFloat virtualAngle = -asinf((d+5)/(self.menuRadius+radiusToAdd));
            usableAngle = -startingAngle+virtualAngle;
        }
    }
    
    //TOP BORDER
    if(self.radialMenuView.frame.origin.y < 0 && self.radialMenuView.frame.origin.x > 0 && CGRectGetMaxX(self.radialMenuView.frame) < self.frame.size.width){
        fullCircle = NO;
        
        CGFloat d = -(self.radialMenuView.frame.origin.y +self.menuRadius);
        startingAngle = asinf((d+self.maxW/2.0+5)/(self.menuRadius+radiusToAdd));
        
        usableAngle = M_PI-2*startingAngle;
        
    }
    
    //BOTTOM BORDER
    if(CGRectGetMaxY(self.radialMenuView.frame) > self.frame.size.height && self.radialMenuView.frame.origin.x > 0 && CGRectGetMaxX(self.radialMenuView.frame) < self.frame.size.width){
        fullCircle = NO;
        
        CGFloat d = (CGRectGetMaxY(self.radialMenuView.frame)-self.frame.size.height -self.menuRadius);
        startingAngle = M_PI+asinf((d+5)/(self.menuRadius+radiusToAdd));
        usableAngle = 2*M_PI-startingAngle-asinf((d+5)/(self.menuRadius+radiusToAdd));
        
    }
    
    //RIGHT BORDER
    if(CGRectGetMaxX(self.radialMenuView.frame) > self.frame.size.width){
        fullCircle = NO;
        
        //BEGIN
        if(CGRectGetMaxY(self.radialMenuView.frame) < self.frame.size.height){
            CGFloat d = self.menuRadius-(CGRectGetMaxX(self.radialMenuView.frame)-self.frame.size.width);
            startingAngle = acosf((d-5)/(self.menuRadius +radiusToAdd));
        } else {
            CGFloat d = (CGRectGetMaxY(self.radialMenuView.frame)-self.frame.size.height -self.menuRadius);
            startingAngle = M_PI+asinf((d+5)/(self.menuRadius+radiusToAdd));
            
        }
        
        //END
        if(self.radialMenuView.frame.origin.y > 0){
            CGFloat d = self.menuRadius-(CGRectGetMaxX(self.radialMenuView.frame)-self.frame.size.width);
            CGFloat virtualAngle = acosf((d-5)/(self.menuRadius +radiusToAdd));
            usableAngle = 2*M_PI-virtualAngle-startingAngle;
        } else {
            CGFloat d = -(self.radialMenuView.frame.origin.y +self.menuRadius);
            CGFloat virtualAngle = asinf((d+self.maxW/2.0+5)/(self.menuRadius+radiusToAdd));
            
            usableAngle = M_PI-virtualAngle-startingAngle;
        }
    }
    
    if (self.elementsArray.count==3&&fullCircle) {
        startingAngle=M_PI*3/2;
    }
    
    //Placing the objects
    for(int i = 0; i < [self.elementsArray count]; i++){
        UIButton *element = [self.elementsArray objectAtIndex:i];
        element.center = CGPointMake(self.radialMenuView.frame.size.width/2.0, self.radialMenuView.frame.size.height/2.0);
        double delayInSeconds = 0.025*i;
        
        void (^elementPositionBlock)(void) = ^{
            element.alpha = 1;
            [self.radialMenuView bringSubviewToFront:element];
            
            
            //            NSLog(@"%d radiusToAdd %@", i, @(radiusToAdd).stringValue);
            //            NSLog(@"%d _menuRadius %@",i,  @(_menuRadius).stringValue);
            //            NSLog(@"%d _menuRadius+radiusToAdd %@",i,  @(_menuRadius+radiusToAdd).stringValue);
            //            NSLog(@"%d startingAngle %@", i, @(startingAngle).stringValue);
            //            NSLog(@"%d usableAngle %@", i, @(usableAngle).stringValue);
            //            NSLog(@"%d fullCircle %@", i, @(fullCircle).stringValue);
            //            NSLog(@"%d  (self.numberOfButtons-(fullCircle ? 0 :1)) %@", i, @( (self.numberOfButtons-(fullCircle ? 0 :1))).stringValue);
            //            NSLog(@"%d   (startingAngle+usableAngle/(self.numberOfButtons-(fullCircle ? 0 :1))*(float)i)  %@", i, @( (startingAngle+usableAngle/(self.numberOfButtons-(fullCircle ? 0 :1))*(float)i) ).stringValue);
            //            NSLog(@"%d   (cos(startingAngle+usableAngle/(self.numberOfButtons-(fullCircle ? 0 :1))*(float)i))  %@", i, @( (cos(startingAngle+usableAngle/(self.numberOfButtons-(fullCircle ? 0 :1))*(float)i)) ).stringValue);
            //
            //            NSLog(@"%d  (sin(startingAngle+usableAngle/(self.numberOfButtons-(fullCircle ? 0 :1))*(float)i))  %@", i, @( (sin(startingAngle+usableAngle/(self.numberOfButtons-(fullCircle ? 0 :1))*(float)i)) ).stringValue);
            //
            //            NSLog(@"%d self.radialMenuView.frame.size.width/2.0 %@", i, @(self.radialMenuView.frame.size.width/2.0).stringValue);
            
            CGPoint endPoint = CGPointMake(self.radialMenuView.frame.size.width/2.0+(_menuRadius+radiusToAdd)*(cos(startingAngle+usableAngle/(self.numberOfButtons-(fullCircle ? 0 :1))*(float)i)), self.radialMenuView.frame.size.height/2.0+(_menuRadius+radiusToAdd)*(sin(startingAngle+usableAngle/(self.numberOfButtons-(fullCircle ? 0 :1))*(float)i)));
            //            NSLog(@"endPoint %@", NSStringFromCGPoint(endPoint));
            element.center = endPoint;
        };
        //        CATransform3D transform = CATransform3DIdentity;
        //        transform=CATransform3DRotate(transform,M_PI_2,0,0,1);
        //        element.layer.transform=transform;
        if(animated) {
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [UIView animateWithDuration:0.25 animations:elementPositionBlock];
            });
        } else elementPositionBlock();
    }
    
    
    
    //    CATransform3D transform = CATransform3DIdentity;
    //    transform=CATransform3DRotate(transform,-M_PI_2,0,0,1);
    //    self.radialMenuView.layer.transform=transform;
}

//添加波浪效果动画
- (void)addWaveAnimation{
    if (self.centerRadialView) {
        //1.添加green layer
        CALayer *greenLayer=[CALayer layer];
        greenLayer.backgroundColor=self.waveAnimationLayerColor?self.waveAnimationLayerColor.CGColor:[UIColor orangeColor].CGColor;
        greenLayer.frame=self.centerRadialView.bounds;
        [self.centerRadialView.layer addSublayer:greenLayer];
        //2.给green layer 添加mask
        CAShapeLayer *greenLayerMask=[CAShapeLayer layer];
        greenLayerMask.frame=CGRectMake(0, CGRectGetHeight(self.centerRadialView.bounds), CGRectGetWidth(self.centerRadialView.bounds), CGRectGetHeight(self.centerRadialView.bounds));
        greenLayer.mask=greenLayerMask;
        self.greenLayerMask=greenLayerMask;
        //3.给mask添加动画
        CABasicAnimation * anim=[CABasicAnimation animationWithKeyPath:@"position"];
        anim.fromValue=[NSValue valueWithCGPoint:greenLayerMask.position];
        anim.toValue=[NSValue valueWithCGPoint:CGPointMake(greenLayer.position.x, greenLayer.position.y) ];
        anim.removedOnCompletion=NO;
        anim.repeatCount=MAXFLOAT;
        anim.duration=2.0f;
        [greenLayerMask addAnimation:anim forKey:@"position"];
        //4.不断改变mask的path
        self.waveHeight = CGRectGetHeight(self.centerRadialView.bounds) * 0.5;
        self.waveWidth  = CGRectGetWidth(self.centerRadialView.bounds);
        self.frequency = .3;
        self.phaseShift = 8;
        self.waveMid = self.waveWidth / 2.0f;
        self.maxAmplitude = self.waveHeight * .3;
        
        [self.displayLink invalidate];
        self.displayLink=[CADisplayLink displayLinkWithTarget:self selector:@selector(updateWave:)];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)updateWave:(CADisplayLink *)displayLink
{
    self.phase += self.phaseShift;
    self.greenLayerMask.path = [self createWavePathWithType:YDWavePathType_Sin].CGPath;
}

- (UIBezierPath *)createWavePathWithType:(YDWavePathType)pathType
{
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    CGFloat endX = 0;
    for (CGFloat x = 0; x < self.waveWidth + 1; x += 1) {
        endX=x;
        CGFloat y = 0;
        if (pathType == YDWavePathType_Sin) {
            y = self.maxAmplitude * sinf(360.0 / _waveWidth * (x  * M_PI / 180) * self.frequency + self.phase * M_PI/ 180) + self.maxAmplitude;
        } else {
            y = self.maxAmplitude * cosf(360.0 / _waveWidth *(x  * M_PI / 180) * self.frequency + self.phase * M_PI/ 180) + self.maxAmplitude;
        }
        
        if (x == 0) {
            [wavePath moveToPoint:CGPointMake(x, y)];
        } else {
            [wavePath addLineToPoint:CGPointMake(x, y)];
        }
    }
    
    CGFloat endY = CGRectGetHeight(self.centerRadialView.bounds) + 10;
    [wavePath addLineToPoint:CGPointMake(endX, endY)];
    [wavePath addLineToPoint:CGPointMake(0, endY)];
    
    return wavePath;
}

@end
