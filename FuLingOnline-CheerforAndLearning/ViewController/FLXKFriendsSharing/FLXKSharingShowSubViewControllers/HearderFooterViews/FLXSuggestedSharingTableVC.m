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
#define ReuseCellID @"FLXKSharingFuLingOnlineStyleCellMansory"
#define DDINPUT_MIN_HEIGHT  44.0f


#import "FLXSuggestedSharingTableVC.h"

//utilites
#import "MJRefresh.h"
#import "FLXKHttpRequestModelHelper.h"
#import "UITextView+Extensions.h"
#import "UITableView+FDTemplateLayoutCell.h"

//subviews
#import "FLXKSuggestHeaderView.h"
#import "FLXKMessageToolBar.h"
#import "FLXKSharingBaseCell.h"

#import "FLXKSharingFuLingOnlineStyleCellMansory.h"


@interface FLXSuggestedSharingTableVC ()
//models
@property (strong, nonatomic)NSMutableArray<FLXKSharingCellModel *> *  models;
@property (assign, nonatomic)NSInteger currentPageIndex;

//记录当前评论信息
@property(nonatomic,strong)SharingCommentCellModel* currentCommentCellModel;
@property(nonatomic,strong)NSIndexPath* currentCommentCellIndex;
//@property(nonatomic,strong)FLXKSharingCellModel* currentCommentCellTopModel;
//记录当前点赞信息
//@property(nonatomic,strong)FLXKSharingCellModel* currentThumberUpCellTopModel;
@property(nonatomic,strong)NSIndexPath* currentThumberUpCellIndex;

//subviews
@property(nonatomic,strong)FLXKMessageToolBar* messageToolBar;
@property(nonatomic,assign)BOOL isToolBarShowing;


@end

@implementation FLXSuggestedSharingTableVC

#pragma mark - ViewController LifeCircle

-(void)awakeFromNib{
    [super awakeFromNib];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    self.currentPageIndex=1;
    self.models=[NSMutableArray array];
    [self getFLXKSharingCellModel];
    //    if (DEBUG) {
    //        UIButton* btn1=[[UIButton alloc]initWithFrame:CGRectMake(150, 150, 50, 50)];
    //        [btn1 addTarget:self action:@selector(setupFLXKSharingCellModel) forControlEvents:UIControlEventTouchUpInside];
    //        btn1.backgroundColor=[UIColor yellowColor];
    //        [self.view addSubview:btn1];
    //    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self setupMessageToolBar];
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FLXKSharingBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseCellID forIndexPath:indexPath];
    [cell setModel:_models[indexPath.row]];
    [cell setIndexPath:indexPath];
    __weak __typeof(self) weakSelf=self;
    cell.addCommentBlock=^(NSString* placeholder,SharingCommentCellModel* model,UIView* tapedView,NSIndexPath * indexPath){
        [weakSelf showToolBarWithPlaceholder:placeholder tapedView:tapedView];
        weakSelf.currentCommentCellIndex=indexPath;
        weakSelf.currentCommentCellModel=model;
    };
    cell.addThumbupBlock=^(UIButton* sender,NSIndexPath * indexPath){
        weakSelf.currentThumberUpCellIndex=indexPath;
        [weakSelf   addFriendsharingThumbup];
        //显示动画效果
        [weakSelf startThumberUpAnimation:sender];
    };
    
    return cell;
}

#pragma mark - UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
////  return  [tableView fd_heightForCellWithIdentifier:ReuseCellID cacheByIndexPath:indexPath configuration:^(id cell) {
////       [cell setModel:_models[indexPath.row]];
////    }];
//    
//    return  [tableView fd_heightForCellWithIdentifier:ReuseCellID  configuration:^(id cell) {
//        [cell setModel:_models[indexPath.row]];
//    }];
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    NSInteger row=  indexPath.row%3;
//    switch (row) {
//        case 0:
//            Router(Router_Launch_NotificationCenter)
//            break;
//        case 1:
//            Router(Router_TabBar_FriendsSharing_NewsPublish_test1)
//            break;
//        case 2:
//            Router(Router_TabBar_FriendsSharing_NewsPublish_test2)
//            break;
//        default:
//            break;
//    }
}


