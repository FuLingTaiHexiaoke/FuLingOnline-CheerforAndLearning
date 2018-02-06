//
//  ViewController.m
//  YingYuanGeography
//
//  Created by 肖科 on 17/7/21.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "ViewController.h"

#import "FLXKMoviePlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
@interface ViewController ()<AVPlayerViewControllerDelegate>
@property (strong, nonatomic) FLXKMoviePlayerView * playerView;
@property (strong, nonatomic)  MPMoviePlayerController * moviePlayer;


@property(nonatomic,strong)AVPlayerViewController      *playerController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    WEAKSELF(weakSelf);
    CGRect frame=CGRectMake(0,0,MAX(self.view.width, self.view.height),MIN(self.view.width, self.view.height)) ;
    [self playerViewWithFrame:frame url:MoviePathWithName(@"导入视频.mp4") delegate:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [_playerView clearPlayer];
    _playerView=nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)playerViewWithFrame:(CGRect )frame url:(NSString * )url delegate:(id<AVPlayerViewControllerDelegate>)delegate
{
       //AVPlayerItemDidPlayToEndTimeNotification 兼容性不好，有些视频可以正常调用，有些不行
//    if (iOS9Later) {
//        FLXKMoviePlayerView * playerView =   [[FLXKMoviePlayerView alloc]initWithFrame:frame url:url delegate:delegate];
//        playerView.playerController.showsPlaybackControls=NO;
//        [self.view addSubview:playerView];
//        self.playerView=playerView;
//        playerView.alpha=0.0;
//        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            playerView.alpha=1.0;
//        } completion:^(BOOL finished) {
//            [playerView play];
//        }];
//        
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removePlayerView) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
//    }
//    else{
        MPMoviePlayerController * moviePlayer = [[MPMoviePlayerController alloc] init];
        moviePlayer.controlStyle = MPMovieControlStyleNone;
        [moviePlayer.view setFrame:frame];
        [moviePlayer.view setAlpha:1.0];
        [moviePlayer setContentURL:[NSURL fileURLWithPath:url]];
        [self.view addSubview:moviePlayer.view];
        self.moviePlayer=moviePlayer;
        moviePlayer.view.alpha=0.0;
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            moviePlayer.view.alpha=1.0;
        } completion:^(BOOL finished) {
            [moviePlayer play];
        }];
        
        //add notification
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removePlayerView) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
//    }
    
    UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-103, 5, 100, 100)];
    [btn setTitle:@"跳过" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:20.0];
//    [btn setImage:imageNamed(@"movie_cancel1") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(removePlayerView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)removePlayerView{
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        self.playerView.alpha=0.0;
        self.moviePlayer.view.alpha=0.0;
    } completion:^(BOOL finished) {
        [self.playerView clearPlayer];
        [self.moviePlayer stop];
        [self.moviePlayer.view removeFromSuperview];
        [self.playerView removeFromSuperview];
        self.moviePlayer=nil;
        self.playerView=nil;
        //remove notification
        [[NSNotificationCenter defaultCenter]removeObserver:self];
        UIViewController* vc=InstantiateVCWithName(@"LoginVC");
        [self presentViewController:vc animated:YES completion:nil];
    }];
    [self.playerView stop];
}

#pragma mark - Delegate

#pragma mark AVPlayerViewControllerDelegate
- (void)playerViewControllerWillStartPictureInPicture:(AVPlayerViewController *)playerViewController{
    NSLog(@"...");
}
- (void)playerViewControllerDidStopPictureInPicture:(AVPlayerViewController *)playerViewController{
    [self removePlayerView];
}
- (void)playerViewController:(AVPlayerViewController *)playerViewController failedToStartPictureInPictureWithError:(NSError *)error{
    NSLog(@"failedToStartPictureInPictureWithError...");
}

@end
