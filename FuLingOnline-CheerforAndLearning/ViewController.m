//
//  ViewController.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/10/11.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//





#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageview.image=[UIImage imageNamed:@"Spark"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//utilites


//child viewController


//subviews


//IBOutlet

//IBAction

#if DEBUG

#endif

#pragma mark -
#pragma mark - ViewController LifeCircle

-(void)dealloc{
  NSLog(@"%@ 销毁",NSStringFromClass(self.class));
}

#pragma mark -
#pragma mark - Memory Warning

#pragma mark -
#pragma mark - UI Delegates
#pragma mark - UICollectionViewDataSource

#pragma mark -
#pragma mark - Public Methods

#pragma mark -
#pragma mark - Private Methods

//#define NSAssert1(condition, desc, arg1) NSAssert((condition), (desc), (arg1))
//#define NSAssert2(condition, desc, arg1, arg2) NSAssert((condition), (desc), (arg1), (arg2))
//#define NSAssert3(condition, desc, arg1, arg2, arg3) NSAssert((condition), (desc), (arg1), (arg2), (arg3))
//#define NSAssert4(condition, desc, arg1, arg2, arg3, arg4) NSAssert((condition), (desc), (arg1), (arg2), (arg3), (arg4))
//#define NSAssert5(condition, desc, arg1, arg2, arg3, arg4, arg5) NSAssert((condition), (desc), (arg1), (arg2), (arg3), (arg4), (arg5))
//#define NSParameterAssert(condition) NSAssert((condition), @"Invalid parameter not satisfying: %@", @#condition)
@end
