//
//  UIView+Extension_IdentifierForReusable.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/31.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension_IdentifierForReusable)

@end

#define IdentifierForReusableHeaderCode + (NSString *)identifierForReusable;\
- (NSString *)identifierForReusable;

@interface UITableViewCell (IdentifierForReusable)

IdentifierForReusableHeaderCode

@end

@interface UICollectionReusableView (IdentifierForReusable)

IdentifierForReusableHeaderCode

@end

@interface UITableViewHeaderFooterView (IdentifierForReusable)

IdentifierForReusableHeaderCode

@end


// Helpful

@interface UITableView (IdentifierForReusable)

/**
 使用类名注册 Cell
 */
- (void)registerCellClass:(Class)cellClass;
/**
 使用类名注册 Header Footer
 */
- (void)registerHeaderFooterClass:(Class)aClass;

- (__kindof UITableViewCell *)dequeueReusableCellWithClass:(Class)cellClass;

- (__kindof UITableViewCell *)dequeueReusableCellWithClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath;

- (__kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewWithClass:(Class)aClass;

@end


@interface UICollectionView (IdentifierForReusable)
/**
 使用类名注册 Cell
 */
- (void)registerClass:(Class)cellClass;
/**
 使用类名注册 Header Footer
 */
- (void)registerClass:(Class)aClass forSupplementaryViewOfKind:(NSString *)kind;

/**
 获取 cell
 
 @param cellClass cell 的 class
 */
- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath;

/**
 获取 UICollectionReusableView
 */
- (__kindof UICollectionReusableView *)dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind withReuseClass:(Class)aClass forIndexPath:(NSIndexPath *)indexPath;
@end
