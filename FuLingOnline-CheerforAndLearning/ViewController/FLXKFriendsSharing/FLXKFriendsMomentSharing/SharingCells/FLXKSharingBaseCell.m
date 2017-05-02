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

//child viewController
//subviews
//models
//#import "FLXKmodel.h"

@interface FLXKSharingBaseCell ()
//IBOutlet
//IBAction
//child viewController
//subviews
//models

//UI state record properties
@end

@implementation FLXKSharingBaseCell

#pragma mark - ViewController LifeCircle

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)dealloc{
    NSLog(@"%@ 销毁",NSStringFromClass(self.class));
}





#pragma mark - Delegate
#pragma mark - Public methods


-(void)setModel:(FLXKSharingCellModel *)model{
    _model=model;
}


- (void)addThumbup:(UIButton*)sender {
    if (self.model.isThumberuped==1) {
        [sender setImage:[UIImage imageNamed:@"sharing_thumbup_s"]  forState:UIControlStateNormal];
    }
    else{
        [sender setImage:[UIImage imageNamed:@"sharing_thumbup_n"]  forState:UIControlStateNormal];
    }
    //    [UIView animateWithDuration:1.0 animations:^{
    ////        NSLog(@"NSStringFromCGAffineTransform %@",NSStringFromCGAffineTransform(sender.imageView.transform));
    //        sender.imageView.transform=CGAffineTransformScale(sender.imageView.transform, 0.4, 0.4);
    //    } completion:^(BOOL finished) {
    //        sender.imageView.transform=CGAffineTransformIdentity;
    //    }];
    
    [UIView animateWithDuration:1.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        sender.imageView.transform=CGAffineTransformScale(sender.imageView.transform, 0.4, 0.4);
    } completion:^(BOOL finished) {
        sender.imageView.transform=CGAffineTransformIdentity;
    }];
    
    //    CABasicAnimation *theAnimation;
    //    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //    theAnimation.duration=2;
    //    theAnimation.fillMode = kCAFillModeForwards;
    //    theAnimation.removedOnCompletion = NO;
    //    theAnimation.fromValue = [NSNumber numberWithFloat:1];
    //    theAnimation.toValue = [NSNumber numberWithFloat:4.0];
    //    [sender.imageView.layer addAnimation:theAnimation forKey:@"animateTransform"];
    
    
    [self addFriendsharingThumbup];
}

- (void)addCommentRequest{
    SharingCommentCellModel* model=[SharingCommentCellModel new];
    model.newsID=self.model.newsID;
    self.currentCommentCellModel=model;
    
    if ( self.addCommentRequestBlock) {
        self.addCommentRequestBlock(@"评论",self);
    }
}

//评论
-(void)addFriendsharingComment:(NSDictionary*)parameters{
    SharingCommentCellModel* model=[SharingCommentCellModel new];
    model.fromUserID= [FLXKSharedAppSingleton sharedSingleton].sharedUser.login_name?:@"test";
    model.fromUserName=[FLXKSharedAppSingleton sharedSingleton].sharedUser.name?:@"test";
    if (self.currentCommentCellModel.fromUserID) {
        model.toUserID=self.currentCommentCellModel.fromUserID;
        model.toUserName=self.currentCommentCellModel.fromUserName;
        model.isReply=1;
    }
    model.content=[parameters objectForKey:@"content"];
    model.newsID=self.currentCommentCellModel.newsID;
    
    parameters=[model modelToDic];
    
    [[FLXKHttpRequestModelHelper registerSuccessCallback:^(id obj) {
        [self.model.sharingComments addObject:model];
        [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationNone];
    } failureCallback:^(NSError *err) {
        //        NSAssert(!err, err.description);
    }]addFriendsharingComment:parameters];
}

//头像
//名称
//分享的文本内容
//分享的图片
//分享时间戳
//点赞按钮
//评论按钮
//评论列表


#pragma mark - View Event
//点赞
-(void)addFriendsharingThumbup{
    [[FLXKHttpRequestModelHelper registerSuccessCallback:^(id obj) {
            if (self.model.isThumberuped) {
                __block  NSInteger index;
                [self.model.likeTheSharingUserRecords enumerateObjectsUsingBlock:^(UserModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj.login_name isEqualToString:[FLXKSharedAppSingleton sharedSingleton].sharedUser.login_name ]) {
                        index=idx;
                        *stop=YES;
                    }
                }];
                
                [self.model.likeTheSharingUserRecords removeObjectAtIndex:index];
            }
            else{
                [self.model.likeTheSharingUserRecords insertObject:[FLXKSharedAppSingleton sharedSingleton].sharedUser atIndex:0];
            }
            self.model.isThumberuped=!self.model.isThumberuped;
            [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationNone];
    } failureCallback:^(NSError *err) {
        //        NSAssert(!err, err.description);
    }]addFriendsharingThumbup:@{@"thumberupUserID": [FLXKSharedAppSingleton sharedSingleton].sharedUser.login_name,@"newsID":_model.newsID,@"isThumberuped":[NSNumber numberWithInteger:_model.isThumberuped]}];
}


#pragma mark - Model Event
#pragma mark - Private methods



- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}
#pragma mark - getter/setter

//-(void)setupSharingCommentsTableViewWithCellModels{
//    __weak __typeof(self) weakSelf=self;
//    self.sharingCommentsTableView.addCommentBlock=^(SharingCommentCellModel* model){
//        weakSelf.currentCommentCellModel=model;
//        if ( weakSelf.addCommentBlock) {
//            weakSelf.addCommentBlock();
//        }
//    };
//}



#pragma mark - Overriden methods

#pragma mark - Navigation
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
