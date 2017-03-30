//
//  GooeyCircle.m
//  KYAnimatedPageControl-Demo
//
//  Created by Kitten Yang on 6/11/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "GooeyCircle.h"
#import "KYAnimatedPageControl.h"
#import "KYSpringLayerAnimation.h"

@interface GooeyCircle()

@property(nonatomic,assign)CGFloat factor;

@end

@implementation GooeyCircle {
    BOOL beginGooeyAnim;
}

#pragma mark-- Initialize
- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithLayer:(GooeyCircle *)layer {
    self = [super initWithLayer:layer];
    if (self) {
        self.indicatorSize = layer.indicatorSize;
        self.indicatorColor = layer.indicatorColor;
        self.currentRect = layer.currentRect;
        self.lastContentOffset = layer.lastContentOffset;
        self.scrollDirection = layer.scrollDirection;
        self.factor = layer.factor;
        self.masksToBounds=NO;
    }
    return self;
}

#pragma mark-- override  class func

- (void)drawInContext:(CGContextRef)ctx {
    CGFloat offset =
    self.currentRect.size.width / 3.6; //设置3.6 出来的弧度最像圆形
    CGPoint rectCenter =
    CGPointMake(self.currentRect.origin.x + self.currentRect.size.width / 2,
                self.currentRect.origin.y + self.currentRect.size.height / 2);

    // 更新界面
    UIBezierPath *ovalPath = [UIBezierPath bezierPath];
//    [ovalPath moveToPoint:pointA];
    [ovalPath  addArcWithCenter:rectCenter radius:self.currentRect.size.width/ 2 startAngle:0 endAngle:-2*M_PI clockwise:NO];

    [ovalPath closePath];
    
    
    
    CGContextAddPath(ctx, ovalPath.CGPath);
    CGContextSetFillColorWithColor(ctx, self.indicatorColor.CGColor);
    CGContextFillPath(ctx);
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqual:@"factor"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

#pragma mark-- override superclass method
- (void)animateIndicatorWithScrollView:(UIScrollView *)scrollView
                   currentShowingRange:(NSRange)currentShowingRange{

    if ((scrollView.contentOffset.x - self.lastContentOffset) >= 0 &&
        (scrollView.contentOffset.x - self.lastContentOffset) <=
        (scrollView.frame.size.width) / 2) {
        self.scrollDirection = ScrollDirectionLeft;
    } else if ((scrollView.contentOffset.x - self.lastContentOffset) <= 0 &&
               (scrollView.contentOffset.x - self.lastContentOffset) >=
               -(scrollView.frame.size.width) / 2) {
        self.scrollDirection = ScrollDirectionRight;
    }

    NSInteger pageCount=currentShowingRange.length;
    
    //动态算出此时frame所需的实际宽度
    CGRect newFrame=self.frame;
    CGFloat newWidth=(pageCount - 1)*DISTANCE+ self.indicatorSize;
    newFrame.origin.x=(self.superlayer.frame.size.width-newWidth)/2;
    newFrame.size.width=newWidth;
    self.frame=newFrame;

    CGFloat currentRangeOffset=scrollView.contentOffset.x-currentShowingRange.location*scrollView.frame.size.width;
    CGFloat currentRangeContentLength=(currentShowingRange.length-1)*scrollView.frame.size.width;

    CGFloat originX = (currentRangeOffset / currentRangeContentLength) *
    (self.frame.size.width-self.indicatorSize);

    NSLog(@"originX:%f",originX);
    self.currentRect = CGRectMake(originX, self.frame.size.height / 2 - self.indicatorSize / 2,self.indicatorSize, self.indicatorSize);
    NSLog(@"frame %@", NSStringFromCGRect(self.frame ));

    NSLog(@"currentRect %@", NSStringFromCGRect(self.currentRect ));

    if (currentRangeOffset< 0 ||originX<0  || currentRangeOffset>(currentRangeContentLength)) {
        return;
    }
    
    [self setNeedsDisplay];
}

- (void)restoreAnimation:(id)howmanydistance {
    
    // Spring animation
    CAKeyframeAnimation *anim = [[KYSpringLayerAnimation sharedAnimManager]
                                 createSpringAnima:@"factor"
                                 duration:0.8
                                 usingSpringWithDamping:0.5
                                 initialSpringVelocity:3
                                 fromValue:@(0.5 + [howmanydistance floatValue] * 1.5)
                                 toValue:@(0)];
    anim.delegate = self;
    self.factor = 0;
    [self addAnimation:anim forKey:@"restoreAnimation"];
}

#pragma mark-- CAAnimation Delegate
- (void)animationDidStart:(CAAnimation *)anim {
    beginGooeyAnim = YES;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        beginGooeyAnim = NO;
        [self removeAllAnimations];
    }
}

@end
