//
//  FLXKPublishNewsController.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/12/5.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "EditPersonInfoViewController.h"

//used view controllers
#import "TZImagePickerController.h"
#import "FLXKEmotionBoard.h"

//subview
#import "FLXKNewsPublishCollectionViewCell.h"

////model
//#import "FLXKPublishNewsModel.h"
#import "FLXKModelsBrigde.h"

//utilities
//#import "FLXKHttpRequest.h"
//#import "MJExtension.h"
#import "CLLocationManager+Extensions.h"
#import "FLXKHttpRequestModelHelper.h"
#import "Masonry.h"
#import "NSAttributedString+EmotionExtension.h"
//#import "UINavigationBar+Awesome.h"



@interface EditPersonInfoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate,UIScrollViewDelegate>
//IBOutlet
@property (weak, nonatomic) IBOutlet UIScrollView *publishScrollViewContainer;
@property (weak, nonatomic) IBOutlet UITextView *publishTextView;
@property (weak, nonatomic) IBOutlet UILabel *publishPlaceholderLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *publishImageChoosingCollectionView;
//status change
//@property (assign, nonatomic)NSInteger isChangeInputView;
@property (weak, nonatomic) IBOutlet UITextField *loginNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *websiteTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;



//IBAction
- (IBAction)publishEditedNews:(UIButton *)sender;
- (IBAction)getUserCurrentLocation:(UIButton *)sender;
- (IBAction)clearCurrentLocationAction:(id)sender;



//data properties
@property (strong, nonatomic) NSMutableArray* selectedAssets;
@property (strong, nonatomic) NSMutableArray<UIImage*>* selectedPhotos;

//subviews
@property (strong, nonatomic) UIView* emotionKeyBoard;
@end

@implementation EditPersonInfoViewController

#pragma mark - ViewController LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.clearCurrentLocationButton.hidden=YES;
    
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
    
    
    UserModel* model=[[UserModel alloc]init];
    //    model.userID=001;
    model.login_name=self.loginNameTextField.text;
    model.password=self.passwordTextField.text;
    model.name=self.nameTextField.text;
    model.phone_number=self.phoneNumberTextField.text;
    model.gender=self.genderTextField.text;
    model.birthday=self.birthdayTextField.text;
    model.self_detail=self.publishTextView.text;
    model.email=self.emailTextField.text;
    model.location=self.locationTextField.text;
    model.website=self.websiteTextField.text;
    
    [[FLXKHttpRequestModelHelper registerSuccessCallback:^(id obj) {
        //        NSLog(@"success");
    } failureCallback:^(NSError *err) {
        //        NSLog(@"failure");
    }] addUserModel:model pictures:_selectedPhotos];
    
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

@end
