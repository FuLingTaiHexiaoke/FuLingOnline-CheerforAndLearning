//
//  FLXKCollapsableTableViewController.m
//  Psy-CommonFramework
//
//  Created by 肖科 on 17/1/6.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "FLXKCollapsableTableViewController.h"
#import "FLXKSectionHeaderView.h"

static NSString* SectionHeaderFooterViewReuseIdentifier=@"SectionHeaderFooterViewReuseIdentifier";

@interface FLXKCollapsableTableViewController ()<FLXKSectionHeaderViewTapDelegate>
@property(nonatomic,assign)BOOL isSingleSectionExpand;
@property(nonatomic,assign)NSUInteger firstExpandedSectionIndex;
@end

@implementation FLXKCollapsableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //是否只展开一个header对应的cells
    self.isSingleSectionExpand=YES;
    self.firstExpandedSectionIndex=0;
    //regitster HeaderFooterView
    //    [self.tableView registerClass:NSClassFromString(@"") forHeaderFooterViewReuseIdentifier:SectionHeaderFooterViewReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"FLXKSectionHeaderView" bundle:[NSBundle bundleForClass:NSClassFromString(@"FLXKSectionHeaderView")]] forHeaderFooterViewReuseIdentifier:SectionHeaderFooterViewReuseIdentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//let subclass to implememt
#pragma mark -  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _models.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return (self.models[section].isVisible.boolValue) ? self.models[section].items.count : 0;
//    
//    if (self.firstExpandedSectionIndex==section) {
//            return _models[section].items.count;
//    }
//    else{
//           return 0;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark -  UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
//    return 44.0f;
//}

// custom view for header. will be adjusted to default or specified header height
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FLXKSectionHeaderView* headerViewInSection=( FLXKSectionHeaderView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:SectionHeaderFooterViewReuseIdentifier];
    headerViewInSection.titleModel=_models[section].titleModel;
    
    headerViewInSection.delegate=self;
    return headerViewInSection;
}

//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//
//}

#pragma mark -  FLXKSectionHeaderViewTapDelegate

-(void)headerView:(FLXKSectionHeaderView*)headview didTapedAtIndex:(NSInteger)tapedSection{
    
    [self collapse:self.tableView withHeaderFooterView:headview inSection:[self self_sectionForHeaderFooterView:headview].integerValue];
}

-(void)rememberExpandedGroupWithIndex:(NSInteger)tapedSection{
    
}

-(void)collapse:(UITableView *)tableView withHeaderFooterView:(FLXKSectionHeaderView *)sectionHeaderView inSection:(NSInteger)section {
    
    NSUInteger tappedSection =section;
    
    [tableView beginUpdates];
    
    BOOL foundOpenUnchosenMenuSection = NO;
    
    for (FLXKCollapsableTableModel* model in _models) {

        BOOL isTappedSection = ([model isEqual:[_models objectAtIndex:tappedSection]]);
        
        if (isTappedSection) {
            
            model.isVisible = @(!model.isVisible.boolValue);
            
            [self toggleCollapseTableViewSectionAtSection:tappedSection
                                                withModel:model
                                              inTableView:tableView
                                        usingRowAnimation:(foundOpenUnchosenMenuSection) ? UITableViewRowAnimationBottom : UITableViewRowAnimationTop
                           forSectionWithHeaderFooterView:sectionHeaderView];
            
        } else if (model.isVisible.boolValue && self.isSingleSectionExpand) {
            
            foundOpenUnchosenMenuSection = YES;
            
           model.isVisible = @(!model.isVisible.boolValue);
            
            NSInteger untappedSection = [_models indexOfObject:model];
            
            [self toggleCollapseTableViewSectionAtSection:untappedSection
                                                withModel:model
                                              inTableView:tableView
                                        usingRowAnimation:(tappedSection > untappedSection) ? UITableViewRowAnimationTop : UITableViewRowAnimationBottom
                           forSectionWithHeaderFooterView:sectionHeaderView];
        }
        
    }
    
    [tableView endUpdates];
    
}


-(void)toggleCollapseTableViewSectionAtSection:(NSUInteger)section
                                     withModel:(FLXKCollapsableTableModel*)model
                                   inTableView:(UITableView *)tableView
                             usingRowAnimation:(UITableViewRowAnimation)animation
                forSectionWithHeaderFooterView:(FLXKSectionHeaderView *)headerFooterView {
    
    NSArray *indexPaths = [self indexPathsForSection:section
                                      forModel:model];
    
    if (model.isVisible.boolValue) {
        [self rememberExpandedGroupWithIndex:section];
//        [headerFooterView openAnimated:YES];
        [tableView insertRowsAtIndexPaths:indexPaths
                         withRowAnimation:animation];
    } else {
         [self rememberExpandedGroupWithIndex:INT_MAX];
//        [headerFooterView closeAnimated:YES];
        [tableView deleteRowsAtIndexPaths:indexPaths
                         withRowAnimation:animation];
    }
}

-(NSArray *)indexPathsForSection:(NSInteger)section forModel:(FLXKCollapsableTableModel*)model {
    
    NSMutableArray *collector = [NSMutableArray new];
    NSInteger count = model.items.count;
    NSIndexPath *indexPath;
    for (NSInteger i = 0; i < count; i++) {
        indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        [collector addObject:indexPath];
    }
    return [collector copy];
}

-(NSNumber *)self_sectionForHeaderFooterView:(UITableViewHeaderFooterView *)view {
    for (NSInteger i = 0; i <_models.count; i++) {
        CGPoint a = [self.tableView convertPoint:CGPointZero fromView:[self.tableView headerViewForSection:i]];
        CGPoint b = [self.tableView convertPoint:CGPointZero fromView:view];
        if (a.y == b.y) {
            return @(i);
        }
    }
    return nil;
}
@end
