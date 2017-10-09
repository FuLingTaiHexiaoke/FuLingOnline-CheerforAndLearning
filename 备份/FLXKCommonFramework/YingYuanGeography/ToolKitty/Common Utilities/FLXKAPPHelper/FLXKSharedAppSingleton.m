//
//  FLXKSharedAppSingleton.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/4/13.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//
#pragma mark - Declarations and macros

#import "FLXKSharedAppSingleton.h"

#import "UserScroeRecord.h"
#import "GameLockSort.h"
#import "FLXKPathHelper.h"
#import "NSDate+Extensions.h"
//#import "AudioServices+Extensions.h"
#import <AVFoundation/AVFoundation.h>

@interface FLXKSharedAppSingleton ()
@property (strong, nonatomic)AVAudioPlayer* musicPlayer;
@end

@implementation FLXKSharedAppSingleton

#pragma mark -  LifeCircle

+(void)load{
    //    [FLXKSharedAppSingleton  getSharedAPPUser];
}


#pragma mark - Delegate
#pragma mark - Public methods

+ (instancetype)sharedSingleton {
    static FLXKSharedAppSingleton *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager =[[FLXKSharedAppSingleton alloc]init];
    });
    
    return _sharedManager;
}

/**
 记录当前用户
 检查此用户是否登录过。
 为新用户添加用户游戏状态数据
 */
- (void)recordUserId:(NSString *)user_id user_name:(NSString *)user_name user_class:(NSString *)user_class user_sex:(NSString *)user_sex user_type:(NSString *)user_type user_school:(NSString *)user_school{
    
    //检查此用户是否登录过。
    NSString* where=[NSString stringWithFormat:@" where user_id='%@' and user_name='%@' and user_class='%@' and user_type='%@' ",user_id,user_name,user_class,user_type];
    NSArray<User*> * models=  [User selectByCriteria:where];
    if (models.count>0 ) {
        self.user=models[0];
    }
    else{
        User * model=[[User alloc]init];
        model.user_id=user_id;
        model.user_id=user_id;
        model.user_name=user_name;
        model.user_class=user_class;
        model.user_sex=user_sex;
        model.user_type=user_type;
        model.user_school=user_school;
        
        self.user=model;
        
        [User insertWithObject:model  success:^{
            //            NSLog(@"UserGameLockState insertWithObject success");
        } failure:^(NSString *errorDescripe) {
            //            NSLog(@"UserGameLockState insertWithObject failure");
        }];
        
        //为新用户添加用户游戏状态数据
        [self createNewUserGameLockState];
    }
    [self getUserGameLockStates];
}

/**
 数据记录到数据库中
 
 @param score 分数
 @param soreDescription 分数详情
 @param testSortNum 题目序号
 @param testName 题目名称
 */
- (void)recordUserScore:(NSString *)score soreDescription:(NSString *)soreDescription testSortNum:(NSString *)testSortNum testName:(NSString *)testName{
    
    NSLog(@"UserScroeRecord score=%@ soreDescription=%@ testSortNum=%@ testName=%@ ",score,soreDescription,testSortNum,testName);
    
    UserScroeRecord * model=[[UserScroeRecord alloc]init];
    
    //用户具体分数 数据记录
    model.currentScroe=score.integerValue;
    model.currentScroeDescription=soreDescription;
    model.for_expand1=testSortNum;//题号（第几题）
    model.for_expand2=testName;//题目名称
    
    
    //user
    model.user_id=self.user.user_id;
    model.user_name=self.user.user_name;
    model.user_class=self.user.user_class;
    model.user_type=self.user.user_type;
    model.user_school=self.user.user_school;
    
    //三级界面相应信息
    model.accordingVCName=self.currentLevelThreeVCName;//三级页面，相应视图名称
    model.testType=self.currentLevelThreeVCDescription;//三级页面，类型
    
    
    //二级界面相应信息
    model.menuButtonTag=self.currentMenuButtonTag;//对应二级界面弹出菜单上哪个点击按钮Tag（弹出菜单）
    model.menuButtonName=self.currentMenuButtonName;//对应二级界面弹出菜单上哪个点击按钮名称（弹出菜单）
    model.accordingButtonTag=self.currentClickedButtonTag;//对应二级界面上哪个点击按钮Tag（非弹出菜单）
    model.accordingButtonName=self.currentClickedButtonName;//对应二级界面上哪个点击按钮名称（非弹出菜单）
    model.VCName=self.currentLevelTwoVCName;//对应二级界面名称
    model.VCNameDescription=self.currentLevelThreeVCDescription;//对应二级界面名称详情
    
    NSString* where=[NSString stringWithFormat:@" where user_id='%@' and user_name='%@' and user_class='%@' and user_type='%@' and for_expand1='%@' and accordingVCName='%@' and menuButtonTag= %ld and  accordingButtonTag= %ld  and VCName= '%@' ",self.user.user_id,self.user.user_name,self.user.user_class,self.user.user_type,testSortNum,self.currentLevelThreeVCName,(long)self.currentMenuButtonTag,(long)self.currentClickedButtonTag,self.currentLevelTwoVCName];
    
    NSArray<UserScroeRecord*> * userScroe=  [UserScroeRecord selectByCriteria:where];
    
    if (userScroe.count>0 ) {
        if (userScroe[0].currentScroe<score.integerValue) {
            [UserScroeRecord updateObject:model withWhereString:where success:^{
                //                NSLog(@"UserScroeRecord updateObject success");
            } failure:^(NSString *errorDescripe) {
                //                NSLog(@"UserScroeRecord updateObject failure");
            }];
        }
    }
    else{
        [UserScroeRecord insertWithObject:model  success:^{
            //            NSLog(@"UserScroeRecord insertWithObject success");
        } failure:^(NSString *errorDescripe) {
            //            NSLog(@"UserScroeRecord insertWithObject failure");
        }];
    }
    
    //数据记录到文本文件中
    //    [self recordDataWithScore:score soreDescription:soreDescription userAnswer:@"空" testSortNum:testSortNum testName:testName testTimeLong:@"空"];
    
}


