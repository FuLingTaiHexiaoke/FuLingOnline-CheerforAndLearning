//
//  FLXKBaseSharingPictureLayoutView.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKBaseSharingOperationContainerView.h"
//child views

//utilities
#import "FLXKHttpRequestModelHelper.h"

@implementation FLXKBaseSharingOperationContainerView

-(void)setModel:(FLXKSharingCellModel *)model WithIndexPath:(NSIndexPath*)indexPath{
    self.model=model;
    self.indexPath=indexPath;
}

//点赞
-(void)addFriendsharingThumbup{
    
    [[FLXKHttpRequestModelHelper registerSuccessCallback:^(id obj) {
        
    } failureCallback:^(NSError *err) {
        //        NSAssert(!err, err.description);
    }]addFriendsharingThumbup:@{@"thumberupUserID": [FLXKSharedAppSingleton sharedSingleton].sharedUser.login_name,@"newsID":_model.newsID}];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
