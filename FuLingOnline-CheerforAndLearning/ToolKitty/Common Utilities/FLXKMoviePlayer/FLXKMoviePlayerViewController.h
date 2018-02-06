//
//  FLXKMoviePlayerViewController.h
//  FLXK-TeachersTerminal
//
//  Created by 123 on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AVPlayerViewControllerDelegate;

@interface FLXKMoviePlayerViewController : UIViewController

- (id)initWithUrl:(NSString *)url delegate:( id<AVPlayerViewControllerDelegate> )delegate;

@end
