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
#import "FLXKSharingFuLingOnlineStyleCellmasonry.h"


@interface FLXSuggestedSharingTableViewController ()
//IBOutlet
//IBAction
//models
@property (strong, nonatomic)NSArray<FLXKSharingCellModel *> *  models;
@property(nonatomic,strong)JSMessageInputView *chatInputView;
//UI state record properties
//@property(nonatomic,strong)SharingCommentCellModel* currentCommentCellModel;
@property(nonatomic,strong)FLXKSharingBaseCell* currentOperationCell;
//subviews
@property(nonatomic,strong)   FLXKMessageToolBar* messageToolBar;
//child viewController
@end

@implementation FLXSuggestedSharingTableViewController

#pragma mark -
#pragma mark - ViewController LifeCircle

-(void)awakeFromNib{
    [super awakeFromNib];
    self.tableView.estimatedRowHeight=100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

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
//    [self setupMessageToolBar];
}

-(void)viewDidAppear:(BOOL)animated{
//    [self.tableView reloadData];
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

//- (nullable UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section{
//    UITableViewHeaderFooterView * headerView=[self.tableView dequeueReusableHeaderFooterViewWithIdentifier:FLXKSuggestHeaderView1];
//    return headerView;
//}
//
//- (nullable UITableViewHeaderFooterView *)footerViewForSection:(NSInteger)section{
//    return nil;
//}
//
//-(UIView* )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UITableViewHeaderFooterView * headerView=[tableView dequeueReusableHeaderFooterViewWithIdentifier:FLXKSuggestHeaderView1];
//    return headerView;
//    
//}
//
//-(UIView* )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    return nil;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FLXKSharingFuLingOnlineStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[FLXKSharingFuLingOnlineStyleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];
    }
    else{
        NSLog(@"cell 重用了");
//        cell.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    }
    [cell.contentView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.firstItem==cell.contentView&& obj.firstAttribute==NSLayoutAttributeHeight) {
            [cell.contentView removeConstraint:obj];
        }
    }];
    [cell setModel:_models[indexPath.row]];
    [cell setIndexPath:indexPath];
    __weak __typeof(self) weakSelf=self;
    cell.addCommentRequestBlock=^(NSString* placeholder,FLXKSharingBaseCell* currentCell){
//        [weakSelf showToolBarWithPlaceholder:placeholder];
        weakSelf.currentOperationCell=currentCell;
    };
    return cell;
}
//
- (void)configureCell:(FLXKSharingBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
[cell setModel:_models[indexPath.row]];
}

#pragma mark - UITableViewDelegate
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 44.0;
//}

//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
// NSLog(@"indexPath.row %lu",(unsigned long)indexPath.row);
//    
//  CGFloat height=   [tableView fd_heightForCellWithIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell configuration:^(FLXKSharingBaseCell *cell) {
//                [self configureCell:cell atIndexPath:indexPath];
//            }];
//    
//     NSLog(@"indexPath.row %lu %f",(unsigned long)indexPath.row,height);
//    return height;
//}

//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 100;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 44.0;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 44.0;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    Router(Router_Launch_NotificationCenter)
}

#pragma mark - Scroll Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.messageToolBar hideToolBar];
}


#pragma mark -
#pragma mark - Public Methods

#pragma mark -
#pragma mark - Private Methods

-(void)setupUI{
    [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSuggestHeaderView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:FLXKSuggestHeaderView1];
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSharingFuLingOnlineStyleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];
    
        [self.tableView registerClass:NSClassFromString(@"FLXKSharingFuLingOnlineStyleCell") forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];
//       [self.tableView registerClass:NSClassFromString(@"FLXKSharingFuLingOnlineStyleCellmasonry") forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];
    
    
    
    //    [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSharingFuLingOnlineStyleCellautolayouttest" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCellautolayouttest];
    //        [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSharingFuLingOnlineStyleCellteststep1" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];
    
    //            [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSharingFuLingOnlineStyleCellstep2" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];
    
    self.tableView.estimatedRowHeight=100;
      self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //   FLXKMessageToolBartest*  test=[[FLXKMessageToolBartest alloc]initWithCustomFrame:CGRectMake(0, 200, self.view.frame.size.width, 50)];
    

}

//-(void)setupMessageToolBar{
//    if (_messageToolBar) {
//        _messageToolBar=  [FLXKMessageToolBar   sharedMessageToolBarWithPlacehoder:@"test" containerView:self.view.superview.superview  showingOption:MessageToolBarShowingOption_EMOTION_BUTTON];
//    }
//    else{
//        [_messageToolBar removeFromSuperview];
//        _messageToolBar=  [FLXKMessageToolBar   sharedMessageToolBarWithPlacehoder:@"test" containerView:self.view.superview.superview  showingOption:MessageToolBarShowingOption_EMOTION_BUTTON];
//        _messageToolBar.backgroundColor=[UIColor yellowColor];
//        [self.view.superview.superview  addSubview:_messageToolBar];
//        @weakify(self)
//        
//        _messageToolBar.sendMessageBlock=^(NSString* message){
//            @strongify(self)
//            [self sendComment:message];
//        };
//        
//        _messageToolBar.growingTextViewChangeHeight=^(CGFloat height){
//            @strongify(self)
//            [self growingTextViewChangeHeight:height];
//        };
//        [_messageToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(48);
//            make.width.mas_equalTo(self.view.superview.superview.mas_width);
//            make.bottom.mas_equalTo(((UIViewController*)(self.view.superview.superview.nextResponder)).mas_bottomLayoutGuide).offset(100);
//        }];
//    }
//}
//
//-(void)showToolBarWithPlaceholder:(NSString*) placeholder{
//    
//    [_messageToolBar showToolBarWithPlaceholder:placeholder];
//}
//
//- (void)growingTextViewChangeHeight:(float)height
//{
//    [UIView animateWithDuration:0.1 delay:0.0 usingSpringWithDamping:10.0 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        [_messageToolBar mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(height);
//        }];
//        [self.view layoutIfNeeded];
//    } completion:^(BOOL finished) {
//        
//    }];
//}

//
//
//-(void)viewWillLayoutSubviews
//{
//    [super viewWillLayoutSubviews];
//
//    //    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//    //        if (obj.tag==1000) {
//    //            CGRect r =obj.frame;
//    //   NSLog(@"messageToolBar enumerateObjectsUsingBlock  %@", NSStringFromCGRect( r));
//    //        }
//    //    }];
//
//
//
//}


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


-(void)sendComment:(NSString *)message{
    
    [self.currentOperationCell addFriendsharingComment:@{@"content":message}];
    self.currentOperationCell=nil;
}


@end
