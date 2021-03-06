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
//#import "Masonry.h"

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
+(instancetype)initWithTitles:(NSArray<NSString*>*)viewControllerTitles viewControllers:(NSArray<UIViewController*>*)viewControllers parentVC:(UIViewController*)parentVC{
    FLXKNavigationTitleViewController* vc=[[FLXKNavigationTitleViewController alloc ]init];
    vc.viewControllerTitles=viewControllerTitles;
    vc.viewControllers=viewControllers;
    return vc;
}


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
    self.parentViewController.navigationItem.titleView=_titleView;
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
    //修改内容:修改如下--。
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (NSString *)randomText {
    CGFloat length = arc4random() % 150 + 5;
    
    NSMutableString *str = [[NSMutableString alloc] init];
    for (NSUInteger i = 0; i < length; ++i) {
        [str appendString:@"测试数据很长，"];
    }
    
    return str;
}

@end
