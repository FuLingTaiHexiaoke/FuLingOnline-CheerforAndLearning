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


@end
