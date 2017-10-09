//
//  JKPopMenuItem.h
//  
//
//  Created by Bingjie on 14/12/15.
//  Copyright (c) 2015年 Bingjie. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PopMenuItemWidth            70.0f
#define PopMenuItemHeight           (PopMenuItemWidth + 25)

@interface JKPopMenuItem : UIControl

@property (nonatomic, copy  ) NSString *title;
@property (nonatomic, strong) UIImage  *icon;
@property (nonatomic, strong) UIColor  *textColor;
@property (nonatomic, assign) NSInteger databaseConfigTag;//数据库中配置的tag标签，方便数据库对应查询。因为前期是四个button，全部显示

@property (nonatomic, assign) CGFloat animationTime;

+ (instancetype)item;
+ (instancetype)itemWithTitle:(NSString*)title image:(UIImage*)image;
@end
