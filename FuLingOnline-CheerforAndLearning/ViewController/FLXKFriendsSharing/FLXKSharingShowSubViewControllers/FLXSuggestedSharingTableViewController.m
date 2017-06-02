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
#import "IDMPhotoBrowser.h"
#import "MJRefresh.h"
//child viewController
//#import <SDWebImage/SDWebImageManager.h>
#import "SDWebImageManager.h"
//subviews
#import "FLXKSuggestHeaderView.h"
#import "FLXKMessageToolBar.h"
#import "FLXKMessageToolBartest.h"
#import "FLXKMessageToolBartest1.h"
#import "JSMessageInputView.h"
#import "FLXKSharingBaseCell.h"
#import "FLXKSharingFuLingOnlineStyleCell.h"
#import "FLXKSharingFuLingOnlineStyleCellmasonry.h"

#import "FLXKSharingFuLingOnlineStyleCell_UIStackView.h"

#import "FLXKSharingFuLingOnlineStyleCellOnlyCommentHeight.h"

#import "FLXKSharingFuLingOnlineStyleCellOnlyCommentHeightoffScreen.h"

@interface FLXSuggestedSharingTableViewController ()
//IBOutlet
//IBAction
//models
@property (strong, nonatomic)NSMutableArray<FLXKSharingCellModel *> *  models;
@property (assign, nonatomic)NSInteger currentPageIndex;
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

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPageIndex=1;
    self.models=[NSMutableArray array];
    //setup ui
    [self setupUI];
    
    [self setupFLXKSharingCellModel];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (DEBUG) {
        UIButton* btn1=[[UIButton alloc]initWithFrame:CGRectMake(150, 150, 50, 50)];
//        [btn1 addTarget:self action:@selector(setupFLXKSharingCellModel) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addTarget:self action:@selector(buttonWithImageOnScreenPressed:) forControlEvents:UIControlEventTouchUpInside];

        btn1.backgroundColor=[UIColor yellowColor];
        [self.view addSubview:btn1];
    }
}
- (void)buttonWithImageOnScreenPressed:(id)sender
{

//    SDWebImageManager *manager = [SDWebImageManager sharedManager];
////SDWebImageManager instanceMethodForSelector:@selector(downloadImageWithURL:options:progress:completed:)
//    if ([SDWebImageManager instancesRespondToSelector:@selector(downloadImageWithURL:options:progress:completed:)]) {
//manager
//        [manager  loadImageWithURL:[NSURL URLWithString:@"http://t.i-hairs.com/upload/work/img/900/2016-03-23/e36d5fe9-7f10-4617-999c-f3dc1716ce3e.jpg"] options:SDWebImageRetryFailed|SDWebImageHandleCookies progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//
//        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
//            NSLog(@"111");
//        }];
//    }





//    UIButton *buttonSender = (UIButton*)sender;
//
//    // Create an array to store IDMPhoto objects
//    NSMutableArray *photos = [NSMutableArray new];
//    
//    IDMPhoto *photo;
//    
//    UIButton *button;
//    
//    photo = [IDMPhoto photoWithFilePath:[[NSBundle mainBundle] pathForResource:@"photo1l" ofType:@"jpg"]];
//    photo.caption = @"Grotto of the Madonna";
//
//    [photos addObject:photo];
//    
//    photo = [IDMPhoto photoWithURL:[NSURL URLWithString:@"http://t.i-hairs.com/upload/work/img/900/2016-03-23/e36d5fe9-7f10-4617-999c-f3dc1716ce3e.jpg"]];
//    photo.caption = @"jianyue2";
//
//
//    [photos addObject:photo];
//    
//    photo = [IDMPhoto photoWithURL:[NSURL URLWithString:@"http://t.i-hairs.com/upload/work/img/900/2016-03-23/51d8ebe9-f847-451d-9e74-f4405654668e.jpg"]];
//    button = [self.tableView.tableFooterView viewWithTag:103];
//    //    photo.placeholderImageView = button.imageView;
//    [photos addObject:photo];
//    
//    // Create and setup browser
//    //    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos animatedFromView:sender]; // using initWithPhotos:animatedFromView: method to use the zoom-in animation
//    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos];
////    browser.delegate = self;
//    //    browser.displayActionButton = NO;
//    //    browser.displayArrowButton = YES;
//    //    browser.displayCounterLabel = YES;
//    //    browser.usePopAnimation = YES;
//    //    browser.scaleImage = buttonSender.currentImage;
//    //    if(buttonSender.tag == 102) browser.useWhiteBackgroundColor = YES;
//    //    browser.trackTintColor = [UIColor yellowColor];
//    //    browser.progressTintColor = [UIColor redColor];
//    [browser setInitialPageIndex:buttonSender.tag-101];
//    // Show
//    [self presentViewController:browser animated:YES completion:nil];
}



-(void)viewWillAppear:(BOOL)animated{
//    [self setupMessageToolBar];
}

-(void)viewDidAppear:(BOOL)animated{
        [self setupMessageToolBar];
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
    FLXKSharingBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell forIndexPath:indexPath];
