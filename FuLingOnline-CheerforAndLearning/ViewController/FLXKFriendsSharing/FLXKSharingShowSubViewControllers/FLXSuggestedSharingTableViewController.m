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
#import "UIView+Extension_IdentifierForReusable.h"
#import "FLXKHttpRequestModelHelper.h"

//child viewController


//subviews
#import "FLXKSuggestHeaderView.h"

#import "FLXKSharingBaseCell.h"
#import "FLXKSharingFuLingOnlineStyleCell.h"


@interface FLXSuggestedSharingTableViewController ()
//IBOutlet
//IBAction
//models
@property (strong, nonatomic)NSArray<FLXKSharingCellModel *> *  models;
//UI state record properties
//subviews
//child viewController
@end

@implementation FLXSuggestedSharingTableViewController

#pragma mark -
#pragma mark - ViewController LifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setup ui
    [self setupUI];
    
    [self setupFLXKSharingCellModel];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (DEBUG) {
        UIButton* btn1=[[UIButton alloc]initWithFrame:CGRectMake(150, 150, 50, 50)];
        [btn1 addTarget:self action:@selector(setupFLXKSharingCellModel) forControlEvents:UIControlEventTouchUpInside];
        btn1.backgroundColor=[UIColor yellowColor];
        [self.view addSubview:btn1];
    }
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count;
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
    [cell setSharingCellModel:_models[indexPath.row]];
    return cell;
}
//
//- (void)configureCell:(FLXKSharingBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
//    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
//    if (indexPath.row % 2 == 0) {
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    } else {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    [cell setSharingCellModel:_models[indexPath.row]];
//}

#pragma mark - UITableViewDelegate
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 44.0;
//}

//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//            return [tableView fd_heightForCellWithIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell configuration:^(FLXKSharingBaseCell *cell) {
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

-(void)setupUI{
    [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSuggestHeaderView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:FLXKSuggestHeaderView1];
    
        [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSharingFuLingOnlineStyleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSharingFuLingOnlineStyleCelltest" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];
//        [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSharingFuLingOnlineStyleCellteststep1" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];
    
//            [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSharingFuLingOnlineStyleCellstep2" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];
    
    self.tableView.estimatedRowHeight=100;
}
-(void)setupFLXKSharingCellModel{
    
    [[FLXKHttpRequestModelHelper registerSuccessCallback:^(id obj) {
        _models=(NSArray<FLXKSharingCellModel *> *)obj;
        [self.tableView reloadData];
    } failureCallback:^(NSError *err) {
//        NSAssert(!err, err.description);
    }] getFriendSharingModel];
    
}

@end
