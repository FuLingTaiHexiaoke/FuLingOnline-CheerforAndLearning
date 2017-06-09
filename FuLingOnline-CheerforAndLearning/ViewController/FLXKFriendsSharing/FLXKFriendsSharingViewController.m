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
#import "Masonry.h"
#import "YYFPSLabel.h"

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
@end

@implementation FLXKFriendsSharingViewController

#pragma mark -
#pragma mark - ViewController LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //add navigation title view
    [self setupNavigationTitleSegmentsView];
    
    //setup a scrollview container
    //add children to scrollview container
    [self setupScrollViewWithVCs:self.viewControllers];
}

-(void)viewWillAppear:(BOOL)animated{
    
}

#pragma mark -
#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - UI Delegates
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageIndex=  scrollView.contentOffset.x/(SCREEN_WIDTH);
    [_titleView setCurrentTitleIndex:pageIndex];
}


#pragma mark -
#pragma mark - Public Methods



#pragma mark -
#pragma mark - Private Methods
-(void)setupNavigationTitleSegmentsView{
    _titleView= [[FLXKNavigationTitleSegmentsView alloc]initWithFrame:CGRectMake(0, 10, 150,FBTweakValue(@"NavTitle", @"titleView", @"titleViewH", 36.0))];
    _titleView.viewControllerTitles=_viewControllerTitles;
    _titleView.currentTitleIndex= 1;
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
    _scrollView.backgroundColor=[UIColor blueColor];
    _scrollView.delegate=self;
    _scrollView.pagingEnabled=YES;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.bounces=NO;
    [self.view addSubview:_scrollView];
    
    __block   UIView *lastView= nil;
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildViewController:obj];
        [_scrollView addSubview:obj.view];
        [obj.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.scrollView.mas_top);
            make.left.mas_equalTo(lastView?lastView.mas_right:self.scrollView.mas_left);
            make.bottom.mas_equalTo(self.scrollView.mas_bottom);
            make.width.mas_equalTo(self.scrollView.mas_width);
            make.height.mas_equalTo(self.scrollView.mas_height);
        }];
        lastView= obj.view;
    }];
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
        // 让scrollview的contentSize随着内容的增多而变化
        make.leading.mas_equalTo(self.scrollView.mas_leading);
        make.trailing.mas_equalTo(lastView.mas_trailing);
    }];

}

-(NSArray<UIViewController *> *)viewControllers{
    NSMutableArray<UIViewController*>* viewControllers=[NSMutableArray array];
    for (int i=0; i<1; i++) {
        FLXSuggestedSharingTableVC* vc=[FLXSuggestedSharingTableVC new];
        [viewControllers addObject:vc];
    }
    return viewControllers;
}

-(NSArray<NSString *> *)viewControllerTitles{
    return @[@"话题",@"推荐",@"达人"];
}
@end
