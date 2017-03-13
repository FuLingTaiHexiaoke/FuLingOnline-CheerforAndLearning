//
//  FLXKNavigationTitleViewController.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/2/28.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width

#import "FLXKNavigationTitleViewController.h"

//subviews
#import "FLXKNavigationTitleSegmentsView.h"
//utilities
#import "Masonry.h"

@interface FLXKNavigationTitleViewController ()<UIScrollViewDelegate>

//UI
@property(nonatomic,strong) FLXKNavigationTitleSegmentsView* titleView;
@property(nonatomic,strong) UIScrollView* scrollView;
@end

@implementation FLXKNavigationTitleViewController

#pragma mark -
#pragma mark - ViewController LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
//            //add navigation title view
//        [self setupNavigationTitleSegmentsView];
//    
//        //setup a scrollview container
//        //add children to scrollview container
//        [self setupScrollViewWithVCs:self.viewControllers];
}

-(void)viewWillAppear:(BOOL)animated{
    //      //add navigation title view
    [self setupNavigationTitleSegmentsView];
    //setup a scrollview container
    //add children to scrollview container
    [self setupScrollViewWithVCs:self.viewControllers];
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
+(instancetype)initWithTitles:(NSArray<NSString*>*)viewControllerTitles viewControllers:(NSArray<UIViewController*>*)viewControllers parentVC:(UIViewController*)parentVC{
    FLXKNavigationTitleViewController* vc=[[FLXKNavigationTitleViewController alloc ]init];
    vc.viewControllerTitles=viewControllerTitles;
    vc.viewControllers=viewControllers;
    return vc;
}


#pragma mark -
#pragma mark - Private Methods
-(void)setupNavigationTitleSegmentsView{
    _titleView= [[FLXKNavigationTitleSegmentsView alloc]initWithFrame:CGRectMake(0, 10, self.view.width-100, 34)];
    _titleView.viewControllerTitles=_viewControllerTitles;
    _titleView.currentTitleIndex= 1;
    _titleView.backgroundColor= [UIColor orangeColor];
    _titleView.titleColor= [UIColor orangeColor];
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
    self.parentViewController.navigationItem.titleView=_titleView;
}


-(void)setupScrollViewWithVCs:(NSArray<UIViewController*>*)viewControllers{
    NSLog(@"self.view.frame scrollView1 %@", NSStringFromCGRect( self.view.frame));
    _scrollView=[[UIScrollView alloc]init];
    _scrollView.backgroundColor=[UIColor blueColor];
    _scrollView.delegate=self;
    _scrollView.pagingEnabled=YES;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.showsHorizontalScrollIndicator=NO;
    
    [self.view addSubview:_scrollView];
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.top);
        make.left.mas_equalTo(self.view.left);
        make.bottom.mas_equalTo(self.view.bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
        NSLog(@"self.view.frame scrollView2 %@", NSStringFromCGRect( self.scrollView.frame));
    CGFloat scrollWidth=CGRectGetWidth(self.scrollView.frame);
    
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildViewController:obj];
        [_scrollView addSubview:obj.view];
        [obj.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.scrollView.top);
            make.left.mas_equalTo(self.scrollView.left).offset(idx*scrollWidth);
            make.bottom.mas_equalTo(self.scrollView.bottom);
            make.width.mas_equalTo(scrollWidth);
        }];
    }];
    
    _scrollView.contentSize=CGSizeMake(scrollWidth*viewControllers.count,0);;
}
@end
