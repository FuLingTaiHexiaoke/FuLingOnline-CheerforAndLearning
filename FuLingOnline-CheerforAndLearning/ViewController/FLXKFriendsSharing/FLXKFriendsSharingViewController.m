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

//#import "UINavigationBar+Awesome.h"


//child viewController
#import "FLXKNavigationTitleViewController.h"
#import "FLXSuggestedSharingTableViewController.h"

//subviews
#import "FLXKNavigationTitleSegmentsView.h"
#import "FLXKMessageToolBar.h"



@interface FLXKFriendsSharingViewController ()
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIButton *switchButton;
@property (weak, nonatomic) IBOutlet UITextView *publishTextView;

//subviews
@property (strong, nonatomic) UIView* emotionKeyBoard;
@property (strong, nonatomic) FLXKNavigationTitleViewController* childVC;
@property(nonatomic,strong)   FLXKMessageToolBar* messageToolBar;
@end

@implementation FLXKFriendsSharingViewController
#pragma mark - ViewController LifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.navigationController.navigationBarHidden=NO;
    
    [self setupOwnNavigationAppearance];
    
//    [self registerGestureForResignViewEditing];
    
    [self setupNavigationTitleViewController];
    
    //    if (DEBUG) {
    //        UIButton* btn1=[[UIButton alloc]initWithFrame:CGRectMake(50, 150, 50, 50)];
    //        [btn1 addTarget:self action:@selector(showTabBar) forControlEvents:UIControlEventTouchUpInside];
    //        btn1.backgroundColor=[UIColor grayColor];
    //        [self.view addSubview:btn1];
    //    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //    self.emotionKeyBoard=[FLXKEmotionBoard sharedEmotionBoardWithEditingTextView:self.publishTextView swithButton:self.switchButton swithButtonContainer:self.container emotionEditingVCView:self.view emotionGroupShowingOption:(EmotionGroup_basic_text_emotion_image|EmotionGroup_emoji_text_emotion_image)];
    
}



-(void)dealloc{
    NSLog(@"%@ 销毁",NSStringFromClass(self.class));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate
#pragma mark - Public methods
#pragma mark - View Event
#pragma mark - Model Event
#pragma mark - Private methods

#pragma mark - NAVIGATION SETTING
-(void)setupOwnNavigationAppearance{
    self.title = @"Test VC";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor =NAVIGATION_BAR_TOP_BARTINTCOLOR;
    self.navigationController.navigationBar.tintColor =NAVIGATION_BAR_TOP_TINTCOLOR;
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[YYFPSLabel alloc]initWithFrame:CGRectMake(0, 5, 60, 30)]];

}

-(void)setupNavigationTitleViewController{
    NSMutableArray<UIViewController*>* viewControllers=[NSMutableArray array];
    for (int i=0; i<1; i++) {
        FLXSuggestedSharingTableViewController* vc=(FLXSuggestedSharingTableViewController* ) [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"StdID_FLXSuggestedSharingTableViewController"];
        [viewControllers addObject:vc];
    }
    
    //add child viewController
    _childVC=[FLXKNavigationTitleViewController initWithTitles:@[@"话题",@"推荐",@"达人"] viewControllers:viewControllers parentVC:self];
    [self addChildViewController:_childVC];
    [self.view addSubview:_childVC.view];
    [_childVC.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    
    
    //            FLXSuggestedSharingTableViewController* vc=(FLXSuggestedSharingTableViewController* ) [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"StdID_FLXSuggestedSharingTableViewController"];
    //    [self.navigationController pushViewController:vc animated:YES];
}


//-(void)setupMessageToolBar{
//    if (_messageToolBar) {
//        _messageToolBar=  [FLXKMessageToolBar   sharedMessageToolBarWithPlacehoder:@"test" containerView:self.view  showingOption:MessageToolBarShowingOption_EMOTION_BUTTON];
//    }
//    else{
//        [_messageToolBar removeFromSuperview];
//        _messageToolBar=  [FLXKMessageToolBar   sharedMessageToolBarWithPlacehoder:@"test" containerView:self.view  showingOption:MessageToolBarShowingOption_EMOTION_BUTTON];
//        _messageToolBar.backgroundColor=[UIColor yellowColor];
//        [self.tableView addSubview:_messageToolBar];
//        @weakify(self)
//
//        _messageToolBar.sendMessageBlock=^(NSString* message){
//            @strongify(self)
//            [self sendComment:message];
//        };
//
//        _messageToolBar.growingTextViewChangeHeight=^(CGFloat height){
//            @strongify(self)
//            [self growingTextViewChangeHeight:height];
//        };
//
//        [_messageToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(48);
//            make.width.mas_equalTo(self.view.mas_width);
//            make.bottom.mas_equalTo(self.mas_bottomLayoutGuide).offset(100);
//        }];
//    }
//}
//
//-(void)showToolBarWithPlaceholder:(NSString*) placeholder{
//    [_messageToolBar showToolBarWithPlaceholder:placeholder];
//}
//
//- (void)growingTextViewChangeHeight:(float)height
//{
//    [UIView animateWithDuration:0.1 delay:0.0 usingSpringWithDamping:10.0 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//
//        [_messageToolBar mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(height);
//        }];
//
//        [self.view layoutIfNeeded];
//    } completion:^(BOOL finished) {
//
//    }];
//}

-(void)showTabBar{
    Router(Router_TabBar_FriendsSharing_NewsPublish)
}

//-(void)sendComment:(NSString *)message{
//    [self.currentOperationCell addFriendsharingComment:@{@"content":message}];
//}

#pragma mark - getter/setter
#pragma mark - Overriden methods



#pragma mark - Navigation
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
