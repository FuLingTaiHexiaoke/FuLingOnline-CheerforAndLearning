//
//  FLXKPublishNewsController.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/12/5.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "FLXKPublishNewsController.h"

//used view controllers
#import "TZImagePickerController.h"
#import "PsyInputView_Simple.h"
#import "FLXKEmotionBoard.h"

//subview
#import "FLXKPublishCollectionViewCell.h"

////model
//#import "FLXKPublishNewsModel.h"

//utilities
//#import "FLXKHttpRequest.h"
//#import "MJExtension.h"
#import "FLXKHttpRequestModelHelper.h"
#import "Masonry.h"



@interface FLXKPublishNewsController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate,UIScrollViewDelegate,PsyInputView_SimpleDelegate>
//IBOutlet
@property (weak, nonatomic) IBOutlet UIScrollView *publishScrollViewContainer;
@property (weak, nonatomic) IBOutlet UITextView *publishTextView;
@property (weak, nonatomic) IBOutlet UILabel *publishPlaceholderLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *publishImageChoosingCollectionView;
@property (weak, nonatomic) IBOutlet UIView *publishToolBarPositionView;
@property (weak, nonatomic) IBOutlet UIView *publishToolBarView;
@property (weak, nonatomic) IBOutlet UIButton *publishLocationButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *publishTopicChooseButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *publishEmotionChooseButton;


//IBAction
- (IBAction)publishEditedNews:(UIBarButtonItem *)sender;
- (IBAction)showEmotionView:(UIBarButtonItem *)sender;


//data properties
@property (strong, nonatomic) NSMutableArray* selectedAssets;
@property (strong, nonatomic) NSMutableArray<UIImage*>* selectedPhotos;

//subviews
@property (strong, nonatomic) UIView* emotionKeyBoard;
@end

@implementation FLXKPublishNewsController

#pragma mark - ViewController LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    //setup data properties
    [self initDataProperty];

    //set up collectionview
    [self initCollectionView];

    //set up subviews
    [self   initSubViews];

    [self.publishToolBarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.publishToolBarPositionView);
        make.bottom.equalTo(self.view.mas_bottom);
    }];


    //添加键盘弹出-隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewDidLayoutSubviews{

}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public Methods




