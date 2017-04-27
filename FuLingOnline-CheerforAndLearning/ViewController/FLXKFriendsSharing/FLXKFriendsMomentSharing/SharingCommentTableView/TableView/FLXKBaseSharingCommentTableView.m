//
//  FLXKBaseSharingCommentTableView.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/31.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//
#pragma mark - Declarations and macros

#import "FLXKBaseSharingCommentTableView.h"
//utilites
#import "UITableView+FDTemplateLayoutCell.h"
//models
//subviews
#import "FLXKBaseCommentCell.h"
//child viewController
@interface FLXKBaseSharingCommentTableView ()<UITableViewDataSource,UITableViewDelegate>
//IBOutlet
//IBAction
//models
#import "SharingCommentCellModel.h"
//UI state record properties
//subviews
//child viewController
@end

@implementation FLXKBaseSharingCommentTableView

#pragma mark - ViewController LifeCircle

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];
    self.delegate=self;
    self.dataSource=self;
    self.scrollEnabled=NO;
    self.separatorStyle=UITableViewCellSeparatorStyleNone;
    
}

//-(void)dealloc{
//    NSLog(@"%@ 销毁",NSStringFromClass(self.class));
//}


#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FLXKBaseCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:[FLXKBaseCommentCell identifierForReusable] ];
//    [self configureCell:cell atIndexPath:indexPath];
     [cell setModel:_models[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   SharingCommentCellModel * model= _models[indexPath.row];
    model.toUserID=model.fromUserID;
    model.toUserName=model.fromUserName;
    if (self.addCommentRequsetBlock) {
        self.addCommentRequsetBlock(model);
    }

//  SharingCommentCellModel* model= _models[indexPath.row];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  [self fd_heightForCellWithIdentifier:[FLXKBaseCommentCell identifierForReusable] configuration:^(FLXKBaseCommentCell *cell) {
        [self configureCell:cell withModel:_models[indexPath.row]];
    }];
}

#pragma mark - Public methods

//-(void)setModels:(NSArray<NSString *> *)models{
//    _models=models;
//    [self reloadData];
//}
-(CGFloat)setCellModels:(NSArray<SharingCommentCellModel *> *)models{
    self.models=models;
    CGFloat height= [self getTableHeight];//执行顺序有待测试
    return height;
}


#pragma mark - View Event
#pragma mark - Model Event
#pragma mark - Private methods
-(void)setupUI{
    
    [self registerNib:[UINib nibWithNibName:@"FLXKBaseCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[FLXKBaseCommentCell identifierForReusable]];
    
    self.estimatedRowHeight=40;
}

-(CGFloat)getTableHeight{
    __block CGFloat currentHeight=0;
    [_models enumerateObjectsUsingBlock:^(SharingCommentCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        currentHeight +=  [self fd_heightForCellWithIdentifier:[FLXKBaseCommentCell identifierForReusable] configuration:^(FLXKBaseCommentCell *cell) {
            [self configureCell:cell withModel:obj];
        }];
    }];
    return currentHeight;
}

//- (void)configureCell:(FLXKBaseCommentCell *)cell atIndexPath:(NSIndexPath *)indexPath {
//    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
//    //    if (indexPath.row % 2 == 0) {
//    //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    //    } else {
//    //        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    //    }
//    [cell setModel:_models[indexPath.row]];
//}

- (void)configureCell:(FLXKBaseCommentCell *)cell withModel:(SharingCommentCellModel *)model {
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    [cell setModel:model];
}

#pragma mark - getter/setter
-(void)setModels:(NSArray<SharingCommentCellModel *> *)models{
    _models=models;
    [self reloadData];
}
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
