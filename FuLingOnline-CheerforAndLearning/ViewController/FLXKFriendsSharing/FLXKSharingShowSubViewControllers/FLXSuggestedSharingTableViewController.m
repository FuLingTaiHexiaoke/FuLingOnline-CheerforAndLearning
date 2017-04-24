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

#define Reuse_FLXKSharingFuLingOnlineStyleCellautolayouttest @"Reuse_FLXKSharingFuLingOnlineStyleCellautolayouttest"
#define DDINPUT_MIN_HEIGHT          44.0f


#import "FLXSuggestedSharingTableViewController.h"

//utilites
#import "UITableView+FDTemplateLayoutCell.h"
#import "UIView+Extension_IdentifierForReusable.h"
#import "FLXKHttpRequestModelHelper.h"

//child viewController


//subviews
#import "FLXKSuggestHeaderView.h"
#import "FLXKMessageToolBar.h"
#import "FLXKMessageToolBartest.h"
#import "FLXKMessageToolBartest1.h"
#import "JSMessageInputView.h"
#import "FLXKSharingBaseCell.h"
#import "FLXKSharingFuLingOnlineStyleCell.h"
#import "FLXKSharingFuLingOnlineStyleCellautolayouttest.h"


@interface FLXSuggestedSharingTableViewController ()
//IBOutlet
//IBAction
//models
@property (strong, nonatomic)NSArray<FLXKSharingCellModel *> *  models;
@property(nonatomic,strong)JSMessageInputView *chatInputView;
//UI state record properties
//subviews
@property(nonatomic,strong)   FLXKMessageToolBar* test;
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

-(void)viewWillAppear:(BOOL)animated{
    [_test removeFromSuperview];
    _test=  [FLXKMessageToolBar   sharedMessageToolBarWithPlacehoder:@"test" containerView:self.view  showingOption:MessageToolBarShowingOption_EMOTION_BUTTON];
    @weakify(self)
    _test.growingTextViewChangeHeight=^(CGFloat height){
        @strongify(self)
        [self growingTextViewChangeHeight:height];
    };
    //frame
    //       FLXKMessageToolBartest1* test= [[FLXKMessageToolBartest1 alloc]initWithCustomFrame:CGRectMake(0, 200, self.view.frame.size.width, 50)];
    NSLog(@"messageToolBar fram2 %@", NSStringFromCGRect(_test.frame));
    
    _test.tag=1000;
    //    FLXKMessageToolBar* test= [[FLXKMessageToolBar alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    //
    [self.tableView addSubview:_test];
    [_test mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(48);
        make.width.mas_equalTo(self.view.mas_width);
        //        make.left.mas_equalTo(self.tableView.mas_left);
        //        make.right.mas_equalTo(self.tableView.mas_right);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide).offset(100);
    }];
    
    _test.backgroundColor=[UIColor yellowColor];

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
    //    FLXKSharingBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCellautolayouttest];
    //    [cell setSharingCellModel:_models[indexPath.row] WithIndexPath:indexPath ];
    //    NSLog(@"indexPath.row %ld", (long)indexPath.row);
    [cell setSharingCellModel:_models[indexPath.row]];
    [cell setIndexPath:indexPath];
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
    
    //    [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSharingFuLingOnlineStyleCellautolayouttest" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCellautolayouttest];
    //        [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSharingFuLingOnlineStyleCellteststep1" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];
    
    //            [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSharingFuLingOnlineStyleCellstep2" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];
    
    self.tableView.estimatedRowHeight=100;
    
//    CGRect inputFrame = CGRectMake(0, CONTENT_HEIGHT - DDINPUT_MIN_HEIGHT + NAVBAR_HEIGHT,FULL_WIDTH,DDINPUT_MIN_HEIGHT);
//    CGRect inputFrame =CGRectMake(0, 200, self.view.frame.size.width, 50);
//    self.chatInputView = [[JSMessageInputView alloc] initWithFrame:inputFrame delegate:nil];
//    [self.chatInputView setBackgroundColor:RGBA(249, 249, 249, 0.9)];
//    [self.view addSubview:self.chatInputView];
//   FLXKMessageToolBartest*  test=[[FLXKMessageToolBartest alloc]initWithCustomFrame:CGRectMake(0, 200, self.view.frame.size.width, 50)];
    
    //autolayout
//    FLXKMessageToolBar* test= [[FLXKMessageToolBar alloc]initWithCustomFrame:CGRectMake(0, 200, self.view.frame.size.width, 50)];
    
//    UIButton* btn1=[[UIButton alloc]initWithFrame:CGRectMake(0, 150, 50, 50)];
        UIButton* btn1=[[UIButton alloc]init];
    [btn1 addTarget:self action:@selector(messageToolBarBecomeFirstResponder:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
         btn1.backgroundColor=[UIColor redColor];

    
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
                   make.width.mas_equalTo(self.view.mas_width);
    //        make.left.mas_equalTo(self.tableView.mas_left);
    //        make.right.mas_equalTo(self.tableView.mas_right);
                make.bottom.mas_equalTo(self.view.superview.bottom).offset(100);
        }];
    
//    [_test mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(40);
//               make.width.mas_equalTo(self.view.mas_width);
////        make.left.mas_equalTo(self.tableView.mas_left);
////        make.right.mas_equalTo(self.tableView.mas_right);
//        make.top.mas_equalTo(self.tableView.top).offset(200);
//    }];
    

    
    
}

-(void)messageToolBarBecomeFirstResponder:(UIButton*)sender{
    [_test messageToolBarBecomeFirstResponder];
//    CGFloat height=  sender.tag==0?80:40;
    
//    [sender mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(height);
//    }];
//    [UIView animateWithDuration:0.1 delay:0.0 usingSpringWithDamping:10.0 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        
//        [_test mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(height);
//        }];
//        
//        [self.view layoutIfNeeded];
//    } completion:^(BOOL finished) {
//        
//    }];
//
//    
//    sender.tag=sender.tag==0?1:0;
}

- (void)growingTextViewChangeHeight:(float)height
{
    [UIView animateWithDuration:0.1 delay:0.0 usingSpringWithDamping:10.0 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [_test mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
        
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}



-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
//    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (obj.tag==1000) {
//            CGRect r =obj.frame;
//   NSLog(@"messageToolBar enumerateObjectsUsingBlock  %@", NSStringFromCGRect( r));
//        }
//    }];
    

    
}


-(void)setupFLXKSharingCellModel{
    
    [[FLXKHttpRequestModelHelper registerSuccessCallback:^(id obj) {
        if (obj) {
            _models=(NSArray<FLXKSharingCellModel *> *)obj;
            [self.tableView reloadData];
        }
    } failureCallback:^(NSError *err) {
        //        NSAssert(!err, err.description);
    }] getFriendSharingModelWithCondition:@{@"page":@1,@"userID":[FLXKSharedAppSingleton sharedSingleton].sharedUser.login_name?:@"test"}];
    
}

@end
