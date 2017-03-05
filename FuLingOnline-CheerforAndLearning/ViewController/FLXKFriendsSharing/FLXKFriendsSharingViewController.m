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
    [self registerGestureForResignViewEditing];
    
    
    NSMutableArray<UIViewController*>* viewControllers=[NSMutableArray array];
    for (int i=0; i<3; i++) {
//        FLXSuggestedSharingTableViewController* vc= [[FLXSuggestedSharingTableViewController alloc]init];
        FLXSuggestedSharingTableViewController* vc=(        FLXSuggestedSharingTableViewController* ) [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"StdID_FLXSuggestedSharingTableViewController"];

//        vc.view.backgroundColor=[UIColor colorWithWhite:0.5 alpha:0.1*i];
        [viewControllers addObject:vc];
    }
    
    //add child viewController
    NSLog(@"self.view.frame 1 %@", NSStringFromCGRect( self.view.frame));
//    _childVC=[FLXKNavigationTitleViewController initWithTitles:@[@"test1",@"test2",@"test3"] viewControllers:viewControllers parentVC:self];
//        [self addChildViewController:_childVC];
////        _childVC=[[FLXKNavigationTitleViewController alloc]init];
//    _childVC.view.backgroundColor=[UIColor whiteColor];
////    _childVC.viewControllers=viewControllers;
////    _childVC.viewControllerTitles= @[@"test1",@"test2",@"test3"];
//    [self addChildViewController:_childVC];
//    _childVC.view.frame=self.view.frame;
//    [self.view addSubview:_childVC.view];
    
    //    //add navigation title view
    //    FLXKNavigationTitleSegmentsView* a= [[FLXKNavigationTitleSegmentsView alloc]initWithFrame:CGRectMake(0, 0, self.view.width-100, 44)];
    //    a.viewControllerTitles= @[@"test1",@"test2",@"test3"];
    //    self.navigationItem.titleView=a;
    
    //    self.emotionKeyBoard=[FLXKEmotionBoard sharedEmotionBoardWithReload:YES editingTextView:self.publishTextView swithButton:self.switchButton swithButtonContainer:self.container emotionEditingVCView:self.view emotionGroupShowingOption:(EmotionGroup_basic_text_emotion_image|EmotionGroup_emoji_text_emotion_image)];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    NSLog(@"self.view.frame 2 %@", NSStringFromCGRect( self.view.frame));

    self.emotionKeyBoard=[FLXKEmotionBoard sharedEmotionBoardWithEditingTextView:self.publishTextView swithButton:self.switchButton swithButtonContainer:self.container emotionEditingVCView:self.view emotionGroupShowingOption:(EmotionGroup_basic_text_emotion_image|EmotionGroup_emoji_text_emotion_image)];
//        [self.view addSubview:_childVC.view];
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

@end
