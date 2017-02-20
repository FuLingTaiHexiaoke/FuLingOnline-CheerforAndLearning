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


@interface FLXKFriendsSharingViewController ()
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIButton *switchButton;
@property (weak, nonatomic) IBOutlet UITextView *publishTextView;

//subviews
@property (strong, nonatomic) UIView* emotionKeyBoard;
@end

@implementation FLXKFriendsSharingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerGestureForResignViewEditing];
    
//    self.emotionKeyBoard=[FLXKEmotionBoard sharedEmotionBoardWithReload:YES editingTextView:self.publishTextView swithButton:self.switchButton swithButtonContainer:self.container emotionEditingVCView:self.view emotionGroupShowingOption:(EmotionGroup_basic_text_emotion_image|EmotionGroup_emoji_text_emotion_image)];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
        self.emotionKeyBoard=[FLXKEmotionBoard sharedEmotionBoardWithEditingTextView:self.publishTextView swithButton:self.switchButton swithButtonContainer:self.container emotionEditingVCView:self.view emotionGroupShowingOption:(EmotionGroup_basic_text_emotion_image|EmotionGroup_emoji_text_emotion_image)];
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
