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
#import "CLLocationManager+Extensions.h"
#import "FLXKHttpRequestModelHelper.h"
#import "Masonry.h"
#import "NSAttributedString+EmotionExtension.h"
//#import "UINavigationBar+Awesome.h"



@interface FLXKNewsPublishController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate,UIScrollViewDelegate>
//IBOutlet
@property (weak, nonatomic) IBOutlet UIScrollView *publishScrollViewContainer;
@property (weak, nonatomic) IBOutlet UITextView *publishTextView;
@property (weak, nonatomic) IBOutlet UILabel *publishPlaceholderLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *publishImageChoosingCollectionView;
@property (weak, nonatomic) IBOutlet UIView *publishToolBarPositionView;
@property (weak, nonatomic) IBOutlet UIView *publishToolBarView;
@property (weak, nonatomic) IBOutlet UIButton *publishLocationButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *publishLocationLoadingIndicator;
@property (weak, nonatomic) IBOutlet UIButton *clearCurrentLocationButton;

@property (weak, nonatomic) IBOutlet UIButton *publishTopicChooseButton;
@property (weak, nonatomic) IBOutlet UILabel *publishTopicChooseLabel;
@property (weak, nonatomic) IBOutlet UIButton *publishEmotionChooseButton;
@property (weak, nonatomic) IBOutlet UILabel *publishEmotionChooseLabel;
//status change
@property (assign, nonatomic)NSInteger isChangeInputView;


//IBAction
- (IBAction)publishEditedNews:(UIBarButtonItem *)sender;
- (IBAction)getUserCurrentLocation:(UIButton *)sender;
- (IBAction)clearCurrentLocationAction:(id)sender;



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
    
    self.clearCurrentLocationButton.hidden=YES;
    
    //setup data properties
    [self initDataProperty];
    
    //set up collectionview
    [self initCollectionView];
    
    //set up subviews
    [self   initSubViews];
    
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
    
    self.emotionKeyBoard=[FLXKEmotionBoard sharedEmotionBoardWithEditingTextView:self.publishTextView swithButton:self.publishEmotionChooseButton swithButtonContainer:self.publishToolBarView emotionEditingVCView:self.view emotionGroupShowingOption:(EmotionGroup_basic_text_emotion_image|EmotionGroup_emoji_text_emotion_image|EmotionGroup_big_gif_image)];
    
}


-(void)dealloc{
    NSLog(@"%@ 销毁",NSStringFromClass(self.class));
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
    NSString * newsToPublish=[self.publishTextView.attributedText getPlainStringtest];
    
    FLXKPublishNewsModel* model=[[FLXKPublishNewsModel alloc]init];
    model.type_id=001;
    model.type_name=@"个人状态发布";
    model.title=@"个人状态发布";
    model.editor=@"xiaoke";
    model.doc_content=newsToPublish;
    model.doc_url=self.publishLocationButton.titleLabel.text;//user_location
    model.sub_type_id=001;//user_id
    
    [[FLXKHttpRequestModelHelper registerSuccessCallback:^(id obj) {
        //        NSLog(@"success");
    } failureCallback:^(NSError *err) {
        //        NSLog(@"failure");
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
        if (_publishScrollViewContainer==scrollView) {
                [self.view endEditing:YES];
        }
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (_publishScrollViewContainer==scrollView) {
        [self.view endEditing:YES];
    }
}
#pragma mark - Private Methods

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
        [self.publishImageChoosingCollectionView reloadData];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (IBAction)getUserCurrentLocation:(UIButton *)sender {
    [_publishLocationLoadingIndicator startAnimating];
    self.publishLocationButton.enabled=NO;
    @weakify(self)
    [[CLLocationManager sharedLocationManager] getAddressesFromDeviceLocationWithCompleteBlock:^(NSArray<CLPlacemark *> *placemarks, NSError *error, BOOL *stopUpdating) {
        *stopUpdating=YES;
        @strongify(self)
        [_publishLocationLoadingIndicator stopAnimating];
        self.publishLocationButton.enabled=YES;
        self.clearCurrentLocationButton.hidden=NO;
        NSDictionary  *addressDictionary=placemarks[0].addressDictionary;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.publishLocationButton setTitle:[NSString stringWithFormat:@"%@·%@%@        ",addressDictionary[@"City"],addressDictionary[@"SubLocality"],addressDictionary[@"Name"]] forState:UIControlStateNormal];
            [self.publishLocationButton sizeToFit];
        });
    }];
}

- (IBAction)clearCurrentLocationAction:(id)sender {
    self.clearCurrentLocationButton.hidden=YES;
    [self.publishLocationButton setTitle:@"显示位置" forState:UIControlStateNormal];
    [self.publishLocationButton sizeToFit];
    self.publishLocationButton.enabled=YES;
    
}

@end
