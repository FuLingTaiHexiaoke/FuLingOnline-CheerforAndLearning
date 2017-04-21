//
//  FLXKMessageToolBar.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/20.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//
#pragma mark - Declarations and macros

#import "FLXKMessageToolBartest1.h"
//utilites
#import "Masonry.h"
//child viewController
//models
//subviews
#import "HPGrowingTextView.h"

@interface FLXKMessageToolBartest1 ()<HPGrowingTextViewDelegate>
//IBOutlet
@property (weak, nonatomic) IBOutlet HPGrowingTextView *growingTextView;
//IBAction
//models
//UI state record properties
//subviews
//child viewController
@end

@implementation FLXKMessageToolBartest1
#pragma mark -  LifeCircle

- (instancetype)initWithCustomFrame:(CGRect)frame{
    NSArray* nibViews =  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class)  owner:nil options:nil];
    FLXKMessageToolBartest1*  messageToolBar=[nibViews objectAtIndex:0];
           NSLog(@"messageToolBar frame %@", NSStringFromCGRect(messageToolBar.frame));
        messageToolBar.frame=frame;
//    NSLog(@"messageToolBar frame1 %@", NSStringFromCGRect(messageToolBar.frame));
//
//    messageToolBar.growingTextView.delegate=messageToolBar;
//    HPGrowingTextView* textView= messageToolBar.growingTextView;
//    textView.isScrollable = NO;
//    textView.contentInset =  UIEdgeInsetsMake(5, 0, 5, 0);
//            NSLog(@"textView.frame %@", NSStringFromCGRect(textView.frame));
//    
//    textView.frame=textView.frame;
//    
//    textView.minNumberOfLines = 1;
//    textView.maxNumberOfLines = 6;
//    // you can also set the maximum height in points with maxHeight
//    // textView.maxHeight = 200.0f;
//    textView.returnKeyType = UIReturnKeyGo; //just as an example
//    textView.font = [UIFont systemFontOfSize:15.0f];
//    //    textView.delegate = self;
//    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
//    textView.backgroundColor = [UIColor whiteColor];
//    textView.placeholder = @"Type to see the textView grow!";
    
    return messageToolBar;
}

//-(void)dealloc{
//    NSLog(@"%@ 销毁",NSStringFromClass(self.class));
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}
//

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect r = self.bounds;
 NSLog(@"messageToolBar layoutSubviews  %@", NSStringFromCGRect( r));
}

#pragma mark - Delegate
- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
    CGRect r = self.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    self.frame = r;
    
    CGFloat   newHeight=r.size.height;
    CGFloat  newOrigin=r.origin.y;
//    [self layoutIfNeeded];
//    [UIView animateWithDuration:0.1 animations:^{
//        NSLog(@"Delegate growingTextView %@", NSStringFromCGRect(r));
//        [self mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(newHeight);
//            make.top.mas_equalTo(self.superview).offset(newOrigin);
//        }];
//        [self layoutIfNeeded];
//    }];
    
}
#pragma mark - Public methods
#pragma mark - View Event
#pragma mark - Model Event
#pragma mark - Private methods
#pragma mark - getter/setter
#pragma mark - Overriden methods

#pragma mark - Navigation

// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// [segue destinationViewController].
// }
@end
