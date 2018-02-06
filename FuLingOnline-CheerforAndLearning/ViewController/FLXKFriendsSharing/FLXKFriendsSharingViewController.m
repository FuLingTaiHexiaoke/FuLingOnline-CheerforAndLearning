//
//  FLXKNavigationTitleViewController.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/2/28.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width

#import "FLXKFriendsSharingViewController.h"

//utilites
#import "UIViewController+Extensions.h"
#import "FLXKEmotionBoard.h"
#import "YYFPSLabel.h"
#import "UIColor+Extensions.h"

//#import "UINavigationBar+Awesome.h"


//child viewController
#import "FLXKNavigationTitleViewController.h"
#import "FLXSuggestedSharingTableVC.h"

//subviews
#import "FLXKNavigationTitleSegmentsView.h"
#import "FLXKMessageToolBar.h"

@interface FLXKFriendsSharingViewController ()<UIScrollViewDelegate>

//UI
@property(nonatomic,strong) FLXKNavigationTitleSegmentsView* titleView;
@property(nonatomic,strong) UIScrollView* scrollView;
@property(nonatomic,assign) NSInteger initShowingVCIndex;
@end

@implementation FLXKFriendsSharingViewController

#pragma mark -
#pragma mark - ViewController LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.initShowingVCIndex=1;
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self setupOwnNavigationAppearance];
    [self setupNavigationTitleSegmentsView];
    [self setupScrollViewWithVCs:self.viewControllers];
    
    //    if (DEBUG) {
    //        UIButton* btn1=[[UIButton alloc]initWithFrame:CGRectMake(50, 150, 50, 50)];
    //        [btn1 addTarget:self action:@selector(showTabBar) forControlEvents:UIControlEventTouchUpInside];
    //        btn1.backgroundColor=[UIColor grayColor];
    //        [self.view addSubview:btn1];
    //    }
}

-(void)viewWillAppear:(BOOL)animated{
    
}

#pragma mark -
#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark - UI Delegates
#pragma mark - UIScrollViewDelegate
#pragma mark - Scroll Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageIndex=  scrollView.contentOffset.x/(SCREEN_WIDTH);
    [_titleView setCurrentTitleIndex:pageIndex];
}


#pragma mark -
#pragma mark - Public Methods



#pragma mark -
#pragma mark - Private Methods

-(void)setupOwnNavigationAppearance{
    //    self.title = @"Test VC";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor =NAVIGATION_BAR_TOP_BARTINTCOLOR;
    self.navigationController.navigationBar.tintColor =NAVIGATION_BAR_TOP_TINTCOLOR;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[YYFPSLabel alloc]initWithFrame:CGRectMake(0, 5, 60, 30)]];
}

-(void)setupNavigationTitleSegmentsView{
    _titleView= [[FLXKNavigationTitleSegmentsView alloc]initWithFrame:CGRectMake(0, 10, 150,FBTweakValue(@"NavTitle", @"titleView", @"titleViewH", 36.0))];
    _titleView.viewControllerTitles=self.viewControllerTitles;
    _titleView.currentTitleIndex= self.initShowingVCIndex;
    _titleView.backgroundColor= [UIColor orangeColor];
    _titleView.titleColor= [UIColor colorWithRed:169/255.0 green:71/255.0 blue:18/255.0 alpha:1.0];
    _titleView.titleSelectedColor= [UIColor whiteColor];
    _titleView.bottomLineColor=[UIColor whiteColor];
    _titleView.bottomLineHeight=3;
    
    __weak __typeof(self) weakSelf=self;
    _titleView.titleSegmentSelectedBlock=^(NSInteger selectedIndex){
        [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:1.0f initialSpringVelocity:15.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            weakSelf.scrollView.contentOffset =CGPointMake((selectedIndex*SCREEN_WIDTH), 0);
        } completion:^(BOOL finished) {
            
        }];
    };
    self.navigationItem.titleView=_titleView;
}

-(void)setupScrollViewWithVCs:(NSArray<UIViewController*>*)viewControllers{
    _scrollView=[[UIScrollView alloc]init];
    _scrollView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    _scrollView.delegate=self;
    _scrollView.pagingEnabled=YES;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.frame=self.view.frame;
    
    [self.view addSubview:_scrollView];
    
    //修改人:肖科    修改时间:2017-6-12  修改原因:以后在布局中能少用自动布局的地方，就尽量少用。不然很多参数不能及时确认，比如scrollView.contentSize，导致上拉刷新等操作被影响。
    //修改内容:--修改如下。
    // self.scrollView.contentSize
    //    __block   UIView *lastView= nil;
    //    [viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        [self addChildViewController:obj];
    //        [_scrollView addSubview:obj.view];
    //        [obj.view mas_remakeConstraints:^(MASConstraintMaker *make) {
    //            make.top.mas_equalTo(self.scrollView.mas_top);
    //            make.left.mas_equalTo(lastView?lastView.mas_right:self.scrollView.mas_left);
    //            make.bottom.mas_equalTo(self.scrollView.mas_bottom);
    //            make.width.mas_equalTo(self.scrollView.mas_width);
    //            make.height.mas_equalTo(self.scrollView.mas_height);
    //        }];
    //        lastView= obj.view;
    //    }];
    //    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.mas_equalTo(self.view);
    //        // 让scrollview的contentSize随着内容的增多而变化
    //        make.leading.mas_equalTo(self.scrollView.mas_leading);
    //        make.trailing.mas_equalTo(lastView.mas_trailing);
    //    }];
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.viewControllers.count, 0);
    int cnt = (int)self.viewControllers.count;
    for (int i = 0; i < cnt; i++) {
        UIViewController *vc = self.viewControllers[i];
        [self addChildViewController:vc];
        vc.view.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, _scrollView.height);
        [self.scrollView addSubview:vc.view];
    }
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * self.initShowingVCIndex, 0)];
    //修改内容:修改如下--。
}

-(NSArray<UIViewController *> *)viewControllers{
    NSMutableArray<UIViewController*>* viewControllers=[NSMutableArray array];
    
    UIViewController* vc=[UIViewController new];
    vc.view.backgroundColor=[UIColor randomColor];
    [viewControllers addObject:vc];
    
    vc=[FLXSuggestedSharingTableVC new];
    [viewControllers addObject:vc];
    
    vc=[UIViewController new];
    vc.view.backgroundColor=[UIColor randomColor];
    [viewControllers addObject:vc];
    
    return viewControllers;
}

-(NSArray<NSString *> *)viewControllerTitles{
    return @[@"话题",@"推荐",@"达人"];
}

-(void)showTabBar{
    //    Router(Router_TabBar_FriendsSharing_NewsPublish)
    NSMutableArray<UIViewController*>* viewControllers=[NSMutableArray array];
    
    UIViewController* vc=[UIViewController new];
    vc.view.backgroundColor=[UIColor randomColor];
    [viewControllers addObject:vc];
    
    vc=[FLXSuggestedSharingTableVC new];
    [viewControllers addObject:vc];
    
    vc=[UIViewController new];
    vc.view.backgroundColor=[UIColor randomColor];
    [viewControllers addObject:vc];
    
    UIViewController * vcs=[FLXKNavigationTitleViewController initWithTitles:@[@"话题",@"推荐",@"达人"] viewControllers:viewControllers parentVC:self];
    UINavigationController* nvc=[[UINavigationController alloc]initWithRootViewController:vcs];
    [self presentViewController:nvc animated:YES completion:nil];
}

@end
