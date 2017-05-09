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
#define ThumbupCount @"ThumbupCount"
#define Reuse_FLXKHeaderImageSharingLikeCollectionViewCell @"FLXKHeaderImageSharingLikeCollectionViewCell"

#define Reuse_FLXKLabelTypeSharingLikeCollectionViewCell @"FLXKLabelTypeSharingLikeCollectionViewCell"

#import "FLXKHeaderImageSharingLikeCollectionView.h"
//utilites
//child viewController
//subviews
//cells
#import "FLXKHeaderImageSharingLikeCollectionViewCell.h"
#import "FLXKLabelTypeSharingLikeCollectionViewCell.h"
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
//    NSInteger count= self.collectionViewDataSource.count;
//    return count>0?(count+1):count;
    
      return self.collectionViewDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger itemIndex= indexPath.item;
    if (itemIndex== self.collectionViewDataSource.count-1) {
        FLXKLabelTypeSharingLikeCollectionViewCell*   cell=( FLXKLabelTypeSharingLikeCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:Reuse_FLXKLabelTypeSharingLikeCollectionViewCell forIndexPath:indexPath];
        cell.textLabel.text=[NSString stringWithFormat:@"%lu赞",(unsigned long)self.collectionViewDataSource.count-1];
        return cell;
    }
    UserModel* item= self.collectionViewDataSource[itemIndex];
    FLXKHeaderImageSharingLikeCollectionViewCell*   cell=( FLXKHeaderImageSharingLikeCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:Reuse_FLXKHeaderImageSharingLikeCollectionViewCell forIndexPath:indexPath];
    [cell.userHeaderImageView sd_setImageWithURL:NSURL_BaseURL(item.thumb_avatar_picture) placeholderImage:[UIImage imageNamed:@"Spark"]];
    cell.userHeaderImageView.layer.cornerRadius=self.rowHeight/2;
    cell.userHeaderImageView.layer.masksToBounds=YES;
    cell.userInteractionEnabled=YES;
    return cell;
}

#pragma mark -  UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //get height
    //    CGFloat height=  self.frame.size.height;
    CGFloat height=  self.rowHeight;
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
    
    [self registerNib:[UINib nibWithNibName:Reuse_FLXKLabelTypeSharingLikeCollectionViewCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:Reuse_FLXKLabelTypeSharingLikeCollectionViewCell];
    
    
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
    if (users.count>0) {
        UserModel * user=[[UserModel alloc]init];
//        user.userID=ThumbupCount;
        [self.collectionViewDataSource addObject:user];
    }
    [self reloadData];
}
#pragma mark - Overriden methods

#pragma mark - Navigation

// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// [segue destinationViewController].
// }
@end
