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
//#import "FLXKSharingCellModel.h"

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

-(void)setSharingCellModel:(FLXKSharingCellModel *)sharingCellModel{
    _sharingCellModel=sharingCellModel;
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
  
    } failureCallback:^(NSError *err) {
        //        NSAssert(!err, err.description);
    }]addFriendsharingThumbup:@{@"thumberupUserID": [FLXKSharedAppSingleton sharedSingleton].sharedUser.login_name,@"newsID":_sharingCellModel.newsID}];
}

#pragma mark - Model Event
#pragma mark - Private methods
#pragma mark - getter/setter
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
