////
////  TestEntity.m
////  Psy-TeachersTerminal
////
////  Created by apple on 2016/6/27.
////  Copyright © 2016年 apple. All rights reserved.
////
//
#import "EmotionGroup.h"
#import "FLXKEmotionDBHelper.h"
//
@implementation EmotionGroup

//createTable
+ (BOOL)createTable
{
    __block BOOL res = YES;
    FLXKEmotionDBHelper *FLXKDB = [FLXKEmotionDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if ([db tableExists:@"emotiongroup"])
        {
            return ;
        }
        NSString *tableName = NSStringFromClass(self.class);
        NSString *columeAndType = @"id INTEGER,emotionGroupName TEXT,emotionGroupImageUrl TEXT";
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
    FLXKEmotionDBHelper *FLXKDB = [FLXKEmotionDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if ([db tableExists:@"emotiongroup"])
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
+ (NSArray<EmotionGroup*> *)selectAll
{
    FLXKEmotionDBHelper *FLXKDB = [FLXKEmotionDBHelper shareInstance];
    NSMutableArray *entitiyResults = [NSMutableArray array];
    [FLXKDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM EmotionGroup"];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            EmotionGroup *entity = [[EmotionGroup alloc] init];
            entity.id=[resultSet longLongIntForColumn:@"id"];
            entity.emotionGroupName=[resultSet stringForColumn:@"emotionGroupName"];
            entity.emotionGroupImageUrl=[resultSet stringForColumn:@"emotionGroupImageUrl"];
            [entitiyResults addObject:entity];
            FMDBRelease(entity);
        }
    }];
    return entitiyResults;
};
//selectByCriteria
+ (NSArray<EmotionGroup*> *)selectByCriteria:(NSString *)criteria
{
    FLXKEmotionDBHelper *FLXKDB = [FLXKEmotionDBHelper shareInstance];
    NSMutableArray *entitiyResults = [NSMutableArray array];
    [FLXKDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM EmotionGroup %@",criteria];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            EmotionGroup *entity = [[EmotionGroup alloc] init];
            entity.id=[resultSet longLongIntForColumn:@"id"];
            entity.emotionGroupName=[resultSet stringForColumn:@"emotionGroupName"];
            entity.emotionGroupImageUrl=[resultSet stringForColumn:@"emotionGroupImageUrl"];
            [entitiyResults addObject:entity];
            FMDBRelease(entity);
        }
    }];
    return entitiyResults;
};
//insertWithObject:
+ (BOOL)insertWithObject:(EmotionGroup*)obj success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@"id,emotionGroupName,emotionGroupImageUrl";
    //NSString *valueString =@"?,?,?";
    //NSString *insertValues =@"@(obj.id),obj.emotionGroupName,obj.emotionGroupImageUrl";
    
    
    
    FLXKEmotionDBHelper *FLXKDB = [FLXKEmotionDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        @try {
            NSString *sql = @"INSERT OR REPLACE INTO EmotionGroup(id,emotionGroupName,emotionGroupImageUrl) VALUES (?,?,?)";
            BOOL result = [db executeUpdate:sql,@(obj.id),obj.emotionGroupName,obj.emotionGroupImageUrl];
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
+ (BOOL)insertWithObjects:(NSArray<EmotionGroup*>*)objs success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@"id,emotionGroupName,emotionGroupImageUrl";
    //NSString *valueString =@"?,?,?";
    //NSString *insertValues =@"@(entity.id),entity.emotionGroupName,entity.emotionGroupImageUrl";
    
    
    
    FLXKEmotionDBHelper *FLXKDB = [FLXKEmotionDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [objs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            EmotionGroup* entity = (EmotionGroup*)obj;
            
            @try {
                NSString *sql = @"INSERT OR REPLACE INTO EmotionGroup(id,emotionGroupName,emotionGroupImageUrl) VALUES (?,?,?)";
                BOOL result = [db executeUpdate:sql,@(entity.id),entity.emotionGroupName,entity.emotionGroupImageUrl];
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
+ (BOOL)updateObject:(EmotionGroup*)obj withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@" id= ? , emotionGroupName= ? , emotionGroupImageUrl= ? ";
    //NSString *insertValues =@"@(entity.id),entity.emotionGroupName,entity.emotionGroupImageUrl";
    
    
    
    FLXKEmotionDBHelper *FLXKDB = [FLXKEmotionDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        EmotionGroup* entity = (EmotionGroup*)obj;
        
        @try {
            NSString *tempSql = [NSString stringWithFormat:@"UPDATE EmotionGroup set  id= ? , emotionGroupName= ? , emotionGroupImageUrl= ? "];
            NSString *sql = [NSString stringWithFormat:@"%@ %@",tempSql,where];
            BOOL result = [db executeUpdate:sql,@(entity.id),entity.emotionGroupName,entity.emotionGroupImageUrl];
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
+ (BOOL)updateObjects:(NSArray<EmotionGroup*>*)objs withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@" id= ? , emotionGroupName= ? , emotionGroupImageUrl= ? ";
    //NSString *insertValues =@"@(entity.id),entity.emotionGroupName,entity.emotionGroupImageUrl";
    
    
    
    FLXKEmotionDBHelper *FLXKDB = [FLXKEmotionDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [objs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            EmotionGroup* entity = (EmotionGroup*)obj;
            
            @try {
                NSString *tempSql = [NSString stringWithFormat:@"UPDATE EmotionGroup set  id= ? , emotionGroupName= ? , emotionGroupImageUrl= ? "];
                NSString *sql = [NSString stringWithFormat:@"%@ %@",tempSql,where];
                BOOL result = [db executeUpdate:sql,@(entity.id),entity.emotionGroupName,entity.emotionGroupImageUrl];
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
    FLXKEmotionDBHelper *FLXKDB = [FLXKEmotionDBHelper shareInstance];
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
    result = [EmotionGroup deleteWithWhereString:@"" success:success failure:failure]; 
    return result;
}


@end