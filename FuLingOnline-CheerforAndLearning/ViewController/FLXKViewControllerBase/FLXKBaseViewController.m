//
//  HomeNewsViewController.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/11/23.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "FLXKBaseViewController.h"


@interface FLXKBaseViewController()

@end
@implementation FLXKBaseViewController

#pragma mark - ViewController LifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - NAVIGATION SETTING
-(void)setupOwnNavigationAppearance{
//    self.title = @"Test VC";
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.barTintColor =NAVIGATION_BAR_TOP_BARTINTCOLOR;
//    self.navigationController.navigationBar.tintColor =NAVIGATION_BAR_TOP_TINTCOLOR;
//    self.navigationController.navigationBar.translucent = YES;
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
}
@end
