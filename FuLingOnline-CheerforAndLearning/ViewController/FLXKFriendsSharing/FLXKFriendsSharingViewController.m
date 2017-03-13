//
//  FLXKFriendsSharingViewController.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/2/13.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKFriendsSharingViewController.h"

//utilites
#import "UIViewController+Extensions.h"
#import "FLXKEmotionBoard.h"
#import "Masonry.h"

//child viewController
#import "FLXKNavigationTitleViewController.h"
#import "FLXSuggestedSharingTableViewController.h"

//subviews
#import "FLXKNavigationTitleSegmentsView.h"



@interface FLXKFriendsSharingViewController ()
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIButton *switchButton;
@property (weak, nonatomic) IBOutlet UITextView *publishTextView;

//subviews
@property (strong, nonatomic) UIView* emotionKeyBoard;
@property (strong, nonatomic) FLXKNavigationTitleViewController* childVC;
@end

@implementation FLXKFriendsSharingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    
    [self registerGestureForResignViewEditing];
    
    NSMutableArray<UIViewController*>* viewControllers=[NSMutableArray array];
    for (int i=0; i<3; i++) {
        FLXSuggestedSharingTableViewController* vc=(FLXSuggestedSharingTableViewController* ) [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"StdID_FLXSuggestedSharingTableViewController"];
        [viewControllers addObject:vc];
    }
    
    //add child viewController
    NSLog(@"self.view.frame viewDidLoad %@", NSStringFromCGRect( self.view.frame));
    _childVC=[FLXKNavigationTitleViewController initWithTitles:@[@"test1",@"test2",@"test3"] viewControllers:viewControllers parentVC:self];
    [self addChildViewController:_childVC];
    [self.view addSubview:_childVC.view];
    [_childVC.view mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
                    make.left.mas_equalTo(self.view.left);
                    make.bottom.mas_equalTo(self.view.bottom);
                    make.width.mas_equalTo(self.view.width);
    }];


    if (DEBUG) {
        
        
        UIButton* btn1=[[UIButton alloc]initWithFrame:CGRectMake(50, 150, 50, 50)];
        [btn1 addTarget:self action:@selector(showTabBar) forControlEvents:UIControlEventTouchUpInside];
        btn1.backgroundColor=[UIColor grayColor];
        [self.view addSubview:btn1];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.emotionKeyBoard=[FLXKEmotionBoard sharedEmotionBoardWithEditingTextView:self.publishTextView swithButton:self.switchButton swithButtonContainer:self.container emotionEditingVCView:self.view emotionGroupShowingOption:(EmotionGroup_basic_text_emotion_image|EmotionGroup_emoji_text_emotion_image)];
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"self.view.frame viewDidAppear %@", NSStringFromCGRect( self.view.frame));
    [super viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)dealloc{
    NSLog(@"%@ 销毁",NSStringFromClass(self.class));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)showTabBar{
    Router(Router_TabBar_FriendsSharing_NewsPublish)
}

@end