/**
 获取用户解锁状态
 
 */
- (void)getUserGameLockStates{
    NSString* where=[NSString stringWithFormat:@" where user_id='%@' and user_name='%@' and user_class='%@' and user_type='%@' order by for_expand2 ",self.user.user_id,self.user.user_name,self.user.user_class,self.user.user_type];
    self.userGameLockStates = [UserGameLockState selectByCriteria:where];
}

/**
 为新用户添加用户游戏状态数据
 
 */
- (void)createNewUserGameLockState{
    NSArray<GameLockSort*> * games =  [GameLockSort selectByCriteria:[NSString stringWithFormat:@" order by unlock_sort "]];
    [games enumerateObjectsUsingBlock:^(GameLockSort * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UserGameLockState* userState=[[UserGameLockState alloc]init];
        userState.user_id=self.user.user_id;
        userState.user_name=self.user.user_name;
        userState.user_class=self.user.user_class;
        userState.user_type=self.user.user_type;
        userState.user_school=self.user.user_school;
        userState.currentVCName=obj.currentVCName;
        userState.currentVCNameDescription=obj.currentVCNameDescription;
        userState.currentVCScore=@(0).stringValue;
        userState.currentVCIsUnlocked=idx==0?1:0;
        userState.for_expand2=@(obj.unlock_sort).stringValue;
        userState.for_expand3=@(obj.currentVCTotalScroe).stringValue;
        
        [UserGameLockState insertWithObject:userState  success:^{
            //            NSLog(@"UserGameLockState insertWithObject success");
        } failure:^(NSString *errorDescripe) {
            //            NSLog(@"UserGameLockState insertWithObject failure");
        }];
    }];
}

/**
 刷新总分数，并保持一条记录到本地文件中
 */
- (void)refreshAndPersistentGameSore{
    NSArray<GameLockSort*> * games =  [GameLockSort selectByCriteria:[NSString stringWithFormat:@" where currentVCName = '%@' ",self.currentLevelTwoVCName]];
    
    NSMutableString* where=[NSMutableString stringWithFormat:@" where user_id='%@' and user_name='%@' and user_class='%@' and user_type='%@' and VCName= '%@' ",self.user.user_id,self.user.user_name,self.user.user_class,self.user.user_type,self.currentLevelTwoVCName];
    
    NSInteger currentUserTotalScroe=  [UserScroeRecord selectTotalScoreByCriteria:where];
    CGFloat percent=currentUserTotalScroe/games[0].currentVCTotalScroe;
    NSString* percentString= [NSString stringWithFormat:@"%.2f", percent];
    //记录本地操作数据
    [self recordDataWithScore:percentString soreDescription:@"探索度" userAnswer:@"空" rightAnswer:@"空" testSortNum:@"空" testName:@"探索度" testTimeLong:@"0.0"];
}

/**
 重新计算解锁状态，总分数
 
 */
- (void)caculateUserGameLockStateWithCompleteBlock:(void(^)())completeBlock{
    //按照顺序计算每个游戏当前最新的信息
    //GameLockSort
    
    NSArray<GameLockSort*> * games =  [GameLockSort selectByCriteria:[NSString stringWithFormat:@" order by unlock_sort "]];
    __block GameLockSort* previousGameLockSortObj;
    __block NSInteger previousUserTotalScroe;
    [games enumerateObjectsUsingBlock:^(GameLockSort * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableString* where=[NSMutableString stringWithFormat:@" where user_id='%@' and user_name='%@' and user_class='%@' and user_type='%@' ",self.user.user_id,self.user.user_name,self.user.user_class,self.user.user_type];
        [where appendFormat:@" and VCName= '%@' ",obj.currentVCName];
        
        NSInteger currentUserTotalScroe=  [UserScroeRecord selectTotalScoreByCriteria:where];
        
        //更新用户解锁状态 update or insert into UserGameLockState table
        if (DEBUG) {
            [self _updateUserGameLockStateWithCurrentUserTotalScroe:currentUserTotalScroe previousUserTotalScroe:previousUserTotalScroe currentGameLockSortObj:obj previousGameLockSortObj:previousGameLockSortObj VCName:obj.currentVCName];
        }
        else{
            *stop = ![self _updateUserGameLockStateWithCurrentUserTotalScroe:currentUserTotalScroe previousUserTotalScroe:previousUserTotalScroe currentGameLockSortObj:obj previousGameLockSortObj:previousGameLockSortObj VCName:obj.currentVCName];
        }
        
        previousUserTotalScroe=currentUserTotalScroe;
        previousGameLockSortObj=obj;
    }];
    [self getUserGameLockStates];
    
    if (completeBlock) {
        completeBlock();
    }
}