//
//    [cell.contentView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (obj.firstItem==cell.contentView&& obj.firstAttribute==NSLayoutAttributeHeight) {
//            [cell.contentView removeConstraint:obj];
//        }
//    }];
    [cell setModel:_models[indexPath.row]];
    [cell setIndexPath:indexPath];
    __weak __typeof(self) weakSelf=self;
    cell.addCommentRequestBlock=^(NSString* placeholder,FLXKSharingBaseCell* currentCell){
        [weakSelf showToolBarWithPlaceholder:placeholder];
        weakSelf.currentOperationCell=currentCell;
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
        FLXKSharingBaseCell* currentCell = (FLXKSharingBaseCell*) cell;
    
//    [currentCell setModel:_models[indexPath.row]];
//    [currentCell setIndexPath:indexPath];
//    __weak __typeof(self) weakSelf=self;
//    currentCell.addCommentRequestBlock=^(NSString* placeholder,FLXKSharingBaseCell* currentCell){
//        [weakSelf showToolBarWithPlaceholder:placeholder];
//        weakSelf.currentOperationCell=currentCell;
//    };
    

//    [currentCell loadComments];
}

//-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    [self.tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//          FLXKSharingBaseCell* currentCell = (FLXKSharingBaseCell*) obj;
//          [currentCell loadComments];
//    }];
//}

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
//    
////  CGFloat height=   [tableView fd_heightForCellWithIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell configuration:^(FLXKSharingBaseCell *cell) {
////                [self configureCell:cell atIndexPath:indexPath];
////            }];
//    
////    CGFloat height=   [tableView fd_heightForCellWithIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell cacheByIndexPath:indexPath configuration:^(id cell) {
////                   [self configureCell:cell atIndexPath:indexPath];
////    }];
////        return height;
//    
//    return _models[indexPath.row].cell_Height;
//
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
//    [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSuggestHeaderView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:FLXKSuggestHeaderView1];
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSharingFuLingOnlineStyleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];
    
    
//        [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSharingFuLingOnlineStyleCell_UIStackView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];
    
    self.tableView.separatorInset=UIEdgeInsetsMake(2,0,2,0);
    self.tableView.backgroundColor=[UIColor lightGrayColor];
//        [self.tableView registerClass:NSClassFromString(@"FLXKSharingFuLingOnlineStyleCell") forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];
       [self.tableView registerClass:NSClassFromString(@"FLXKSharingFuLingOnlineStyleCellOnlyCommentHeight") forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];
    
//           [self.tableView registerClass:NSClassFromString(@"FLXKSharingFuLingOnlineStyleCellOnlyCommentHeightoffScreen") forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];

    
    //    [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSharingFuLingOnlineStyleCellautolayouttest" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCellautolayouttest];
    //        [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSharingFuLingOnlineStyleCellteststep1" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];
    
    //            [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSharingFuLingOnlineStyleCellstep2" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Reuse_FLXKSharingFuLingOnlineStyleCell];
    
    self.tableView.estimatedRowHeight=100;
//      self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //   FLXKMessageToolBartest*  test=[[FLXKMessageToolBartest alloc]initWithCustomFrame:CGRectMake(0, 200, self.view.frame.size.width, 50)];
    
//    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
//    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    @weakify(self)
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
         self.currentPageIndex=1;
        [self setupFLXKSharingCellModel];
    } ];
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self setupFLXKSharingCellModel];
    } ];
}

-(void)setupMessageToolBar{
    if (_messageToolBar) {
        _messageToolBar=  [FLXKMessageToolBar   sharedMessageToolBarWithPlacehoder:@"test" containerView:self.view.superview.superview  showingOption:MessageToolBarShowingOption_EMOTION_BUTTON];
    }
    else{
        [_messageToolBar removeFromSuperview];
        _messageToolBar=  [FLXKMessageToolBar   sharedMessageToolBarWithPlacehoder:@"test" containerView:self.view.superview.superview  showingOption:MessageToolBarShowingOption_EMOTION_BUTTON];
        _messageToolBar.backgroundColor=[UIColor yellowColor];
        [self.view.superview.superview  addSubview:_messageToolBar];
        @weakify(self)
        
        _messageToolBar.sendMessageBlock=^(NSString* message){
            @strongify(self)
            [self sendComment:message];
        };
        
        _messageToolBar.growingTextViewChangeHeight=^(CGFloat height){
            @strongify(self)
            [self growingTextViewChangeHeight:height];
        };
        [_messageToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(48);
            make.width.mas_equalTo(self.view.superview.superview.mas_width);
            make.bottom.mas_equalTo(((UIViewController*)(self.view.superview.superview.nextResponder)).mas_bottomLayoutGuide).offset(100);
        }];
    }
}
//
-(void)showToolBarWithPlaceholder:(NSString*) placeholder{
    
    [_messageToolBar showToolBarWithPlaceholder:placeholder];
}

- (void)growingTextViewChangeHeight:(float)height
{
    [UIView animateWithDuration:0.1 delay:0.0 usingSpringWithDamping:10.0 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [_messageToolBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}


-(void)setupFLXKSharingCellModel{

    @weakify(self)
    [[FLXKHttpRequestModelHelper registerSuccessCallback:^(id obj) {
        @strongify(self)
        if (obj) {
            if (self.currentPageIndex==1) {
                [_models removeAllObjects];
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            self.currentPageIndex+=1;
            [_models addObjectsFromArray:(NSArray<FLXKSharingCellModel *> *)obj];
            [self.tableView reloadData];
        }
    } failureCallback:^(NSError *err) {
        //        NSAssert(!err, err.description);
    }] getFriendSharingModelWithCondition:@{@"page":@(self.currentPageIndex),@"userID":[FLXKSharedAppSingleton sharedSingleton].sharedUser.login_name?:@"test"}];
    
}


-(void)sendComment:(NSString *)message{
    
    [self.currentOperationCell addFriendsharingComment:@{@"content":message}];
    self.currentOperationCell=nil;
}



@end