#pragma mark - Delegates


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count= _selectedPhotos.count;
    //    return count<9?count+1:count;
    return count+1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FLXKPublishCollectionViewCell * cell= (FLXKPublishCollectionViewCell *) [_publishImageChoosingCollectionView dequeueReusableCellWithReuseIdentifier:@"Cell_PublishImageChoosingCollectionView" forIndexPath:indexPath];
    NSInteger count= _selectedPhotos.count;

    //add selected images
    if (indexPath.item<count) {
        cell.choosedImageDisplayImageView.image=_selectedPhotos[indexPath.item];
        //show delete button
        cell.deleteChoosedImageButton.hidden=NO;
        [cell.deleteChoosedImageButton addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
        cell.deleteChoosedImageButton.tag=indexPath.item;
        [cell.choosedImageDisplayButton removeTarget:self action:@selector(chooseSharingPhotos) forControlEvents:UIControlEventTouchUpInside];
    }

    //add last
    if (indexPath.row==count) {
        cell.choosedImageDisplayImageView.image=[UIImage imageNamed:@"btn_album_add"];
        cell.deleteChoosedImageButton.hidden=YES;
        [cell.choosedImageDisplayButton addTarget:self action:@selector(chooseSharingPhotos) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate

//set up collectionview
- (IBAction)publishEditedNews:(UIBarButtonItem *)sender {

    FLXKPublishNewsModel* model=[[FLXKPublishNewsModel alloc]init];
    model.type_id=001;
    model.type_name=@"个人状态发布";
    model.doc_content=_publishTextView.text;
    model.editor=@"psylife";

    [[FLXKHttpRequestModelHelper registerSuccessCallback:^(id obj) {
        NSLog(@"success");
    } failureCallback:^(NSError *err) {
        NSLog(@"failure");
    }] publishEditedNewsWithModel:model pictures:_selectedPhotos];

}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    _publishPlaceholderLabel.hidden=YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    _publishPlaceholderLabel.hidden=textView.text.length>0;
}
- (void)textViewDidChangeSelection:(UITextView *)textView{
    _publishPlaceholderLabel.hidden=textView.text.length>0;
}

#pragma mark -UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - Private Methods
- (IBAction)showEmotionView:(UIBarButtonItem *)sender{
    static BOOL isShowingEmotionBoard=NO;
    if (!self.emotionKeyBoard) {
        self.emotionKeyBoard=   [[FLXKEmotionBoard alloc]initWithFrame:CGRectMake(0, self.view.height-210, self.view.width, 210) editingTextView:self.publishTextView containerView:self.publishToolBarView];
//        [self.view addSubview: self.emotionKeyBoard];

    }
    else{
        if (!isShowingEmotionBoard) {
//                        [self.publishTextView resignFirstResponder];
            self.publishTextView.inputView=self.emotionKeyBoard;
            [self.publishTextView reloadInputViews];
//                        [self.publishTextView becomeFirstResponder];
        }
        else{
//                  [self.publishTextView resignFirstResponder];
//            [self.emotionKeyBoard removeFromSuperview];
            self.publishTextView.inputView=nil;
              [self.publishTextView reloadInputViews];
//              [self.publishTextView becomeFirstResponder];
        }

        isShowingEmotionBoard=!isShowingEmotionBoard;
//        //已经上移
//        if (self.emotionKeyBoard.top>self.publishToolBarView.top) {
//            [self.publishToolBarView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(78);
//                make.left.and.right.mas_equalTo(self.view);
//                make.bottom.equalTo(self.view.mas_bottom).offset(self.emotionKeyBoard.height);
//            }];
//            self.publishTextView.inputView=self.emotionKeyBoard;
//            [self.publishTextView becomeFirstResponder];
//
//        }
//        //还在底部
//        else{
//            [self.publishToolBarView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(78);
//                make.left.and.right.mas_equalTo(self.view);
//                make.bottom.equalTo(self.view.mas_bottom);
//            }];
//        }
//        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            [self.view layoutIfNeeded];
//        } completion:^(BOOL finished) {
//
//        }];



    }




    //    else{
    //        [self.publishTextView resignFirstResponder];
    //        //        [self.emotionKeyBoard removeFromSuperview];
    //        [UIView animateWithDuration:0.5 animations:^{
    //            self.publishToolBarView.frame=CGRectMake(0, 490,320, 78);
    //        }];
    //    }
    //    i=!i;
}

-(void)initDataProperty{
    _selectedPhotos=[NSMutableArray arrayWithCapacity:9];
}
-(void)initSubViews{
    _publishScrollViewContainer.delegate=self;
    _publishTextView.delegate=self;
}

-(void)initCollectionView{
    UICollectionViewFlowLayout* flowLayout=[[UICollectionViewFlowLayout alloc]init];
    CGFloat   itemWidth= (self.view.width-16-20)/3;
    flowLayout.itemSize=CGSizeMake(itemWidth, itemWidth);
    flowLayout.minimumInteritemSpacing=5;
    flowLayout.minimumLineSpacing=5;
    //    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
    _publishImageChoosingCollectionView.collectionViewLayout=flowLayout;

    _publishImageChoosingCollectionView.delegate=self;
    _publishImageChoosingCollectionView.dataSource=self;
}

- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];

    [_publishImageChoosingCollectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_publishImageChoosingCollectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_publishImageChoosingCollectionView reloadData];
    }];
}

-(void)chooseSharingPhotos{
    TZImagePickerController* imagePickerVc=[[TZImagePickerController alloc]initWithMaxImagesCount:9 delegate:nil];
    imagePickerVc.selectedAssets=_selectedAssets;
    imagePickerVc.sortAscendingByModificationDate=NO;

    @weakify(self)
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray * assets, BOOL isSelectOriginalPhoto) {
        @strongify(self)
        _selectedAssets=[NSMutableArray arrayWithArray:assets];
        _selectedPhotos=[NSMutableArray arrayWithArray:photos];
        //        [photos enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //            [self.publishCollectionViewImageArray addObject:obj];
        //        }];
        [self.publishImageChoosingCollectionView reloadData];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)keyboardWillChangeFrame:(NSNotification*)notif{

//    NSLog(@"keyboardChange:%@",[notif userInfo]);
    float keyboadHeightBegin = 0;
    float keyboadHeightEnd = 0;

    float animationDuration = [[[notif userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationCurve animationCurve = [[[notif userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];

    CGRect keyboardBeginFrame = [[[notif userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect keyboardEndFrame = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboadHeightBegin =[UIApplication sharedApplication].keyWindow.height - keyboardBeginFrame.origin.y;
    keyboadHeightEnd = [UIApplication sharedApplication].keyWindow.height - keyboardEndFrame.origin.y;

    NSLog(@"11111self.publishToolBarView.frame:%@,keyboadHeightBegin To:%.2f",NSStringFromCGRect(self.publishToolBarView.frame),keyboadHeightBegin);

    if (keyboadHeightBegin>0) {
        [self.publishToolBarView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(78);
            make.left.and.right.mas_equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }
    else{
        [self.publishToolBarView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(78);
            make.left.and.right.mas_equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom).offset(-keyboadHeightEnd);
        }];
    }
    [UIView animateWithDuration:animationDuration delay:0.0 options:animationCurve<<16 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
    
    NSLog(@"22222self.publishToolBarView.frame:%@,keyboadHeightBegin To:%.2f",NSStringFromCGRect(self.publishToolBarView.frame),keyboadHeightEnd);
    
}

@end
