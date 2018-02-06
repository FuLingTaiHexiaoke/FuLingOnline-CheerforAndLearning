//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//
#pragma mark - Declarations and macros

#import "___FILEBASENAME___.h"
//utilites
//child viewController
//subviews
//cells
#import "MainCollectionViewCell.h"
#import "HeaderCollectionViewCell.h"
//models
//#import "b_group.h"
//#import "b_items.h"
//#import "b_sub_items.h

@interface ___FILEBASENAMEASIDENTIFIER___ ()
//IBOutlet
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//IBAction
//DataSource
@property (strong, nonatomic) NSMutableArray<b_items*> * collectionViewDataSource;
//models
//UI state record properties
//subviews
//child viewController


@end

@implementation ___FILEBASENAMEASIDENTIFIER___

#pragma mark - ViewController LifeCircle

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do view setup here.
//}
//
//-(void)dealloc{
//    NSLog(@"%@ 销毁",NSStringFromClass(self.class));
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}
//

#pragma mark - Delegate

#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionViewDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger itemIndex= indexPath.item;
//    b_items* item= self.collectionViewDataSource[itemIndex];
//    
//    if ((indexPath.item==0) & [item.for_expand1 isEqualToString:@"1"] ) {
//        HeaderCollectionViewCell*   cell=( HeaderCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell_headerCollectionViewCell" forIndexPath:indexPath];
//        cell.imageView.image=[UIImage imageNamed:item.image_name];
//        cell.titleTextLabel.text=item.title;
//        cell.textlabel.text=item.detail_description;
//        [cell setNeedsLayout];
//        [cell layoutIfNeeded];
//        [self fontSizeToFit: cell.textlabel];
//        cell.userInteractionEnabled=NO;
//        return cell;
//    }
//    else{
//        MainCollectionViewCell*   cell=( MainCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell_MainCollectionViewCell" forIndexPath:indexPath];
//        cell.imageView.image=[UIImage imageNamed:item.image_name];
//        cell.textlabel.text=item.image_name;
//        cell.userInteractionEnabled=YES;
//        return cell;
//    }
}

#pragma mark -  UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger itemIndex= indexPath.item;
//    b_items* item= self.collectionViewDataSource[itemIndex];
//    if ((indexPath.item==0) & [item.for_expand1 isEqualToString:@"1"]) {
//        return   CGSizeMake(self.collectionView.frame.size.width, SCREEN_WIDTH/3) ;
//    }
//    else{
//        CGFloat cellWidth= SCREEN_WIDTH/4;
//        CGFloat cellHeight=(cellWidth*354/368)+(cellWidth*78/362)+10;
//        return   CGSizeMake(cellWidth, cellHeight) ;
//    }
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

- (void)setupCollectionViewDataSourceWithGroupId:(NSInteger)groupID {
//    [self setCurrentGroup: [b_group selectByCriteria:[NSString stringWithFormat: @" where id= %ld ",(long)groupID]][0]];
}

#pragma mark - getter/setter
#pragma mark - Overriden methods

#pragma mark - Navigation

// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// [segue destinationViewController].
// }
@end
