//
//  FLXKMoviePlayerViewController.h
//  FLXK-TeachersTerminal
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FLXKMoviePlayerView : UIView

- (instancetype )initWithFrame:(CGRect )frame url:(NSString * )url;

- (void)play;
- (void)pause;
- (void)stop;
-(void)clearPlayer;
@end
