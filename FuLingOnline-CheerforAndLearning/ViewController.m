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
#pragma mark -
#pragma mark - ViewController LifeCircle

#pragma mark -
#pragma mark - Memory Warning

#pragma mark -
#pragma mark - UI Delegates
#pragma mark - UICollectionViewDataSource

#pragma mark -
#pragma mark - Public Methods

#pragma mark -
#pragma mark - Private Methods
@end
