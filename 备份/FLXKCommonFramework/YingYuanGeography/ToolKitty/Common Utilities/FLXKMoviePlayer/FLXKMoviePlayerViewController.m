//
//  FLXKMoviePlayerViewController.m
//  FLXK-TeachersTerminal
//
//  Created by 123 on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FLXKMoviePlayerViewController.h"

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface FLXKMoviePlayerViewController ()

@property(nonatomic,strong)AVPlayerViewController      *playerController;
@property(nonatomic,strong)AVPlayer                    *player;
@property(nonatomic,strong)AVAudioSession              *session;
@property(nonatomic,strong)NSString                    *urlString;
@property(nonatomic,strong)id<AVPlayerViewControllerDelegate> delegate;

@end

@implementation FLXKMoviePlayerViewController

- (id)initWithUrl:(NSString *)url delegate:( id<AVPlayerViewControllerDelegate> )delegate{
    self = [super init];
    if (self) {
        _urlString = url;
        _delegate=delegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _session = [AVAudioSession sharedInstance];
    [_session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:([_urlString hasPrefix:@"http"]?([NSURL URLWithString:_urlString]):([NSURL fileURLWithPath:_urlString]))];
    
    _player = [AVPlayer playerWithPlayerItem:item];
    _playerController = [[AVPlayerViewController alloc] init];
    _playerController.player = _player;
    _playerController.videoGravity = AVLayerVideoGravityResizeAspect;
    _playerController.delegate = _delegate;
    _playerController.allowsPictureInPicturePlayback = true;    //画中画，iPad可用
    _playerController.showsPlaybackControls = true;
    
    [self addChildViewController:_playerController];
    _playerController.view.translatesAutoresizingMaskIntoConstraints = true;    //AVPlayerViewController 内部可能是用约束写的，这句可以禁用自动约束，消除报错
    _playerController.view.frame = self.view.bounds;
    [self.view addSubview:_playerController.view];
    
    [_playerController.player play];    //自动播放
}

- (void)dealloc
{
    NSLog(@"%@",[NSString stringWithFormat:@"%@销毁",[self class]]);
}
@end
