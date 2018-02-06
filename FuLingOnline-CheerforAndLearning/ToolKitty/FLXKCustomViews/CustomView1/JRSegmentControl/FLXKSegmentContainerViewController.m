//
//  FLXKSegmentContainerViewController.m
//  Psy-CommonFramework
//
//  Created by xiaoke on 17/1/7.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "FLXKSegmentContainerViewController.h"
#import "JRSegmentControl.h"

@interface FLXKSegmentContainerViewController ()<JRSegmentControlDelegate>
@property(nonatomic,strong)    JRSegmentControl *segment;
@property(nonatomic,strong)    UIViewController *currentShowingVC;
@property(nonatomic,strong)    UIViewController *lastShowingVC;
@property(nonatomic,strong)    UIViewController *willShowingVC;
@end

@implementation FLXKSegmentContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.automaticallyAdjustsScrollViewInsets=YES;
    [self setupViewControllers];
    [self setupSegmentControl];
    [self showDefaultView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

/** 设置子视图控制器，这个方法必须在viewDidLoad方法里执行，否则子视图控制器各项属性为空 */
- (void)setupViewControllers
{
    int cnt = (int)self.viewControllers.count;
    for (int i = 0; i < cnt; i++) {
        if (i==0) {
            UIViewController *vc = self.viewControllers[i];
            [self addChildViewController:vc];
        }
        else{
//            UITableViewController *vc = self.viewControllers[i];
//            vc.tableView.contentInset =UIEdgeInsetsMake(64, 0, 0, 0);
//            vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
//            [self addChildViewController:vc];
            UIViewController *vc = self.viewControllers[i];
            [self addChildViewController:vc];
        }
    }
}

- (void)showDefaultView
{
    self.currentShowingVC=self.childViewControllers[0];
    [self.view addSubview:self.currentShowingVC.view];
    [self.currentShowingVC didMoveToParentViewController:self];
}

/** 设置segment */
- (void)setupSegmentControl
{
    //    _itemWidth = 60.0f;
    _itemWidth = 70.0f;
    // 设置titleView
    _segment = [[JRSegmentControl alloc] initWithFrame:CGRectMake(0, 0, _itemWidth * 3, 34.0f)];
    _segment.titles = self.titles;
    //    _segment.cornerRadius = 15.0f;
    _segment.cornerRadius = _segment.size.height/2;
    _segment.titleColor = self.titleColor;
    _segment.selectedTitleColor = self.selectedTitleColor;
    _segment.indicatorViewColor = self.indicatorViewColor;
    _segment.backgroundColor = self.segmentBgColor;
    
    _segment.layer.borderWidth=1.0;
    _segment.layer.borderColor=[self.segmentBgColor CGColor];
    
    _segment.delegate = self;
    self.navigationItem.titleView = _segment;
}

#pragma mark - JRSegmentControlDelegate

- (void)segmentControl:(JRSegmentControl *)segment didSelectedIndex:(NSInteger)index {
    /** 子视图切换 */
    self.willShowingVC=self.childViewControllers[index];
    if (self.currentShowingVC== self.willShowingVC) {
        return;
    }
    else{
        self.lastShowingVC=self.currentShowingVC;
        [self transitionFromViewController:self.currentShowingVC toViewController: self.willShowingVC duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:^(BOOL finished) {
            if (finished) {
                self.currentShowingVC=self.willShowingVC;
                self.currentShowingVC.view.frame=self.view.frame;
                self.willShowingVC=nil;
            }else{
                self.currentShowingVC= self.lastShowingVC;
            }
        }];
    }
}

@end