#pragma mark - Scroll Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    NSLog(@"%@,%f",scrollView, scrollView.contentOffset.y);
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isToolBarShowing=NO;
    [self.messageToolBar hideToolBar];
}

#pragma mark - Private Methods

-(void)setupUI{
    //    [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSuggestHeaderView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:FLXKSuggestHeaderView1];
    
    self.tableView.separatorInset=UIEdgeInsetsMake(2,0,2,0);
    self.tableView.backgroundColor=[UIColor lightGrayColor];
    [self.tableView registerClass:NSClassFromString(ReuseCellID) forCellReuseIdentifier:ReuseCellID];
    self.tableView.estimatedRowHeight=100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;//for ios7 or older
    
    //注册刷新功能
    @weakify(self)
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.currentPageIndex=1;
        [self getFLXKSharingCellModel];
    } ];
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self getFLXKSharingCellModel];
    } ];
    [self.tableView.mj_header beginRefreshing];
    
}

-(void)setupMessageToolBar{
    if (!_messageToolBar) {
        UIFont* font = [UIFont systemFontOfSize:FLXKMessageToolBar_Font_Size];
        _messageToolBar=  [FLXKMessageToolBar   sharedMessageToolBarWithPlacehoder:@"test" containerView:self.view.superview.superview  showingOption:MessageToolBarShowingOption_EMOTION_BUTTON textViewFont:font];
        
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
        //表情输入面板中的NSAutolayout会自动调整新的布局信息。忽略Masonry
        
        //修改人:肖科    修改时间:2017-4-25  修改原因:自定义UITextView得出的高度有偏差，具体原因还没有找到
        //修改内容:--修改如下。
        //         CGFloat height=  [UITextView getTextViewWithAttributes:@{NSAttachmentAttributeName:font} rows:0]+7+7;
        //不知道为什么，突然这个方法就不行了。
        //        CGFloat height=  [_messageToolBar.growingTextView.internalTextView getTextViewWithAttributes:@{NSAttachmentAttributeName:font} rows:0]+7+7;//有点硬编码了
        CGFloat height=  _messageToolBar.growingTextView.minHeight+7+7;//有点硬编码了
        //修改内容:修改如下--。
        
        [_messageToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
            make.width.mas_equalTo(self.view.superview.superview.mas_width);
            make.bottom.mas_equalTo(((UIViewController*)(self.view.superview.superview.nextResponder)).mas_bottomLayoutGuide).offset(100);
        }];
    }
    //重新初始化控件
    else{
        UIFont* font = [UIFont systemFontOfSize:FLXKMessageToolBar_Font_Size];
        _messageToolBar=  [FLXKMessageToolBar   sharedMessageToolBarWithPlacehoder:@"test" containerView:self.view.superview.superview  showingOption:MessageToolBarShowingOption_EMOTION_BUTTON textViewFont:font];
    }
}
//
-(void)showToolBarWithPlaceholder:(NSString*)placeholder tapedView:(UIView*)tapedView{
    if (!_isToolBarShowing) {
        [_messageToolBar showToolBarWithPlaceholder:placeholder tapedView:tapedView scrollView:self.tableView];
    }
    else{
        [self.messageToolBar hideToolBar];
    }
    _isToolBarShowing=!_isToolBarShowing;
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

-(void)startThumberUpAnimation:(UIButton*)sender{
    FLXKSharingCellModel* model= self.models[self.currentCommentCellIndex.row];
    if (model.isThumberuped==1) {
        [sender setImage:[UIImage imageNamed:@"sharing_thumbup_n"]  forState:UIControlStateNormal];
    }
    else{
        [sender setImage:[UIImage imageNamed:@"sharing_thumbup_s"]  forState:UIControlStateNormal];
    }
    //此处的逻辑没有弄得太懂，为什么没有按照预想的变化
    //    [UIView animateWithDuration:1.0 animations:^{
    ////        NSLog(@"NSStringFromCGAffineTransform %@",NSStringFromCGAffineTransform(sender.imageView.transform));
    //        sender.imageView.transform=CGAffineTransformScale(sender.imageView.transform, 0.4, 0.4);
    //    } completion:^(BOOL finished) {
    //        sender.imageView.transform=CGAffineTransformIdentity;
    //    }];
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    theAnimation.duration=2;
    theAnimation.autoreverses=YES;
//    theAnimation.fillMode = kCAFillModeBackwards;
//    theAnimation.removedOnCompletion = NO;
    theAnimation.fromValue = [NSNumber numberWithFloat:1];
    theAnimation.toValue = [NSNumber numberWithFloat:4.0];
    [sender.imageView.layer addAnimation:theAnimation forKey:@"animateTransform"];
}

#pragma mark - 内部网络请求
-(void)getFLXKSharingCellModel{
    @weakify(self)
    [[FLXKHttpRequestModelHelper registerSuccessCallback:^(id obj) {
        @strongify(self)
        if (obj) {
            if (((NSArray*)obj).count==0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            else{
                if (self.currentPageIndex==1) {
                    [_models removeAllObjects];
                }
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                self.currentPageIndex+=1;
                [_models addObjectsFromArray:(NSArray<FLXKSharingCellModel *> *)obj];
                [self.tableView reloadData];
            }
        }
        
    } failureCallback:^(NSError *err) {
    }] getFriendSharingModelWithCondition:@{@"page":@(self.currentPageIndex),@"userID":[FLXKSharedAppSingleton sharedSingleton].sharedUser.login_name?:@"test"}];
    
}
//点赞
-(void)addFriendsharingThumbup{
    __block      FLXKSharingCellModel* model= self.models[self.currentThumberUpCellIndex.row];
    @weakify(self)
    [[FLXKHttpRequestModelHelper registerSuccessCallback:^(id obj) {
        @strongify(self)
        
        if (model.isThumberuped) {
            __block  NSInteger index;
            [model.likeTheSharingUserRecords enumerateObjectsUsingBlock:^(UserModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.login_name isEqualToString:[FLXKSharedAppSingleton sharedSingleton].sharedUser.login_name ]) {
                    index=idx;
                    *stop=YES;
                }
            }];
            
            [model.likeTheSharingUserRecords removeObjectAtIndex:index];
        }
        else{
            [model.likeTheSharingUserRecords insertObject:[FLXKSharedAppSingleton sharedSingleton].sharedUser atIndex:0];
        }
        model.isThumberuped=!model.isThumberuped;
        [self.tableView reloadRowsAtIndexPaths:@[self.currentThumberUpCellIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
        //        [self.tableView reloadData];//这种效果更加不好
    } failureCallback:^(NSError *err) {
        //        NSAssert(!err, err.description);
    }]addFriendsharingThumbup:@{@"thumberupUserID": [FLXKSharedAppSingleton sharedSingleton].sharedUser.login_name,@"newsID":model.newsID,@"isThumberuped":[NSNumber numberWithInteger:model.isThumberuped]}];
}

//添加评论信息，由外部调用。
-(void)sendComment:(NSString *)message{
    __block      FLXKSharingCellModel* cellModel= self.models[self.currentCommentCellIndex.row];
    SharingCommentCellModel* model=[SharingCommentCellModel new];
    model.fromUserID= [FLXKSharedAppSingleton sharedSingleton].sharedUser.login_name?:@"test";
    model.fromUserName=[FLXKSharedAppSingleton sharedSingleton].sharedUser.name?:@"test";
    if (self.currentCommentCellModel.toUserID) {
        model.toUserID=self.currentCommentCellModel.toUserID;
        model.toUserName=self.currentCommentCellModel.toUserName;
        model.isReply=1;
    }
    model.content=message;
    model.newsID=cellModel.newsID;
    
    NSDictionary*   parameters=[model modelToDic];
    
    [[FLXKHttpRequestModelHelper registerSuccessCallback:^(id obj) {
        [cellModel.sharingComments addObject:model];
        cellModel.sharingComments=cellModel.sharingComments;
        [self.tableView reloadRowsAtIndexPaths:@[self.currentCommentCellIndex] withRowAnimation:UITableViewRowAnimationNone];
        //            [self.tableView reloadData];//这种效果更加不好
    } failureCallback:^(NSError *err) {
        //        NSAssert(!err, err.description);
    }]addFriendsharingComment:parameters];
}

@end
