//
//  FLXKNavigationTitleSegmentsView.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/2/28.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKNavigationTitleSegmentsView.h"
#import "UIView+Extensions.h"

@interface FLXKNavigationTitleSegmentsView()

//DATA
@property(nonatomic,strong) NSMutableArray<UIButton*>* showingButtons;
@property(nonatomic,assign) NSInteger* selectIndex;

//UI
@property(nonatomic,strong) CALayer* selectIndexLine;
@property(nonatomic,assign) CGFloat button_width;
@property(nonatomic,assign) CGPoint  oldPosition;

@end

@implementation FLXKNavigationTitleSegmentsView

#pragma mark -
#pragma mark - LifeCircle

- (void)drawRect:(CGRect)rect {
    //self set
    

    self.showingButtons=[NSMutableArray array];
    NSInteger  titlesCount= self.viewControllerTitles.count;
    CGFloat button_width= _button_width=self.width/titlesCount;
    CGFloat button_height=30;
    //draw buttons
    [self.viewControllerTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(button_width*idx, 0, button_width, button_height)];
        btn.tag=idx;
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitleColor:_titleColor forState:UIControlStateNormal];
        [btn setTitleColor:_titleSelectedColor  forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(titleClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [_showingButtons addObject:btn];
        
        if (_currentTitleIndex==idx) {
            btn.selected=YES;
        }
    }];
    //draw base line layer
    CGFloat bottom_line_height=_bottomLineHeight;
    CGFloat line_origin_y=self.height-bottom_line_height;
    
    
    _selectIndexLine=[CALayer layer];
    _selectIndexLine.frame=CGRectMake(0, line_origin_y, button_width, bottom_line_height);
    _selectIndexLine.backgroundColor=_bottomLineColor.CGColor;
    [self.layer addSublayer:_selectIndexLine];
    CGFloat centerY= CGRectGetMidY(_selectIndexLine.frame);
    CGFloat centerX= CGRectGetMidX(_selectIndexLine.frame);
    _oldPosition=CGPointMake(centerX,centerY);
}


#pragma mark -
#pragma mark - Public Methods

-(void)setCurrentTitleIndex:(NSInteger)currentTitleIndex{
    
    NSInteger selectedIndex=currentTitleIndex;
    if (_currentTitleIndex==selectedIndex) {
        return;
    }
    
    _currentTitleIndex=selectedIndex;
    [_showingButtons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected=NO;
        if (idx==currentTitleIndex) {
             obj.selected=YES;
        }
    }];
    
    //start animation
    [self beginAnimation:selectedIndex];
    
    if (self.titleSegmentSelectedBlock) {
        self.titleSegmentSelectedBlock(selectedIndex);
    }
}

#pragma mark -
#pragma mark - Private Methods

//button action to change the showing style
-(void)titleClicked:(UIButton*)sender{
    [self setCurrentTitleIndex:sender.tag];
}

-(void)beginAnimation:(NSInteger)selectedIndex{
    CGFloat centerY= CGRectGetMidY(_selectIndexLine.frame);
    CGPoint  newPosition=CGPointMake((selectedIndex+0.5)*_button_width,centerY);

    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    anim.duration = 0.2;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.fromValue =[NSValue valueWithCGPoint: _oldPosition]  ;
    anim.toValue = [NSValue valueWithCGPoint:newPosition] ;
    anim.repeatCount=1;
    //keep state
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion =NO;
    [_selectIndexLine addAnimation:anim forKey:@"FLXKNavigationTitleSegmentsViewClickAmination"];

    _oldPosition=newPosition;
}

@end
