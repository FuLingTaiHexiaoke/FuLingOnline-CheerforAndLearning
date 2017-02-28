//
//  FLXKNavigationTitleViewController.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/2/28.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLXKNavigationTitleViewController : UIViewController
@property(nonatomic,strong)NSArray<UIViewController*>* viewControllers;
@property(nonatomic,strong)NSArray<NSString*>* viewControllerTitles;

+(instancetype)initWithTitles:(NSArray<NSString*>*)viewControllerTitles viewControllers:(NSArray<UIViewController*>*)viewControllers parentVC:(UIViewController*)parentVC;
@end
