//
//  ViewController.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/10/11.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end


//[self.viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//    NSLog(@" obj.view.frame  %@", NSStringFromCGRect(  obj.view.frame));
//}];

//
//NSLog(@"self.view.frame scrollView1 %@", NSStringFromCGRect( self.view.frame));
//_scrollView=[[UIScrollView alloc]init];
//_scrollView.backgroundColor=[UIColor blueColor];
//_scrollView.delegate=self;
//_scrollView.pagingEnabled=YES;
//_scrollView.showsVerticalScrollIndicator=NO;
//_scrollView.showsHorizontalScrollIndicator=NO;
//
//[self.view addSubview:_scrollView];
//[_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
//    make.top.mas_equalTo(self.view.mas_top);
//    make.left.mas_equalTo(self.view.mas_left);
//    make.bottom.mas_equalTo(self.view.mas_bottom);
//    make.right.mas_equalTo(self.view.mas_right);
//}];
//[self.view setNeedsLayout];
//[self.view layoutIfNeeded];
//NSLog(@"self.view.frame scrollView2 %@", NSStringFromCGRect( self.scrollView.frame));
//CGFloat scrollWidth=CGRectGetWidth(self.scrollView.frame);
//
//[viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//    [self addChildViewController:obj];
//    [_scrollView addSubview:obj.view];
//    [obj.view mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.scrollView.mas_top);
//        make.left.mas_equalTo(self.scrollView.left).offset(idx*scrollWidth);
//        make.bottom.mas_equalTo(self.scrollView.mas_bottom);
//        make.width.mas_equalTo(scrollWidth);
//    }];
//}];
//_scrollView.contentSize=CGSizeMake(scrollWidth*viewControllers.count,0);;
//
////        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//////           CGFloat scrollWidth=CGRectGetWidth(self.scrollView.frame);
////    __block   UIView *lastView= nil;
////    [viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
////        [self addChildViewController:obj];
////        [_scrollView addSubview:obj.view];
////        [obj.view mas_remakeConstraints:^(MASConstraintMaker *make) {
////            make.top.mas_equalTo(self.scrollView.mas_top);
////            if (lastView) {
////                make.left.mas_equalTo(lastView.mas_right);
////            } else {
////                make.left.mas_equalTo(self.scrollView.mas_left);
////            }
////            make.bottom.mas_equalTo(self.scrollView.mas_bottom);
////            make.width.mas_equalTo(screenWidth);
////        }];
////        lastView=  obj.view;
////    }];
////
////    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
////        make.edges.mas_equalTo(self.view);
////        // 让scrollview的contentSize随着内容的增多而变化
////        make.right.mas_equalTo(lastView.right);
////    }];

