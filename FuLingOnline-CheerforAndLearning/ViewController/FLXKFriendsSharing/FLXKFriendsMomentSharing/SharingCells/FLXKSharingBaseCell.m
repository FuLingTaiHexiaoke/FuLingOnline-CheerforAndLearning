//
//  SharingBaseCell.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//
#pragma mark - Declarations and macros

#import "FLXKSharingBaseCell.h"
//utilites
#import "FLXKHttpRequestModelHelper.h"

@interface FLXKSharingBaseCell ()

@end

@implementation FLXKSharingBaseCell

#pragma mark - LifeCircle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}

-(void)dealloc{
    NSLog(@"%@ 销毁",NSStringFromClass(self.class));
}

#pragma mark - Public methods

-(void)setModel:(FLXKSharingCellModel *)model{
    _model=model;
}

#pragma mark - 子类接口
- (void)reloadCurrentCell{
    //    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationNone];
    //    [self.tableView endUpdates];
    //    [self.tableView reloadData];
}

- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}

-(void)showLikeTheSharingPeopleInfo{
    
}

- (void)addThumbup:(UIButton*)sender {
    //外部处理逻辑
    if(self.addThumbupBlock){
        self.addThumbupBlock(sender,self.indexPath);
    }
    //内部处理逻辑
//    else{
//        if (self.model.isThumberuped==1) {
//            [sender setImage:[UIImage imageNamed:@"sharing_thumbup_n"]  forState:UIControlStateNormal];
//        }
//        else{
//            [sender setImage:[UIImage imageNamed:@"sharing_thumbup_s"]  forState:UIControlStateNormal];
//        }
//        //此处的逻辑没有弄得太懂，为什么没有按照预想的变化
//        //    [UIView animateWithDuration:1.0 animations:^{
//        ////        NSLog(@"NSStringFromCGAffineTransform %@",NSStringFromCGAffineTransform(sender.imageView.transform));
//        //        sender.imageView.transform=CGAffineTransformScale(sender.imageView.transform, 0.4, 0.4);
//        //    } completion:^(BOOL finished) {
//        //        sender.imageView.transform=CGAffineTransformIdentity;
//        //    }];
//        CABasicAnimation *theAnimation;
//        theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
//        theAnimation.duration=2;
//        theAnimation.fillMode = kCAFillModeForwards;
//        theAnimation.removedOnCompletion = NO;
//        theAnimation.fromValue = [NSNumber numberWithFloat:1];
//        theAnimation.toValue = [NSNumber numberWithFloat:4.0];
//        [sender.imageView.layer addAnimation:theAnimation forKey:@"animateTransform"];
//        
//        [self addFriendsharingThumbup];
//        
//    }
}

- (void)addCommentRequest:(UIView* )tapedView{
    SharingCommentCellModel* model=[SharingCommentCellModel new];
    model.newsID=self.model.newsID;
    self.currentCommentCellModel=model;
    if ( self.addCommentBlock) {
        self.addCommentBlock(@"评论",model,tapedView,self.indexPath);
    }
}


#pragma mark - 内部网络请求
////点赞
//-(void)addFriendsharingThumbup{
//    @weakify(self)
//    [[FLXKHttpRequestModelHelper registerSuccessCallback:^(id obj) {
//        @strongify(self)
//        if (self.model.isThumberuped) {
//            __block  NSInteger index;
//            [self.model.likeTheSharingUserRecords enumerateObjectsUsingBlock:^(UserModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                if ([obj.login_name isEqualToString:[FLXKSharedAppSingleton sharedSingleton].sharedUser.login_name ]) {
//                    index=idx;
//                    *stop=YES;
//                }
//            }];
//            
//            [self.model.likeTheSharingUserRecords removeObjectAtIndex:index];
//        }
//        else{
//            [self.model.likeTheSharingUserRecords insertObject:[FLXKSharedAppSingleton sharedSingleton].sharedUser atIndex:0];
//        }
//        self.model.isThumberuped=!self.model.isThumberuped;
//        //    [UIView animateWithDuration:0.1 animations:^{
//        //          [self hiddenSubviews];
//        //    } completion:^(BOOL finished) {
//        //
//        //                 [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        //    }];
//        
//        [self showLikeTheSharingPeopleInfo];
//        //                 [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    } failureCallback:^(NSError *err) {
//        //        NSAssert(!err, err.description);
//    }]addFriendsharingThumbup:@{@"thumberupUserID": [FLXKSharedAppSingleton sharedSingleton].sharedUser.login_name,@"newsID":_model.newsID,@"isThumberuped":[NSNumber numberWithInteger:_model.isThumberuped]}];
//}
//
////添加评论信息，由外部调用。
//-(void)addFriendsharingComment:(NSDictionary*)parameters{
//    SharingCommentCellModel* model=[SharingCommentCellModel new];
//    model.fromUserID= [FLXKSharedAppSingleton sharedSingleton].sharedUser.login_name?:@"test";
//    model.fromUserName=[FLXKSharedAppSingleton sharedSingleton].sharedUser.name?:@"test";
//    if (self.currentCommentCellModel.toUserID) {
//        model.toUserID=self.currentCommentCellModel.toUserID;
//        model.toUserName=self.currentCommentCellModel.toUserName;
//        model.isReply=1;
//    }
//    model.content=[parameters objectForKey:@"content"];
//    model.newsID=self.currentCommentCellModel.newsID;
//    
//    parameters=[model modelToDic];
//    
//    [[FLXKHttpRequestModelHelper registerSuccessCallback:^(id obj) {
//        [self.model.sharingComments addObject:model];
//        self.model.sharingComments=self.model.sharingComments;
//        [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    } failureCallback:^(NSError *err) {
//        //        NSAssert(!err, err.description);
//    }]addFriendsharingComment:parameters];
//}


@end
