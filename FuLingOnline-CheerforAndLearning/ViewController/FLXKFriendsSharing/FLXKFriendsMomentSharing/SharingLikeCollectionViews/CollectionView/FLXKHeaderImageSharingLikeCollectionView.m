//
//  FLXKHeaderImageSharingLikeCollectionView.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/14.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//
#pragma mark - Declarations and macros
#define default_space (5)
#define default_width (80+default_space)
#define default_height (80+default_space)

#define Reuse_FLXKHeaderImageSharingLikeCollectionViewCell @"FLXKHeaderImageSharingLikeCollectionViewCell"


#import "FLXKHeaderImageSharingLikeCollectionView.h"
//utilites
//child viewController
//subviews
//cells
#import "FLXKHeaderImageSharingLikeCollectionViewCell.h"
//models
//#import "b_group.h"
//#import "b_items.h"
//#import "b_sub_items.h

@interface FLXKHeaderImageSharingLikeCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>
//IBOutlet
//IBAction
//DataSource
@property (strong, nonatomic) NSMutableArray<UserModel*> * collectionViewDataSource;
//models
//UI state record properties
//subviews
//child viewController


@end

@implementation FLXKHeaderImageSharingLikeCollectionView

#pragma mark - ViewController LifeCircle

//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    self=  [super initWithCoder:aDecoder];
//    if (self) {
//        [self setupUI];
//    }
//    return self;
//}

- (instancetype)init {
//    if ([super init]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"FLXKHeaderImageSharingLikeCollectionView" owner:nil options:nil].lastObject;
//    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}

#pragma mark - Delegate

#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //    NSLog(@"self.collectionView.frame %@", NSStringFromCGRect( self.collectionView.frame))
    return self.collectionViewDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger itemIndex= indexPath.item;
    UserModel* item= self.collectionViewDataSource[itemIndex];
    FLXKHeaderImageSharingLikeCollectionViewCell*   cell=( FLXKHeaderImageSharingLikeCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:Reuse_FLXKHeaderImageSharingLikeCollectionViewCell forIndexPath:indexPath];
    [cell.userHeaderImageView sd_setImageWithURL:NSURL_BaseURL(item.thumb_avatar_picture) placeholderImage:[UIImage imageNamed:@"Spark"]];
    cell.userInteractionEnabled=YES;
    return cell;
}

#pragma mark -  UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //get height
    CGFloat height=  self.frame.size.height;
    return   CGSizeMake(height, height) ;
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

#pragma mark - View Event
#pragma mark - Model Event
#pragma mark - Private methods

-(void)setupUI{
    [self registerNib:[UINib nibWithNibName:Reuse_FLXKHeaderImageSharingLikeCollectionViewCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:Reuse_FLXKHeaderImageSharingLikeCollectionViewCell];
    self.delegate=self;
    self.dataSource=self;
    self.backgroundColor=[UIColor whiteColor];
    UICollectionViewFlowLayout* collectionViewLayout=  (UICollectionViewFlowLayout*) self.collectionViewLayout;
    collectionViewLayout.minimumLineSpacing=default_space;
    collectionViewLayout.minimumInteritemSpacing=default_space;
}

#pragma mark - getter/setter

-(void)setLikeTheSharingUserRecords:(NSArray<UserModel *> *)users{
    //setup datasource
    self.collectionViewDataSource=[NSMutableArray arrayWithArray:users];
    [self reloadData];
}
#pragma mark - Overriden methods

#pragma mark - Navigation

// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// [segue destinationViewController].
// }
@end
