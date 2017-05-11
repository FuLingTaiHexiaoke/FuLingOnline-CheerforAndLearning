//
//  SharingBaseCell.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/29.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#define content_default_height 40

#import <UIKit/UIKit.h>
//utilites
#import "NSAttributedString+EmotionExtension.h"
//child viewController
//subviews
#import "FLXKBaseSharingPictureLayoutView.h"
#import "FLXKBaseSharingCommentTableView.h"
//#import "FLXKBaseSharingLikeCollectionView.h"
//subclass
//#import "FLXKSharingFuLingOnlineStyleCell.h"
//models
#import "FLXKSharingCellModel.h"
#import "SharingCommentCellModel.h"


@interface FLXKSharingBaseCell : UITableViewCell

//IBOutlet
//IBAction
//头像点击事件
//名称
//分享的文本内容
//分享的图片
//分享时间戳
//删除分享

//点赞
- (void)addThumbup:(UIButton*)sender;
-(void)addFriendsharingThumbup;


//评论
//触发评论
@property (strong, nonatomic)void(^addCommentRequestBlock)(NSString* placeholder,FLXKSharingBaseCell* currentCell);

- (void)addCommentRequest;
-(void)addFriendsharingComment:(NSDictionary*)parameters;
- (void)reloadCurrentCell;
-(void)loadComments;
//分享


//child viewController
//subviews
//models
@property(nonatomic,strong)SharingCommentCellModel* currentCommentCellModel;
//-(void)setSharingCellModel:(FLXKSharingCellModel *)model  WithIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic)FLXKSharingCellModel* model;
@property (strong, nonatomic)NSIndexPath * indexPath;


//UI state record properties
@end

