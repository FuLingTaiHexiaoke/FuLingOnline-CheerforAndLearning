//
//  FaceKeyBoardView.h
//  MyKeyboard
//
//  Created by 张鹏 on 15/12/29.
//  Copyright © 2015年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^FaceKeyboardBlock)(NSInteger tag);

@protocol FaceKeyBoardDelegate;
@protocol FaceKeyBoardDataSource;

@interface FaceKeyBoard : UIView

@property (nonatomic,strong) id<FaceKeyBoardDelegate> faceKeyboadDelegate;
@property (nonatomic,strong) id<FaceKeyBoardDataSource> faceKeyboadDataSource;

@property (nonatomic,strong) FaceKeyboardBlock faceKeyboardBlock;

@end

#pragma mark delegate
@protocol FaceKeyBoardDelegate <NSObject>

@optional
// 点击表情按钮
- (void)faceKeyBoard:(FaceKeyBoard *)faceKeyboard didTapFaceItemsAtIndex:(NSInteger)index;
// 点击删除按钮
- (void)faceKeyBoard:(FaceKeyBoard *)faceKeyboard didTapDeleteButton:(UIButton *)button;

@end

#pragma mark dataSource
@protocol FaceKeyBoardDataSource <NSObject>

@required
// 获取要展示的表情个数
- (NSInteger)numberOfFaceItemsInFaceKeyboard:(FaceKeyBoard *)faceKeyboard;

// 用户获取当前表情的图片
- (UIImage *)faceKeyBoard:(FaceKeyBoard *)faceKeyboard faceImageWithIndex:(NSInteger)index;
@end