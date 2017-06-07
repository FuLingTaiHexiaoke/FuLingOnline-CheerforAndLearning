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

//subviews
#import "FLXKBaseSharingPictureLayoutView.h"
#import "FLXKBaseSharingCommentTableView.h"
//#import "FLXKBaseSharingLikeCollectionView.h"
//subclass
//#import "FLXKSharingFuLingOnlineStyleCell.h"
//models
#import "FLXKSharingCellModel.h"
#import "SharingCommentCellModel.h"



typedef void(^AddThumbupBlock)(UIButton* sender,FLXKSharingCellModel* model);


@interface FLXKSharingBaseCell : UITableViewCell

#pragma mark - 对外开发接口
//点赞
@property (strong, nonatomic)AddThumbupBlock addThumbupBlock;
//触发评论
@property (strong, nonatomic)void(^addCommentRequestBlock)(NSString* placeholder,FLXKSharingBaseCell* currentCell);
//添加评论信息，由外部调用。
-(void)addFriendsharingComment:(NSDictionary*)parameters;
//分享

#pragma mark - 子类接口
//刷新当前cell
- (void)reloadCurrentCell;

//当前cell所在的tableView
@property(nonatomic,weak)UITableView* tableView;

//点赞
- (void)addThumbup:(UIButton*)sender;
//评论
- (void)addCommentRequest;

//分享

-(void)hiddenSubviews;

#pragma mark - 数据
@property (strong, nonatomic)FLXKSharingCellModel* model;//单元格数据模型
@property (strong, nonatomic)NSIndexPath * indexPath;//单元格所在的行数
@property(nonatomic,strong)SharingCommentCellModel* currentCommentCellModel;//单元格评论数据模型
@end

