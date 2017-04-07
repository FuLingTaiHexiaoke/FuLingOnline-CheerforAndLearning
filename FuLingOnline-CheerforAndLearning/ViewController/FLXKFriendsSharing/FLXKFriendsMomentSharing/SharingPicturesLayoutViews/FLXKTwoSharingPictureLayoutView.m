//
//  FLXKTwoSharingPictureLayoutView.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/7.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//
#pragma mark - Declarations and macros
#define default_width (80+10)
#define default_height (80+10)

#define Reuse_FLXKBaseImageLayoutCollectcionViewCell @"FLXKBaseImageLayoutCollectcionViewCell"

#import "FLXKTwoSharingPictureLayoutView.h"
//utilites
//child viewController
//subviews
//cells
#import "FLXKBaseImageLayoutCollectcionViewCell.h"

//models
//#import "b_group.h"
//#import "b_items.h"
//#import "b_sub_items.h

@interface FLXKTwoSharingPictureLayoutView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
//IBOutlet
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//IBAction
//DataSource
@property (strong, nonatomic) NSMutableArray<FLXKSharingImagesModel*> * collectionViewDataSource;
//models
//UI state record properties
//subviews
//child viewController


@end

@implementation FLXKTwoSharingPictureLayoutView

#pragma mark - ViewController LifeCircle

- (instancetype)init {
    if ([super init]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"FLXKTwoSharingPictureLayoutView" owner:nil options:nil].lastObject;
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}

#pragma mark - Delegate

#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"%lu", (unsigned long)self.collectionViewDataSource.count)
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
            width=default_width-10;
            height=default_height-10;
            break;
    }
    return   CGSizeMake(width, height) ;
}



#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //    b_items* item= self.collectionViewDataSource[indexPath.item];
    //    NSArray<b_sub_items*> *   subItems=[b_sub_items selectByCriteria:[NSString stringWithFormat: @" where item_id= %ld order by id  ",(long)item.id]];
    //    if (subItems.count>0) {
    //        [self performSegueWithIdentifier:@"Segue_PhotoShowingViewController" sender:item];
    //    }
    //    else{
    //
    //    }
}
#pragma mark - Public methods

-(void)setImageArray:(NSArray<FLXKSharingImagesModel *> *)imageArray{
    //get height
    CGFloat height;
    CGFloat width;
    NSInteger count= imageArray.count;
    switch (count) {
        case 1:{
            FLXKSharingImagesModel *  obj = imageArray[0];
            width= obj.thumberImageWidth;
            height= obj.thumberImageHeight;
            break;
        }
        case 2:
        case 3:
            width=default_width*count;
            height=default_height*ceil(count%3);
            break;
        case 4:
            width=default_width*2;
            height=default_height*ceil(count/3);
            break;
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
            width=default_width*3;
            height=default_height*ceil(count/3);
            break;
        default:
            width=default_width;
            height=default_height;
            break;
    }
    
    //set frame
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
    //setup datasource
    self.collectionViewDataSource=[NSMutableArray arrayWithArray:imageArray];
    [self.collectionView reloadData];
}
#pragma mark - View Event
#pragma mark - Model Event
#pragma mark - Private methods

-(void)setupUI{
    [self.collectionView registerNib:[UINib nibWithNibName:Reuse_FLXKBaseImageLayoutCollectcionViewCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:Reuse_FLXKBaseImageLayoutCollectcionViewCell];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor=[UIColor blueColor];
}


#pragma mark - getter/setter
#pragma mark - Overriden methods

#pragma mark - Navigation

// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// [segue destinationViewController].
// }
@end
