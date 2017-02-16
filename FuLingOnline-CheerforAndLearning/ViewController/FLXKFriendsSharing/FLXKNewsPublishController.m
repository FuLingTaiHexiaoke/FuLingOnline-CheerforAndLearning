//
//  FLXKPublishNewsController.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/12/5.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "FLXKNewsPublishController.h"

//used view controllers
#import "TZImagePickerController.h"
#import "FLXKEmotionBoard.h"

//subview
#import "FLXKNewsPublishCollectionViewCell.h"

////model
//#import "FLXKPublishNewsModel.h"

//utilities
//#import "FLXKHttpRequest.h"
//#import "MJExtension.h"
#import "FLXKHttpRequestModelHelper.h"
#import "Masonry.h"
#import "NSAttributedString+EmotionExtension.h"



@interface FLXKNewsPublishController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate,UIScrollViewDelegate>
//IBOutlet
@property (weak, nonatomic) IBOutlet UIScrollView *publishScrollViewContainer;
@property (weak, nonatomic) IBOutlet UITextView *publishTextView;
@property (weak, nonatomic) IBOutlet UILabel *publishPlaceholderLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *publishImageChoosingCollectionView;
@property (weak, nonatomic) IBOutlet UIView *publishToolBarPositionView;
@property (weak, nonatomic) IBOutlet UIView *publishToolBarView;
@property (weak, nonatomic) IBOutlet UIButton *publishLocationButton;
@property (weak, nonatomic) IBOutlet UIButton *publishTopicChooseButton;
@property (weak, nonatomic) IBOutlet UILabel *publishTopicChooseLabel;
@property (weak, nonatomic) IBOutlet UIButton *publishEmotionChooseButton;
@property (weak, nonatomic) IBOutlet UILabel *publishEmotionChooseLabel;
//status change
@property (assign, nonatomic)NSInteger isChangeInputView;

//IBAction
- (IBAction)publishEditedNews:(UIBarButtonItem *)sender;
- (IBAction)showEmotionView:(UIBarButtonItem *)sender;


//data properties
@property (strong, nonatomic) NSMutableArray* selectedAssets;
@property (strong, nonatomic) NSMutableArray<UIImage*>* selectedPhotos;

//subviews
@property (strong, nonatomic) UIView* emotionKeyBoard;
@end

@implementation FLXKNewsPublishController

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

//    self.emotionKeyBoard=[FLXKEmotionBoard sharedEmotionBoardWithReload:YES editingTextView:self.publishTextView swithButton:self.publishLocationButton swithButtonContainer:self.publishToolBarView emotionEditingVCView:self.view emotionGroupShowingOption:(EmotionGroup_basic_text_emotion_image|EmotionGroup_emoji_text_emotion_image|EmotionGroup_big_gif_image)];

//    //添加键盘弹出-隐藏通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
////        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame1:) name:UIKeyboardWillShowNotification object:nil];
////        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame2:) name:UIKeyboardWillHideNotification object:nil];
//    
    if (UserDefaultsObjForKey( @"plainString")) {
        self.publishTextView.attributedText=[NSAttributedString attributedStringWithPlainString:UserDefaultsObjForKey( @"plainString")];
        [self resetTextStyle];
    }
}

- (void)resetTextStyle {
    
    //After changing text selection, should reset style.
    NSRange wholeRange = NSMakeRange(0, self.publishTextView.textStorage.length);
    
    [self.publishTextView.textStorage removeAttribute:NSFontAttributeName range:wholeRange];
    
    [self.publishTextView.textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:wholeRange];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.emotionKeyBoard=[FLXKEmotionBoard sharedEmotionBoardWithEditingTextView:self.publishTextView swithButton:self.publishEmotionChooseButton swithButtonContainer:self.publishToolBarView emotionEditingVCView:self.view emotionGroupShowingOption:(EmotionGroup_basic_text_emotion_image|EmotionGroup_emoji_text_emotion_image|EmotionGroup_big_gif_image|EmotionGroup_recent_text_emotion_image)];
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
    FLXKNewsPublishCollectionViewCell * cell= (FLXKNewsPublishCollectionViewCell *) [_publishImageChoosingCollectionView dequeueReusableCellWithReuseIdentifier:@"Cell_PublishImageChoosingCollectionView" forIndexPath:indexPath];
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

//    [FLXKEmotionBoard getPlainTextString];
     [self.publishTextView.attributedText getPlainStringtest];
//    FLXKPublishNewsModel* model=[[FLXKPublishNewsModel alloc]init];
//    model.type_id=001;
//    model.type_name=@"个人状态发布";
//    model.doc_content=_publishTextView.text;
//    model.editor=@"psylife";
//
//    [[FLXKHttpRequestModelHelper registerSuccessCallback:^(id obj) {
//        NSLog(@"success");
//    } failureCallback:^(NSError *err) {
//        NSLog(@"failure");
//    }] publishEditedNewsWithModel:model pictures:_selectedPhotos];

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
//    if (_publishScrollViewContainer==scrollView) {
//            [self.view endEditing:YES];
//    }
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (_publishScrollViewContainer==scrollView) {
        [self.view endEditing:YES];
    }
}
#pragma mark - Private Methods
//- (IBAction)showEmotionView:(UIBarButtonItem *)sender{
//    static BOOL isShowingEmotionBoard=NO;
//    if (!self.emotionKeyBoard) {
////        self.emotionKeyBoard=   [[FLXKEmotionBoard alloc]initWithFrame:CGRectMake(0, self.view.height-210, self.view.width, 210) editingTextView:self.publishTextView containerView:self.publishToolBarView];
////        self.emotionKeyBoard=   [FLXKEmotionBoard sharedEmotionBoard];
//        self.emotionKeyBoard=   [FLXKEmotionBoard sharedEmotionBoardWithEditingTextView:self.publishTextView swithButtonContainer:self.publishToolBarView swithButton:nil];
////                [self.view addSubview: self.emotionKeyBoard];
//        
//////        self.emotionKeyBoard=   [FLXKEmotionBoardTest sharedEmotionBoard];
////        [self.view addSubview: self.emotionKeyBoard];
//
//    }
//        _isChangeInputView=YES;
//        [self.publishTextView resignFirstResponder];
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.09f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.publishTextView.inputView=self.publishTextView.inputView?nil:self.emotionKeyBoard;
//            _isChangeInputView=NO;
//            [self.publishTextView becomeFirstResponder];
//        });
//}

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
//    [self.publishToolBarView removeConstraints: self.publishToolBarView.constraints];
//    [self.view updateConstraints];

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
    if ([NSStringFromCGRect(keyboardBeginFrame) isEqualToString:NSStringFromCGRect(keyboardEndFrame) ]) {
        return;
    }

    if (_isChangeInputView) {
             return;
    }

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

-(void)keyboardWillChangeFrame1:(NSNotification*)notif{

        NSLog(@"keyboardWillChangeFrame1");
}
-(void)keyboardWillChangeFrame2:(NSNotification*)notif{

    NSLog(@"keyboardWillChangeFrame2");
}
@end
