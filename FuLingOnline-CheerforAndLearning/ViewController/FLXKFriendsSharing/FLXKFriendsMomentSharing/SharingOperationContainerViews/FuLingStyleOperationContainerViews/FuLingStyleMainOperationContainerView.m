//
//  FuLingStyleMainOperationContainerView.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/17.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//
#pragma mark - Declarations and macros

#import "FuLingStyleMainOperationContainerView.h"
//utilites
//child viewController
//models
//subviews
@interface FuLingStyleMainOperationContainerView ()
//IBOutlet
@property (weak, nonatomic) IBOutlet UIButton *thumberupThisNewsButton;

//IBAction
- (IBAction)broadcastThisNewsButtonAction:(UIButton *)sender;
- (IBAction)thumberupThisNewsButtonAction:(UIButton *)sender;
- (IBAction)CommentThisNewsButtonAction:(UIButton *)sender;
//models
//UI state record properties
//subviews
//child viewController
@end

@implementation FuLingStyleMainOperationContainerView

#pragma mark - ViewController LifeCircle

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do view setup here.
//}
//
//-(void)dealloc{
//    NSLog(@"%@ 销毁",NSStringFromClass(self.class));
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}
//

#pragma mark - Delegate
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
- (IBAction)broadcastThisNewsButtonAction:(UIButton *)sender {
}
@end
