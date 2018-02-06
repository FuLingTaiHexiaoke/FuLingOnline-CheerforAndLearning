//
//  ThirdLevelCommonImages.m
//  YingYuanGeography
//
//  Created by 肖科 on 2017/8/2.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "ThirdLevelLearningTestVC.h"
#import "FLXKDBHelper.h"
@implementation ThirdLevelLearningTestVC

//createTable
+ (BOOL)createTable
{
    __block BOOL res = YES;
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if ([db tableExists:@"thirdlevellearningtestvc"])
        {
            return ;
        }
        NSString *tableName = NSStringFromClass(self.class);
        NSString *columeAndType = @"id TEXT,txtFileName TEXT,accordingVCName TEXT,testType TEXT,ImageSelectWord TEXT,ImageSelectPicture TEXT,orderTag INTEGER,menuButtonTag INTEGER,menuButtonName TEXT,accordingButtonTag INTEGER,accordingButtonName TEXT,VCName TEXT,VCNameDescription TEXT,for_expand1 TEXT,for_expand2 TEXT,for_expand3 TEXT,for_expand4 TEXT,for_expand5 TEXT,for_expand6 TEXT";
        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@);",tableName,columeAndType];
        if (![db executeUpdate:sql]) {
            res = NO;
            *rollback = YES;
        };
    }];
    return res;
};
//dropTable
+ (BOOL)dropTable
{
    __block BOOL res = YES;
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if ([db tableExists:@"thirdlevellearningtestvc"])
        {
            NSString *tableName = NSStringFromClass(self.class);
            NSString *sql = [NSString stringWithFormat:@"DROP TABLE IF  EXISTS %@;",tableName];
            if (![db executeUpdate:sql]) {
                res = NO;
                *rollback = YES;
            };
        }
    }];
    return res;
};
//selectAll
+ (NSArray<ThirdLevelLearningTestVC*> *)selectAll
{
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    NSMutableArray *entitiyResults = [NSMutableArray array];
    [FLXKDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ThirdLevelLearningTestVC"];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            ThirdLevelLearningTestVC *entity = [[ThirdLevelLearningTestVC alloc] init];
            entity.id=[resultSet stringForColumn:@"id"];
            entity.txtFileName=[resultSet stringForColumn:@"txtFileName"];
            entity.accordingVCName=[resultSet stringForColumn:@"accordingVCName"];
            entity.testType=[resultSet stringForColumn:@"testType"];
            entity.ImageSelectWord=[resultSet stringForColumn:@"ImageSelectWord"];
            entity.ImageSelectPicture=[resultSet stringForColumn:@"ImageSelectPicture"];
            entity.orderTag=[resultSet longLongIntForColumn:@"orderTag"];
            entity.menuButtonTag=[resultSet longLongIntForColumn:@"menuButtonTag"];
            entity.menuButtonName=[resultSet stringForColumn:@"menuButtonName"];
            entity.accordingButtonTag=[resultSet longLongIntForColumn:@"accordingButtonTag"];
            entity.accordingButtonName=[resultSet stringForColumn:@"accordingButtonName"];
            entity.VCName=[resultSet stringForColumn:@"VCName"];
            entity.VCNameDescription=[resultSet stringForColumn:@"VCNameDescription"];
            entity.for_expand1=[resultSet stringForColumn:@"for_expand1"];
            entity.for_expand2=[resultSet stringForColumn:@"for_expand2"];
            entity.for_expand3=[resultSet stringForColumn:@"for_expand3"];
            entity.for_expand4=[resultSet stringForColumn:@"for_expand4"];
            entity.for_expand5=[resultSet stringForColumn:@"for_expand5"];
            entity.for_expand6=[resultSet stringForColumn:@"for_expand6"];
            [entitiyResults addObject:entity];
            FMDBRelease(entity);
        }
    }];
    return entitiyResults;
};
//selectByCriteria
+ (NSArray<ThirdLevelLearningTestVC*> *)selectByCriteria:(NSString *)criteria
{
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    NSMutableArray *entitiyResults = [NSMutableArray array];
    [FLXKDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ThirdLevelLearningTestVC %@",criteria];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            ThirdLevelLearningTestVC *entity = [[ThirdLevelLearningTestVC alloc] init];
            entity.id=[resultSet stringForColumn:@"id"];
            entity.txtFileName=[resultSet stringForColumn:@"txtFileName"];
            entity.accordingVCName=[resultSet stringForColumn:@"accordingVCName"];
            entity.testType=[resultSet stringForColumn:@"testType"];
            entity.ImageSelectWord=[resultSet stringForColumn:@"ImageSelectWord"];
            entity.ImageSelectPicture=[resultSet stringForColumn:@"ImageSelectPicture"];
            entity.orderTag=[resultSet longLongIntForColumn:@"orderTag"];
            entity.menuButtonTag=[resultSet longLongIntForColumn:@"menuButtonTag"];
            entity.menuButtonName=[resultSet stringForColumn:@"menuButtonName"];
            entity.accordingButtonTag=[resultSet longLongIntForColumn:@"accordingButtonTag"];
            entity.accordingButtonName=[resultSet stringForColumn:@"accordingButtonName"];
            entity.VCName=[resultSet stringForColumn:@"VCName"];
            entity.VCNameDescription=[resultSet stringForColumn:@"VCNameDescription"];
            entity.for_expand1=[resultSet stringForColumn:@"for_expand1"];
            entity.for_expand2=[resultSet stringForColumn:@"for_expand2"];
            entity.for_expand3=[resultSet stringForColumn:@"for_expand3"];
            entity.for_expand4=[resultSet stringForColumn:@"for_expand4"];
            entity.for_expand5=[resultSet stringForColumn:@"for_expand5"];
            entity.for_expand6=[resultSet stringForColumn:@"for_expand6"];
            [entitiyResults addObject:entity];
            FMDBRelease(entity);
        }
    }];
    return entitiyResults;
};
//insertWithObject:
+ (BOOL)insertWithObject:(ThirdLevelLearningTestVC*)obj success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@"id,txtFileName,accordingVCName,testType,ImageSelectWord,ImageSelectPicture,orderTag,menuButtonTag,menuButtonName,accordingButtonTag,accordingButtonName,VCName,VCNameDescription,for_expand1,for_expand2,for_expand3,for_expand4,for_expand5,for_expand6";
    //NSString *valueString =@"?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?";
    //NSString *insertValues =@"obj.id,obj.txtFileName,obj.accordingVCName,obj.testType,obj.ImageSelectWord,obj.ImageSelectPicture,@(obj.orderTag),@(obj.menuButtonTag),obj.menuButtonName,@(obj.accordingButtonTag),obj.accordingButtonName,obj.VCName,obj.VCNameDescription,obj.for_expand1,obj.for_expand2,obj.for_expand3,obj.for_expand4,obj.for_expand5,obj.for_expand6";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        @try {
            NSString *sql = @"INSERT OR REPLACE INTO ThirdLevelLearningTestVC(id,txtFileName,accordingVCName,testType,ImageSelectWord,ImageSelectPicture,orderTag,menuButtonTag,menuButtonName,accordingButtonTag,accordingButtonName,VCName,VCNameDescription,for_expand1,for_expand2,for_expand3,for_expand4,for_expand5,for_expand6) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            BOOL result = [db executeUpdate:sql,obj.id,obj.txtFileName,obj.accordingVCName,obj.testType,obj.ImageSelectWord,obj.ImageSelectPicture,@(obj.orderTag),@(obj.menuButtonTag),obj.menuButtonName,@(obj.accordingButtonTag),obj.accordingButtonName,obj.VCName,obj.VCNameDescription,obj.for_expand1,obj.for_expand2,obj.for_expand3,obj.for_expand4,obj.for_expand5,obj.for_expand6];
            if (!result)
            {
                *rollback = YES;
                isRollBack = YES;
            }
        }
        @catch (NSException *exception) {
            if(failure)
            {
                failure(@"插入数据失败");
            }
        }
        @finally {
            if (isRollBack)
            {
                NSLog(@"insert to database failure content");
                if(failure)
                {
                    failure(@"插入数据失败");
                }
                result= NO;
            }
            else
            {
                result= YES;
                if(success)
                {
                    success();
                }
            }
        }
    }];
    return result;
}
//insertWithObject:
+ (BOOL)insertWithObjects:(NSArray<ThirdLevelLearningTestVC*>*)objs success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@"id,txtFileName,accordingVCName,testType,ImageSelectWord,ImageSelectPicture,orderTag,menuButtonTag,menuButtonName,accordingButtonTag,accordingButtonName,VCName,VCNameDescription,for_expand1,for_expand2,for_expand3,for_expand4,for_expand5,for_expand6";
    //NSString *valueString =@"?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?";
    //NSString *insertValues =@"entity.id,entity.txtFileName,entity.accordingVCName,entity.testType,entity.ImageSelectWord,entity.ImageSelectPicture,@(entity.orderTag),@(entity.menuButtonTag),entity.menuButtonName,@(entity.accordingButtonTag),entity.accordingButtonName,entity.VCName,entity.VCNameDescription,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [objs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ThirdLevelLearningTestVC* entity = (ThirdLevelLearningTestVC*)obj;
            
            @try {
                NSString *sql = @"INSERT OR REPLACE INTO ThirdLevelLearningTestVC(id,txtFileName,accordingVCName,testType,ImageSelectWord,ImageSelectPicture,orderTag,menuButtonTag,menuButtonName,accordingButtonTag,accordingButtonName,VCName,VCNameDescription,for_expand1,for_expand2,for_expand3,for_expand4,for_expand5,for_expand6) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                BOOL result = [db executeUpdate:sql,entity.id,entity.txtFileName,entity.accordingVCName,entity.testType,entity.ImageSelectWord,entity.ImageSelectPicture,@(entity.orderTag),@(entity.menuButtonTag),entity.menuButtonName,@(entity.accordingButtonTag),entity.accordingButtonName,entity.VCName,entity.VCNameDescription,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6];
                if (!result)
                {
                    *rollback = YES;
                    isRollBack = YES;
                }
            }
            @catch (NSException *exception) {
                if(failure)
                {
                    failure(@"插入数据失败");
                }
            }
            @finally {
                if (isRollBack)
                {
                    NSLog(@"insert to database failure content");
                    if(failure)
                    {
                        failure(@"插入数据失败");
                    }
                    result= NO;
                }
                else
                {
                    result= YES;
                    if(success)
                    {
                        success();
                    }
                }
            }
        }];
    }];
    return result;
}
//insertWithObject:
+ (BOOL)updateObject:(ThirdLevelLearningTestVC*)obj withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@" id= ? , txtFileName= ? , accordingVCName= ? , testType= ? , ImageSelectWord= ? , ImageSelectPicture= ? , orderTag= ? , menuButtonTag= ? , menuButtonName= ? , accordingButtonTag= ? , accordingButtonName= ? , VCName= ? , VCNameDescription= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? , for_expand4= ? , for_expand5= ? , for_expand6= ? ";
    //NSString *insertValues =@"entity.id,entity.txtFileName,entity.accordingVCName,entity.testType,entity.ImageSelectWord,entity.ImageSelectPicture,@(entity.orderTag),@(entity.menuButtonTag),entity.menuButtonName,@(entity.accordingButtonTag),entity.accordingButtonName,entity.VCName,entity.VCNameDescription,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        ThirdLevelLearningTestVC* entity = (ThirdLevelLearningTestVC*)obj;
        
        @try {
            NSString *tempSql = [NSString stringWithFormat:@"UPDATE ThirdLevelLearningTestVC set  id= ? , txtFileName= ? , accordingVCName= ? , testType= ? , ImageSelectWord= ? , ImageSelectPicture= ? , orderTag= ? , menuButtonTag= ? , menuButtonName= ? , accordingButtonTag= ? , accordingButtonName= ? , VCName= ? , VCNameDescription= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? , for_expand4= ? , for_expand5= ? , for_expand6= ? "];
            NSString *sql = [NSString stringWithFormat:@"%@ %@",tempSql,where];
            BOOL result = [db executeUpdate:sql,entity.id,entity.txtFileName,entity.accordingVCName,entity.testType,entity.ImageSelectWord,entity.ImageSelectPicture,@(entity.orderTag),@(entity.menuButtonTag),entity.menuButtonName,@(entity.accordingButtonTag),entity.accordingButtonName,entity.VCName,entity.VCNameDescription,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6];
            if (!result)
            {
                *rollback = YES;
                isRollBack = YES;
            }
        }
        @catch (NSException *exception) {
            if(failure)
            {
                failure(@"插入数据失败");
            }
        }
        @finally {
            if (isRollBack)
            {
                NSLog(@"insert to database failure content");
                if(failure)
                {
                    failure(@"插入数据失败");
                }
                result= NO;
            }
            else
            {
                result= YES;
                if(success)
                {
                    success();
                }
            }
        }
    }];
    return result;
}
//insertWithObject:
+ (BOOL)updateObjects:(NSArray<ThirdLevelLearningTestVC*>*)objs withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@" id= ? , txtFileName= ? , accordingVCName= ? , testType= ? , ImageSelectWord= ? , ImageSelectPicture= ? , orderTag= ? , menuButtonTag= ? , menuButtonName= ? , accordingButtonTag= ? , accordingButtonName= ? , VCName= ? , VCNameDescription= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? , for_expand4= ? , for_expand5= ? , for_expand6= ? ";
    //NSString *insertValues =@"entity.id,entity.txtFileName,entity.accordingVCName,entity.testType,entity.ImageSelectWord,entity.ImageSelectPicture,@(entity.orderTag),@(entity.menuButtonTag),entity.menuButtonName,@(entity.accordingButtonTag),entity.accordingButtonName,entity.VCName,entity.VCNameDescription,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [objs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ThirdLevelLearningTestVC* entity = (ThirdLevelLearningTestVC*)obj;
            
            @try {
                NSString *tempSql = [NSString stringWithFormat:@"UPDATE ThirdLevelLearningTestVC set  id= ? , txtFileName= ? , accordingVCName= ? , testType= ? , ImageSelectWord= ? , ImageSelectPicture= ? , orderTag= ? , menuButtonTag= ? , menuButtonName= ? , accordingButtonTag= ? , accordingButtonName= ? , VCName= ? , VCNameDescription= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? , for_expand4= ? , for_expand5= ? , for_expand6= ? "];
                NSString *sql = [NSString stringWithFormat:@"%@ %@",tempSql,where];
                BOOL result = [db executeUpdate:sql,entity.id,entity.txtFileName,entity.accordingVCName,entity.testType,entity.ImageSelectWord,entity.ImageSelectPicture,@(entity.orderTag),@(entity.menuButtonTag),entity.menuButtonName,@(entity.accordingButtonTag),entity.accordingButtonName,entity.VCName,entity.VCNameDescription,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6];
                if (!result)
                {
                    *rollback = YES;
                    isRollBack = YES;
                }
            }
            @catch (NSException *exception) {
                if(failure)
                {
                    failure(@"插入数据失败");
                }
            }
            @finally {
                if (isRollBack)
                {
                    NSLog(@"insert to database failure content");
                    if(failure)
                    {
                        failure(@"插入数据失败");
                    }
                    result= NO;
                }
                else
                {
                    result= YES;
                    if(success)
                    {
                        success();
                    }
                }
            }
        }];
    }];
    return result;
}
//insertWithObject:
+ (BOOL)deleteWithWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure 
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        
        @try {
            NSString *tableName = NSStringFromClass(self.class);
            NSString *sql = [NSString stringWithFormat:@"DELETE FROM  %@   %@  ",tableName,where];
            BOOL result = [db executeUpdate:sql];
            if (!result)
            {
                isRollBack = YES;
            }
        }
        @catch (NSException *exception) {
            if(failure)
            {
                failure(@"插入数据失败");
            }
        }
        @finally {
            if (isRollBack)
            {
                NSLog(@"insert to database failure content");
                if(failure)
                {
                    failure(@"插入数据失败");
                }
                result= NO;
            }
            else
            {
                result= YES;
                if(success)
                {
                    success();
                }
            }
        }
    }];
    return result;
}
//insertWithObject:
+ (BOOL)clearTableSuccess:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure 
{
    BOOL result = NO;
    result = [ThirdLevelLearningTestVC deleteWithWhereString:@"" success:success failure:failure]; 
    return result;
}


@end
