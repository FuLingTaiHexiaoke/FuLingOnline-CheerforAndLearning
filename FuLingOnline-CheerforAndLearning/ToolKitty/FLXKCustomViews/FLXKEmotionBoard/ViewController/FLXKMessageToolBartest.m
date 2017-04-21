//
//  FLXKMessageToolBar.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/20.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//
#pragma mark - Declarations and macros

#import "FLXKMessageToolBartest.h"
//utilites
#import "Masonry.h"
//child viewController
//models
//subviews
#import "HPGrowingTextView.h"

@interface FLXKMessageToolBartest ()<HPGrowingTextViewDelegate>
//IBOutlet
@property (weak, nonatomic) IBOutlet HPGrowingTextView *growingTextView;
//IBAction
//models
//UI state record properties
//subviews
//child viewController
@end

@implementation FLXKMessageToolBartest

#pragma mark -  LifeCircle

- (instancetype)initWithCustomFrame:(CGRect)frame{
    NSArray* nibViews =  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class)  owner:nil options:nil];
    FLXKMessageToolBartest*  messageToolBar=[nibViews objectAtIndex:0];
//    messageToolBar.frame=frame;
    messageToolBar.growingTextView.delegate=messageToolBar;
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

#pragma mark - Delegate
- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
//    float diff = (growingTextView.frame.size.height - height);
//    
//    CGRect r = self.frame;
//    r.size.height -= diff;
//    r.origin.y += diff;
//    self.frame = r;
    
    float diff = (growingTextView.frame.size.height - height);
    
    CGRect r = self.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    //    self.frame = r;
    //
    CGFloat   newHeight=r.size.height;
    CGFloat  newOrigin=r.origin.y;
    NSLog(@"Delegate growing_textView %@", NSStringFromCGRect(r));
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(newHeight);
        make.top.mas_equalTo(self.superview).offset(newOrigin);
    }];
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