/**
 更新用户解锁状态
 
 */
- (BOOL)_updateUserGameLockStateWithCurrentUserTotalScroe:(NSInteger)currentUserTotalScroe previousUserTotalScroe:(NSInteger)previousUserTotalScroe currentGameLockSortObj:(GameLockSort* )currentGameLockSortObj  previousGameLockSortObj:(GameLockSort* )previousGameLockSortObj VCName:(NSString*)VCName{
    BOOL currentVCIsUnlocked=NO;
    
    NSString* where=[NSString stringWithFormat:@" where user_id='%@' and user_name='%@' and user_class='%@' and user_type='%@' and currentVCName= '%@' ",self.user.user_id,self.user.user_name,self.user.user_class,self.user.user_type,VCName];
    
    NSArray<UserGameLockState*> * models=  [UserGameLockState selectByCriteria:where];
    
    if (models.count>0 ) {
        
        UserGameLockState* userState=models[0];
        userState.currentVCScore=@(currentUserTotalScroe).stringValue;
        //判断是否解锁
        if(previousGameLockSortObj){
            NSInteger shouldUnlock = previousUserTotalScroe> currentGameLockSortObj.previousVC_minScroe.integerValue?1:0;
            userState.currentVCIsUnlocked=shouldUnlock;
            currentVCIsUnlocked=shouldUnlock;
        }
        else{
            userState.currentVCIsUnlocked=1;
            currentVCIsUnlocked=1;
        }
        
        [UserGameLockState updateObject:userState withWhereString:where success:^{
            //            NSLog(@"UserGameLockState updateObject success");
        } failure:^(NSString *errorDescripe) {
            //            NSLog(@"UserGameLockState updateObject failure");
        }];
    }
    else{
        //        [UserGameLockState insertWithObject:userState  success:^{
        //            NSLog(@"UserGameLockState insertWithObject success");
        //        } failure:^(NSString *errorDescripe) {
        //            NSLog(@"UserGameLockState insertWithObject failure");
        //        }];
    }
    return currentVCIsUnlocked;
}


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
- (void)recordDataWithScore:(NSString *)score soreDescription:(NSString *)soreDescription  userAnswer:(NSString *)userAnswer rightAnswer:(NSString *)rightAnswer testSortNum:(NSString *)testSortNum testName:(NSString *)testName testTimeLong:(NSString *)testTimeLong{
    
    //    auto/项目名/学校/个人信息/个人信息/个人信息/维度一/维度二/题号/答案/时间/分数/随机题号/题目唯一标识/备用/备用
    //维度一
    NSString *firstLevelName =  self.currentLevelTwoVCDescription;
    //维度二
    NSString *secondLevelName = [NSString stringWithFormat:@"%@-%@",self.currentClickedButtonName,[self.currentMenuButtonName componentsSeparatedByString:@"-"][1]];
    
    //登录
    if( [testName isEqualToString:@"登录"]){
        firstLevelName=@"登录";
        secondLevelName=@"登录";
    }
    //总分数记录
    if( [testName isEqualToString:@"探索度"]){
        secondLevelName=@"探索度";
    }
    
    NSString *intoStr = [NSString stringWithFormat:@"auto\t%@\t%@\t%@\t%@\t%@\t%@\t%@\t%@\t%@\t%@\t%@\t%@\t%@\t%@\t%@\n",
                         CleanString(@"迎园地理"),
                         CleanString(ShoolName),//学校
                         CleanString(self.user.user_name),//名字
                         CleanString(self.user.user_class),//班级
                         CleanString(self.user.user_id),//user_id
                         
                         CleanString(firstLevelName),//游戏名称 维度一
                         CleanString(secondLevelName),//环节名称 维度二
                         
                         CleanString(testSortNum),//题号
                         CleanString(userAnswer),//答案
                         //                         CleanString([NSDate DateWithNormalFormat]),//时间戳
                         [NSDate DateWithNormalFormat],//时间戳
                         CleanString(score),//分数
                         CleanString(testTimeLong),//做题时长
                         CleanString(rightAnswer),//正确答案
                         CleanString(self.user.user_sex),//性别
                         CleanString(@"空")//题目唯一标识
                         ];
    NSLog(@"intoStr %@",intoStr);
    [FLXKPathHelper recordData:intoStr fileName:LocalRecordFileName];
}


@end
