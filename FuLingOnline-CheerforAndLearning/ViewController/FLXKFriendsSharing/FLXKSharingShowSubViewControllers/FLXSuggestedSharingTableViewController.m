//
//  FLXSuggestedSharingTableViewController.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by xiaoke on 17/3/5.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//
#pragma mark - Declarations and macros
//Resue identifier
#define FLXKSuggestHeaderView1 @"Reuse_FLXKSuggestHeaderView"
#define Reuse_FLXKSharingFuLingOnlineStyleCell @"Reuse_FLXKSharingFuLingOnlineStyleCell"

#import "FLXSuggestedSharingTableViewController.h"

//utilites
#import "UITableView+FDTemplateLayoutCell.h"

//child viewController


//subviews
#import "FLXKSuggestHeaderView.h"

#import "FLXKSharingBaseCell.h"
#import "FLXKSharingFuLingOnlineStyleCell.h"
#import "FLXKSharingFuLingOnlineStyleCelltest.h"


@interface FLXSuggestedSharingTableViewController ()

@end

@implementation FLXSuggestedSharingTableViewController

#pragma mark -
#pragma mark - ViewController LifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setup ui
    [self UIConfigAndAdd];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark - UI Delegates
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (nullable UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section{
    UITableViewHeaderFooterView * headerView=[self.tableView dequeueReusableHeaderFooterViewWithIdentifier:FLXKSuggestHeaderView1];
    return headerView;
}

- (nullable UITableViewHeaderFooterView *)footerViewForSection:(NSInteger)section{
    return nil;
}

-(UIView* )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView * headerView=[tableView dequeueReusableHeaderFooterViewWithIdentifier:FLXKSuggestHeaderView1];
    return headerView;
    
}

-(UIView* )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FLXKSharingBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell ];
    //    if (!cell) {
    //        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];
    //    }
    
    // Configure the cell...
    //    cell.backgroundColor=[UIColor yellowColor];
    //    cell.textLabel.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    
    
    [cell setSharingCellModel:[self setupFLXKSharingCellModel]];
    
    return cell;
}
//
//- (void)configureCell:(FLXKSharingFuLingOnlineStyleCelltest *)cell atIndexPath:(NSIndexPath *)indexPath {
//    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
//    if (indexPath.row % 2 == 0) {
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    } else {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    [cell setSharingCellModel:[self setupFLXKSharingCellModel]];
//}

#pragma mark - UITableViewDelegate
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 44.0;
//}

//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//            return [tableView fd_heightForCellWithIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell configuration:^(FLXKSharingFuLingOnlineStyleCelltest *cell) {
//                [self configureCell:cell atIndexPath:indexPath];
//            }];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 44.0;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Router(Router_Launch_NotificationCenter)
}

#pragma mark -
#pragma mark - Public Methods

#pragma mark -
#pragma mark - Private Methods

-(void)UIConfigAndAdd{
    [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSuggestHeaderView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:FLXKSuggestHeaderView1];
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSharingFuLingOnlineStyleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];

    [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSharingFuLingOnlineStyleCelltest" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];

    self.tableView.estimatedRowHeight=44;
}
-(FLXKSharingCellModel*)setupFLXKSharingCellModel{
    FLXKSharingCellModel* model=[FLXKSharingCellModel new];
//    model.avatarImageUrl=@"IMG_0488";
     model.avatarImageUrl=@"Spark";
    model.nickName=@"Spark";
    model.timestamp=@"Spark";
    model.mainSharingContent=@"Spark";
    model.sharingImages=@"Spark";
    model.locationRecord=@"Spark";
    model.likeTheSharingRecords=@"Spark";
    model.sharingComments=@"Spark";
    return model;
}

@end
