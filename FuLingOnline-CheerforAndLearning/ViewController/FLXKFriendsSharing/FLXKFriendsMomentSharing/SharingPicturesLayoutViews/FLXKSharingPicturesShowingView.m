//
//  FLXKTwoSharingPictureLayoutView.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/7.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//
#pragma mark - Declarations and macros
#define default_space (5)
#define default_width (80+default_space)
#define default_height (80+default_space)

#define Reuse_FLXKBaseImageLayoutCollectcionViewCell @"FLXKBaseImageLayoutCollectcionViewCell"

#import "FLXKSharingPicturesShowingView.h"
//utilites
#import "FriendsMomentSharingConfig.h"
#import "IDMPhotoBrowser.h"

#import "FLXKBaseImageLayoutCollectcionViewCell.h"



@interface FLXKSharingPicturesShowingView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
//IBOutlet
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//DataSource
@property (strong, nonatomic) NSMutableArray<FLXKSharingImagesModel*> * collectionViewDataSource;

@end

@implementation FLXKSharingPicturesShowingView

#pragma mark -  LifeCircle

- (instancetype)init {
    if ([super init]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"FLXKSharingPicturesShowingView" owner:nil options:nil].lastObject;
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}

#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionViewDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger itemIndex= indexPath.item;
    FLXKSharingImagesModel* item= self.collectionViewDataSource[itemIndex];
    FLXKBaseImageLayoutCollectcionViewCell*   cell=( FLXKBaseImageLayoutCollectcionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:Reuse_FLXKBaseImageLayoutCollectcionViewCell forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:NSURL_BaseURL(item.thumbnailPictureUrl) placeholderImage:[UIImage imageNamed:@"Spark"]];
    cell.userInteractionEnabled=YES;
    return cell;
}

#pragma mark -  UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //get height
    CGFloat height;
    CGFloat width;
    NSInteger count=  self.collectionViewDataSource.count;
    switch (count) {
        case 1:{
            FLXKSharingImagesModel *  obj =  self.collectionViewDataSource[0];
            width= obj.thumberImageWidth;
            height= obj.thumberImageHeight;
            break;
        }
        default:
            width=IMAGES_DEFAULT_WIDTH-IMAGES_DEFAULT_SPACE;
            height=IMAGES_DEFAULT_HEIGHT-IMAGES_DEFAULT_SPACE;
            break;
    }
    return   CGSizeMake(width, height) ;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FLXKBaseImageLayoutCollectcionViewCell *cell=(FLXKBaseImageLayoutCollectcionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    NSMutableArray *photos = [NSMutableArray new];
    for (FLXKSharingImagesModel *item in self.collectionViewDataSource) {
        IDMPhoto *photo = [IDMPhoto photoWithURL:NSURL_BaseURL(item.actualPictureUrl)];
        [photos addObject:photo];
    }
    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos animatedFromView:cell];
    [browser setInitialPageIndex:indexPath.item];
    browser.displayCounterLabel=YES;
    browser.displayActionButton=NO;
    browser.displayDoneButton=NO;
    browser.usePopAnimation=NO;
    UIResponder * nextResponder=  self.nextResponder;
    while (![nextResponder.class isSubclassOfClass:NSClassFromString(@"UIViewController")]) {
        nextResponder=nextResponder.nextResponder;
    }
    [(UIViewController*)nextResponder presentViewController:browser animated:YES completion:nil];
}

#pragma mark - SDPhotoBrowserDelegate



#pragma mark - Public methods

-(void)setImageArray:(NSArray<FLXKSharingImagesModel *> *)imageArray{
 //get height
    CGFloat height;
    CGFloat width;
    NSInteger count= imageArray.count;
    switch (count) {
        case 0:{
            width=0;
            height=0;
            break;
        }
        case 1:{
            FLXKSharingImagesModel *  obj = imageArray[0];
            width= obj.thumberImageWidth;
            height= obj.thumberImageHeight;
            break;
        }
        case 2:
        case 3:
            width=default_width*count;
            height=default_height*ceil(count/3.0);
            break;
        case 4:
            width=default_width*2;
            height=default_height*ceil(count/3.0);
            break;
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
            width=default_width*3;
            height=default_height*ceil(count/3.0);
            break;
        default:
            width=default_width;
            height=default_height;
            break;
    }
    if(count>1){
        width-=default_space;
        height-=default_space;
    }
//    self.viewHeight=height;
    //set frame
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left);
    }];
    
    //setup datasource
    self.collectionViewDataSource=[NSMutableArray arrayWithArray:imageArray];
    [self.collectionView reloadData];

}

#pragma mark - Private methods

-(void)setupUI{
    [self.collectionView registerNib:[UINib nibWithNibName:Reuse_FLXKBaseImageLayoutCollectcionViewCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:Reuse_FLXKBaseImageLayoutCollectcionViewCell];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor=[UIColor whiteColor];
  UICollectionViewFlowLayout* collectionViewLayout=  (UICollectionViewFlowLayout*) self.collectionView.collectionViewLayout;
    collectionViewLayout.minimumLineSpacing=IMAGES_DEFAULT_SPACE;
    collectionViewLayout.minimumInteritemSpacing=IMAGES_DEFAULT_SPACE;

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(0);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left);
    }];

}
@end
