//
//  FLXKMoviePlayerViewController.h
//  FLXK-TeachersTerminal
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>

@interface FLXKMoviePlayerView : UIView

@property(nonatomic,strong)AVPlayerViewController      *playerController;


- (instancetype )initWithFrame:(CGRect )frame url:(NSString * )url delegate:(id<AVPlayerViewControllerDelegate>)delegate;

- (void)play;
- (void)pause;
- (void)stop;
-(void)clearPlayer;
@end
