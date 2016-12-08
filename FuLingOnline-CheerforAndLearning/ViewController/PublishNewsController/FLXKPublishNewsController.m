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

//subview
#import "FLXKPublishCollectionViewCell.h"

//model
#import "FLXKPublishNewsModel.h"

//utilities
#import "FLXKHttpRequest.h"
#import "MJExtension.h"

@interface FLXKPublishNewsController ()<UICollectionViewDelegate,UICollectionViewDataSource>
//IBOutlet
@property (weak, nonatomic) IBOutlet UITextView *publishTextView;
@property (weak, nonatomic) IBOutlet UILabel *publishPlaceholderLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *publishImageChoosingCollectionView;
@property (weak, nonatomic) IBOutlet UIView *publishToolBarView;
@property (weak, nonatomic) IBOutlet UIButton *publishLocationButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *publishTopicChooseButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *publishEmotionChooseButton;

//IBAction
- (IBAction)publishEditedNews:(UIBarButtonItem *)sender;


//data properties
@property (strong, nonatomic) NSMutableArray* selectedAssets;
@property (strong, nonatomic) NSMutableArray<UIImage*>* selectedPhotos;

@end

@implementation FLXKPublishNewsController

#pragma mark - ViewController LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    //setup data properties
    [self initDataProperty];
    
    //set up collectionview
    [self initCollectionView];
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
    model.id=arc4random();
    model.type_name=@"test";
   NSDictionary *modelDict= model.mj_keyValues;
[FLXKHttpRequest upload:<#(NSString *)#> parameters:modelDict images:_selectedPhotos success:^(NSURLSessionDataTask *task, id responseObject) {
    NSLog(@"success");
} failure:^(NSURLSessionDataTask *task, NSError *error) {
      NSLog(@"failure");
}]
    
}

#pragma mark - Private Methods
-(void)initDataProperty{
    _selectedPhotos=[NSMutableArray arrayWithCapacity:9];
    
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
@end
