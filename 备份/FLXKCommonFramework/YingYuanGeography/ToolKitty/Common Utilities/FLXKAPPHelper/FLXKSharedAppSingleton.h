//
//  FLXKSharedAppSingleton.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/13.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"
#import "UserGameLockState.h"

@interface FLXKSharedAppSingleton : NSObject

@property(nonatomic,assign) NSInteger currentMenuButtonTag;//对应二级界面弹出菜单上哪个点击按钮Tag（弹出菜单）
@property(nonatomic,strong) NSString * currentMenuButtonName;//对应二级界面弹出菜单上哪个点击按钮名称（弹出菜单）
@property(nonatomic,assign) NSInteger currentClickedButtonTag;//对应二级界面上哪个点击按钮Tag（非弹出菜单）
@property(nonatomic,strong) NSString * currentClickedButtonName;//对应二级界面上哪个点击按钮名称（非弹出菜单）
@property(nonatomic,strong) NSString * currentLevelTwoVCName;//当前对应二级界面名称
@property(nonatomic,strong) NSString * currentLevelTwoVCDescription;//对应二级界面详细信息
@property(nonatomic,strong) NSString * currentLevelThreeVCName;//三级页面，相应视图名称
@property(nonatomic,strong) NSString * currentLevelThreeVCDescription;//三级页面细信息

@property(nonatomic,strong) User *  user;
@property (strong, nonatomic) NSArray<UserGameLockState*>* userGameLockStates;

+ (instancetype)sharedSingleton;


/**
 记录当前用户
 检查此用户是否登录过。
 为新用户添加用户游戏状态数据
 */
- (void)recordUserId:(NSString *)user_id user_name:(NSString *)user_name user_class:(NSString *)user_class user_sex:(NSString *)user_sex user_type:(NSString *)user_type user_school:(NSString *)user_school;



/**
 数据记录到数据库中
 
 @param score 分数
 @param soreDescription 分数详情
 @param testSortNum 题号
 @param testName 题目名称
 */
- (void)recordUserScore:(NSString *)score soreDescription:(NSString *)soreDescription testSortNum:(NSString *)testSortNum testName:(NSString *)testName;

/**
 @abstract 数据记录到文本文件中
 @param score 分数
 @param soreDescription 分数详情
 @param userAnswer 用户答案
 @param rightAnswer 正确答案
 @param testSortNum 题号
 @param testName 题目名称
 @param testTimeLong 答题时长
 */
- (void)recordDataWithScore:(NSString *)score soreDescription:(NSString *)soreDescription  userAnswer:(NSString *)userAnswer rightAnswer:(NSString *)rightAnswer testSortNum:(NSString *)testSortNum testName:(NSString *)testName testTimeLong:(NSString *)testTimeLong;

/**
 刷新总分数，并保持一条记录到本地文件中
 */
- (void)refreshAndPersistentGameSore;

/**
 获取用户解锁状态
 
 */
- (void)getUserGameLockStates;

/**
 重新计算解锁状态，总分数
 
 */
- (void)caculateUserGameLockStateWithCompleteBlock:(void(^)())completeBlock;

- (void)playErrorSound;
- (void)playRightSound;
- (void)playButtonClickSound;
@end

