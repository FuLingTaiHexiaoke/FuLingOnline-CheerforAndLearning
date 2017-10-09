//
//  FLXKMoviePlayerViewController.h
//  FLXK-TeachersTerminal
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FLXKMoviePlayerView.h"

#import <AVFoundation/AVFoundation.h>

@interface FLXKMoviePlayerView()
//@property(nonatomic,strong)AVPlayerViewController      *playerController;
@property(nonatomic,strong)AVPlayer                    *player;
@property(nonatomic,strong)AVAudioSession              *session;
@property(nonatomic,strong)NSString                    *urlString;
@end

@implementation FLXKMoviePlayerView

#pragma Mark -  lifeCircle

- (instancetype )initWithFrame:(CGRect )frame url:(NSString * )url delegate:(id<AVPlayerViewControllerDelegate>)delegate{
    _urlString = url;
    self = [super initWithFrame:frame];
    if (self) {
        _session = [AVAudioSession sharedInstance];
        [_session setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        _player = [AVPlayer playerWithURL:([_urlString hasPrefix:@"http"]?([NSURL URLWithString:_urlString]):([NSURL fileURLWithPath:_urlString]))];
        _playerController = [[AVPlayerViewController alloc] init];
        _playerController.player = _player;
        _playerController.videoGravity = AVLayerVideoGravityResizeAspect;
        _playerController.allowsPictureInPicturePlayback = true;    //画中画，iPad可用
        _playerController.showsPlaybackControls = YES;
        
        _playerController.view.translatesAutoresizingMaskIntoConstraints = true;    //AVPlayerViewController 内部可能是用约束写的，这句可以禁用自动约束，消除报错
        _playerController.view.frame =self.bounds;
        _playerController.delegate=delegate;
        [self addSubview:_playerController.view];
        
    }
    return self;
}

#pragma Mark - Publice Methods
- (void)dealloc
{
    NSLog(@"%@",[NSString stringWithFormat:@"%@销毁",[self class]]);
}


- (void)play
{
    [_playerController.player play];
}


- (void)pause
{
    [_playerController.player pause];
}

-(void)stop{
    [_playerController.player pause];
}

-(void)clearPlayer{
    [self stop];
    [self removeFromSuperview];
    self.player=nil;
    self.playerController=nil;
    self.session=nil;
}

//- (BOOL)isPreparedToPlay{
//    return  [_player isPreparedToPlay];
////    return nil;
//}

#pragma Mark - Private Methods




@end
