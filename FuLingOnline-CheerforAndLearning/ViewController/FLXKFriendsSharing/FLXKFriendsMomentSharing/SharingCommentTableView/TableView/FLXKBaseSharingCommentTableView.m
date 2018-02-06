//
//  FLXKBaseSharingCommentTableView.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/31.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//
#pragma mark - Declarations and macros
#define REUSE_CELL_ID  @"FLXKBaseCommentCell"

#import "FLXKBaseSharingCommentTableView.h"

//subviews
#import "FLXKBaseCommentCell.h"
//models
#import "SharingCommentCellModel.h"

@interface FLXKBaseSharingCommentTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation FLXKBaseSharingCommentTableView

#pragma mark - ViewController LifeCircle

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=  [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
        self.delegate=self;
        self.dataSource=self;
        self.scrollEnabled=NO;
        self.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (instancetype)init {
    if ([super init]) {
        [self setupUI];
        self.delegate=self;
        self.dataSource=self;
        self.scrollEnabled=NO;
        self.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];
    self.delegate=self;
    self.dataSource=self;
    self.scrollEnabled=NO;
    self.separatorStyle=UITableViewCellSeparatorStyleNone;
}

#pragma mark - getter/setter
-(void)setModels:(NSArray<SharingCommentCellModel *> *)models{
    _models=models;
}

#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count>4?4:_models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FLXKBaseCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSE_CELL_ID forIndexPath:indexPath];
     [cell setModel:_models[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SharingCommentCellModel * currentModel= _models[indexPath.row];
    SharingCommentCellModel * model=[[SharingCommentCellModel alloc]init];
    model.toUserID=currentModel.fromUserID;
    model.toUserName=currentModel.fromUserName;
    if (self.addCommentRequsetBlock) {
        self.addCommentRequsetBlock(model,cell);
    }
}

#pragma mark - Private methods

-(void)setupUI{
    [self registerClass:NSClassFromString(@"FLXKBaseCommentCell")  forCellReuseIdentifier:REUSE_CELL_ID];
    self.estimatedRowHeight=40;
}

@end
