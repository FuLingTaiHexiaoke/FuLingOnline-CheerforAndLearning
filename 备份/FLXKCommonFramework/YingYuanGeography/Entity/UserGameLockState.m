//
//  GameLockSort.m
//  YingYuanGeography
//
//  Created by 肖科 on 2017/8/4.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "UserGameLockState.h"
#import "FLXKDBHelper.h"

@implementation UserGameLockState

//createTable
+ (BOOL)createTable
{
    __block BOOL res = YES;
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if ([db tableExists:@"usergamelockstate"])
        {
            return ;
        }
        NSString *tableName = NSStringFromClass(self.class);
        NSString *columeAndType = @"user_id TEXT,user_name TEXT,user_class TEXT,user_type TEXT,user_school TEXT,currentVCName TEXT,currentVCNameDescription TEXT,currentVCIsUnlocked INTEGER,currentVCScore TEXT,for_expand2 TEXT,for_expand3 TEXT,for_expand4 TEXT,for_expand5 TEXT,for_expand6 TEXT";
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
        if ([db tableExists:@"usergamelockstate"])
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
+ (NSArray<UserGameLockState*> *)selectAll
{
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    NSMutableArray *entitiyResults = [NSMutableArray array];
    [FLXKDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM UserGameLockState"];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            UserGameLockState *entity = [[UserGameLockState alloc] init];
            entity.user_id=[resultSet stringForColumn:@"user_id"];
            entity.user_name=[resultSet stringForColumn:@"user_name"];
            entity.user_class=[resultSet stringForColumn:@"user_class"];
            entity.user_type=[resultSet stringForColumn:@"user_type"];
            entity.user_school=[resultSet stringForColumn:@"user_school"];
            entity.currentVCName=[resultSet stringForColumn:@"currentVCName"];
            entity.currentVCNameDescription=[resultSet stringForColumn:@"currentVCNameDescription"];
            entity.currentVCIsUnlocked=[resultSet longLongIntForColumn:@"currentVCIsUnlocked"];
            entity.currentVCScore=[resultSet stringForColumn:@"currentVCScore"];
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
+ (NSArray<UserGameLockState*> *)selectByCriteria:(NSString *)criteria
{
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    NSMutableArray *entitiyResults = [NSMutableArray array];
    [FLXKDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM UserGameLockState %@",criteria];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            UserGameLockState *entity = [[UserGameLockState alloc] init];
            entity.user_id=[resultSet stringForColumn:@"user_id"];
            entity.user_name=[resultSet stringForColumn:@"user_name"];
            entity.user_class=[resultSet stringForColumn:@"user_class"];
            entity.user_type=[resultSet stringForColumn:@"user_type"];
            entity.user_school=[resultSet stringForColumn:@"user_school"];
            entity.currentVCName=[resultSet stringForColumn:@"currentVCName"];
            entity.currentVCNameDescription=[resultSet stringForColumn:@"currentVCNameDescription"];
            entity.currentVCIsUnlocked=[resultSet longLongIntForColumn:@"currentVCIsUnlocked"];
            entity.currentVCScore=[resultSet stringForColumn:@"currentVCScore"];
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
+ (BOOL)insertWithObject:(UserGameLockState*)obj success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@"user_id,user_name,user_class,user_type,user_school,currentVCName,currentVCNameDescription,currentVCIsUnlocked,currentVCScore,for_expand2,for_expand3,for_expand4,for_expand5,for_expand6";
    //NSString *valueString =@"?,?,?,?,?,?,?,?,?,?,?,?,?,?";
    //NSString *insertValues =@"obj.user_id,obj.user_name,obj.user_class,obj.user_type,obj.user_school,obj.currentVCName,obj.currentVCNameDescription,@(obj.currentVCIsUnlocked),obj.currentVCScore,obj.for_expand2,obj.for_expand3,obj.for_expand4,obj.for_expand5,obj.for_expand6";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        @try {
            NSString *sql = @"INSERT OR REPLACE INTO UserGameLockState(user_id,user_name,user_class,user_type,user_school,currentVCName,currentVCNameDescription,currentVCIsUnlocked,currentVCScore,for_expand2,for_expand3,for_expand4,for_expand5,for_expand6) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            BOOL result = [db executeUpdate:sql,obj.user_id,obj.user_name,obj.user_class,obj.user_type,obj.user_school,obj.currentVCName,obj.currentVCNameDescription,@(obj.currentVCIsUnlocked),obj.currentVCScore,obj.for_expand2,obj.for_expand3,obj.for_expand4,obj.for_expand5,obj.for_expand6];
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
+ (BOOL)insertWithObjects:(NSArray<UserGameLockState*>*)objs success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@"user_id,user_name,user_class,user_type,user_school,currentVCName,currentVCNameDescription,currentVCIsUnlocked,currentVCScore,for_expand2,for_expand3,for_expand4,for_expand5,for_expand6";
    //NSString *valueString =@"?,?,?,?,?,?,?,?,?,?,?,?,?,?";
    //NSString *insertValues =@"entity.user_id,entity.user_name,entity.user_class,entity.user_type,entity.user_school,entity.currentVCName,entity.currentVCNameDescription,@(entity.currentVCIsUnlocked),entity.currentVCScore,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [objs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UserGameLockState* entity = (UserGameLockState*)obj;
            
            @try {
                NSString *sql = @"INSERT OR REPLACE INTO UserGameLockState(user_id,user_name,user_class,user_type,user_school,currentVCName,currentVCNameDescription,currentVCIsUnlocked,currentVCScore,for_expand2,for_expand3,for_expand4,for_expand5,for_expand6) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                BOOL result = [db executeUpdate:sql,entity.user_id,entity.user_name,entity.user_class,entity.user_type,entity.user_school,entity.currentVCName,entity.currentVCNameDescription,@(entity.currentVCIsUnlocked),entity.currentVCScore,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6];
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
+ (BOOL)updateObject:(UserGameLockState*)obj withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@" user_id= ? , user_name= ? , user_class= ? , user_type= ? , user_school= ? , currentVCName= ? , currentVCNameDescription= ? , currentVCIsUnlocked= ? , currentVCScore= ? , for_expand2= ? , for_expand3= ? , for_expand4= ? , for_expand5= ? , for_expand6= ? ";
    //NSString *insertValues =@"entity.user_id,entity.user_name,entity.user_class,entity.user_type,entity.user_school,entity.currentVCName,entity.currentVCNameDescription,@(entity.currentVCIsUnlocked),entity.currentVCScore,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        UserGameLockState* entity = (UserGameLockState*)obj;
        
        @try {
            NSString *tempSql = [NSString stringWithFormat:@"UPDATE UserGameLockState set  user_id= ? , user_name= ? , user_class= ? , user_type= ? , user_school= ? , currentVCName= ? , currentVCNameDescription= ? , currentVCIsUnlocked= ? , currentVCScore= ? , for_expand2= ? , for_expand3= ? , for_expand4= ? , for_expand5= ? , for_expand6= ? "];
            NSString *sql = [NSString stringWithFormat:@"%@ %@",tempSql,where];
            BOOL result = [db executeUpdate:sql,entity.user_id,entity.user_name,entity.user_class,entity.user_type,entity.user_school,entity.currentVCName,entity.currentVCNameDescription,@(entity.currentVCIsUnlocked),entity.currentVCScore,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6];
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
+ (BOOL)updateObjects:(NSArray<UserGameLockState*>*)objs withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@" user_id= ? , user_name= ? , user_class= ? , user_type= ? , user_school= ? , currentVCName= ? , currentVCNameDescription= ? , currentVCIsUnlocked= ? , currentVCScore= ? , for_expand2= ? , for_expand3= ? , for_expand4= ? , for_expand5= ? , for_expand6= ? ";
    //NSString *insertValues =@"entity.user_id,entity.user_name,entity.user_class,entity.user_type,entity.user_school,entity.currentVCName,entity.currentVCNameDescription,@(entity.currentVCIsUnlocked),entity.currentVCScore,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [objs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UserGameLockState* entity = (UserGameLockState*)obj;
            
            @try {
                NSString *tempSql = [NSString stringWithFormat:@"UPDATE UserGameLockState set  user_id= ? , user_name= ? , user_class= ? , user_type= ? , user_school= ? , currentVCName= ? , currentVCNameDescription= ? , currentVCIsUnlocked= ? , currentVCScore= ? , for_expand2= ? , for_expand3= ? , for_expand4= ? , for_expand5= ? , for_expand6= ? "];
                NSString *sql = [NSString stringWithFormat:@"%@ %@",tempSql,where];
                BOOL result = [db executeUpdate:sql,entity.user_id,entity.user_name,entity.user_class,entity.user_type,entity.user_school,entity.currentVCName,entity.currentVCNameDescription,@(entity.currentVCIsUnlocked),entity.currentVCScore,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6];
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
    result = [UserGameLockState deleteWithWhereString:@"" success:success failure:failure]; 
    return result;
}



@end
