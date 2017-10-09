//
//  GameLockSort.m
//  YingYuanGeography
//
//  Created by 肖科 on 2017/8/4.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "GameLockSort.h"
#import "FLXKDBHelper.h"

@implementation GameLockSort

//createTable
+ (BOOL)createTable
{
    __block BOOL res = YES;
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if ([db tableExists:@"gamelocksort"])
        {
            return ;
        }
        NSString *tableName = NSStringFromClass(self.class);
        NSString *columeAndType = @"id TEXT,currentVCName TEXT,currentVCNameDescription TEXT,previousVCName TEXT,previousVCNameDescription TEXT,nextVCName TEXT,nextVCNameDescription TEXT,unlock_sort INTEGER,currentVCTotalScroe REAL,previousVC_minScroe TEXT,previousVC_minScroePercent TEXT,for_expand1 TEXT,for_expand2 TEXT,for_expand3 TEXT,for_expand4 TEXT,for_expand5 TEXT,for_expand6 TEXT";
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
        if ([db tableExists:@"gamelocksort"])
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
+ (NSArray<GameLockSort*> *)selectAll
{
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    NSMutableArray *entitiyResults = [NSMutableArray array];
    [FLXKDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM GameLockSort"];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            GameLockSort *entity = [[GameLockSort alloc] init];
            entity.id=[resultSet stringForColumn:@"id"];
            entity.currentVCName=[resultSet stringForColumn:@"currentVCName"];
            entity.currentVCNameDescription=[resultSet stringForColumn:@"currentVCNameDescription"];
            entity.previousVCName=[resultSet stringForColumn:@"previousVCName"];
            entity.previousVCNameDescription=[resultSet stringForColumn:@"previousVCNameDescription"];
            entity.nextVCName=[resultSet stringForColumn:@"nextVCName"];
            entity.nextVCNameDescription=[resultSet stringForColumn:@"nextVCNameDescription"];
            entity.unlock_sort=[resultSet longLongIntForColumn:@"unlock_sort"];
            entity.currentVCTotalScroe=[resultSet longLongIntForColumn:@"currentVCTotalScroe"];
            entity.previousVC_minScroe=[resultSet stringForColumn:@"previousVC_minScroe"];
            entity.previousVC_minScroePercent=[resultSet stringForColumn:@"previousVC_minScroePercent"];
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
+ (NSArray<GameLockSort*> *)selectByCriteria:(NSString *)criteria
{
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    NSMutableArray *entitiyResults = [NSMutableArray array];
    [FLXKDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM GameLockSort %@",criteria];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            GameLockSort *entity = [[GameLockSort alloc] init];
            entity.id=[resultSet stringForColumn:@"id"];
            entity.currentVCName=[resultSet stringForColumn:@"currentVCName"];
            entity.currentVCNameDescription=[resultSet stringForColumn:@"currentVCNameDescription"];
            entity.previousVCName=[resultSet stringForColumn:@"previousVCName"];
            entity.previousVCNameDescription=[resultSet stringForColumn:@"previousVCNameDescription"];
            entity.nextVCName=[resultSet stringForColumn:@"nextVCName"];
            entity.nextVCNameDescription=[resultSet stringForColumn:@"nextVCNameDescription"];
            entity.unlock_sort=[resultSet longLongIntForColumn:@"unlock_sort"];
            entity.currentVCTotalScroe=[resultSet longLongIntForColumn:@"currentVCTotalScroe"];
            entity.previousVC_minScroe=[resultSet stringForColumn:@"previousVC_minScroe"];
            entity.previousVC_minScroePercent=[resultSet stringForColumn:@"previousVC_minScroePercent"];
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
+ (BOOL)insertWithObject:(GameLockSort*)obj success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@"id,currentVCName,currentVCNameDescription,previousVCName,previousVCNameDescription,nextVCName,nextVCNameDescription,unlock_sort,currentVCTotalScroe,previousVC_minScroe,previousVC_minScroePercent,for_expand1,for_expand2,for_expand3,for_expand4,for_expand5,for_expand6";
    //NSString *valueString =@"?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?";
    //NSString *insertValues =@"obj.id,obj.currentVCName,obj.currentVCNameDescription,obj.previousVCName,obj.previousVCNameDescription,obj.nextVCName,obj.nextVCNameDescription,@(obj.unlock_sort),@(obj.currentVCTotalScroe),obj.previousVC_minScroe,obj.previousVC_minScroePercent,obj.for_expand1,obj.for_expand2,obj.for_expand3,obj.for_expand4,obj.for_expand5,obj.for_expand6";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        @try {
            NSString *sql = @"INSERT OR REPLACE INTO GameLockSort(id,currentVCName,currentVCNameDescription,previousVCName,previousVCNameDescription,nextVCName,nextVCNameDescription,unlock_sort,currentVCTotalScroe,previousVC_minScroe,previousVC_minScroePercent,for_expand1,for_expand2,for_expand3,for_expand4,for_expand5,for_expand6) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            BOOL result = [db executeUpdate:sql,obj.id,obj.currentVCName,obj.currentVCNameDescription,obj.previousVCName,obj.previousVCNameDescription,obj.nextVCName,obj.nextVCNameDescription,@(obj.unlock_sort),@(obj.currentVCTotalScroe),obj.previousVC_minScroe,obj.previousVC_minScroePercent,obj.for_expand1,obj.for_expand2,obj.for_expand3,obj.for_expand4,obj.for_expand5,obj.for_expand6];
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
+ (BOOL)insertWithObjects:(NSArray<GameLockSort*>*)objs success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@"id,currentVCName,currentVCNameDescription,previousVCName,previousVCNameDescription,nextVCName,nextVCNameDescription,unlock_sort,currentVCTotalScroe,previousVC_minScroe,previousVC_minScroePercent,for_expand1,for_expand2,for_expand3,for_expand4,for_expand5,for_expand6";
    //NSString *valueString =@"?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?";
    //NSString *insertValues =@"entity.id,entity.currentVCName,entity.currentVCNameDescription,entity.previousVCName,entity.previousVCNameDescription,entity.nextVCName,entity.nextVCNameDescription,@(entity.unlock_sort),@(entity.currentVCTotalScroe),entity.previousVC_minScroe,entity.previousVC_minScroePercent,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [objs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            GameLockSort* entity = (GameLockSort*)obj;
            
            @try {
                NSString *sql = @"INSERT OR REPLACE INTO GameLockSort(id,currentVCName,currentVCNameDescription,previousVCName,previousVCNameDescription,nextVCName,nextVCNameDescription,unlock_sort,currentVCTotalScroe,previousVC_minScroe,previousVC_minScroePercent,for_expand1,for_expand2,for_expand3,for_expand4,for_expand5,for_expand6) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                BOOL result = [db executeUpdate:sql,entity.id,entity.currentVCName,entity.currentVCNameDescription,entity.previousVCName,entity.previousVCNameDescription,entity.nextVCName,entity.nextVCNameDescription,@(entity.unlock_sort),@(entity.currentVCTotalScroe),entity.previousVC_minScroe,entity.previousVC_minScroePercent,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6];
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
+ (BOOL)updateObject:(GameLockSort*)obj withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@" id= ? , currentVCName= ? , currentVCNameDescription= ? , previousVCName= ? , previousVCNameDescription= ? , nextVCName= ? , nextVCNameDescription= ? , unlock_sort= ? , currentVCTotalScroe= ? , previousVC_minScroe= ? , previousVC_minScroePercent= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? , for_expand4= ? , for_expand5= ? , for_expand6= ? ";
    //NSString *insertValues =@"entity.id,entity.currentVCName,entity.currentVCNameDescription,entity.previousVCName,entity.previousVCNameDescription,entity.nextVCName,entity.nextVCNameDescription,@(entity.unlock_sort),@(entity.currentVCTotalScroe),entity.previousVC_minScroe,entity.previousVC_minScroePercent,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        GameLockSort* entity = (GameLockSort*)obj;
        
        @try {
            NSString *tempSql = [NSString stringWithFormat:@"UPDATE GameLockSort set  id= ? , currentVCName= ? , currentVCNameDescription= ? , previousVCName= ? , previousVCNameDescription= ? , nextVCName= ? , nextVCNameDescription= ? , unlock_sort= ? , currentVCTotalScroe= ? , previousVC_minScroe= ? , previousVC_minScroePercent= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? , for_expand4= ? , for_expand5= ? , for_expand6= ? "];
            NSString *sql = [NSString stringWithFormat:@"%@ %@",tempSql,where];
            BOOL result = [db executeUpdate:sql,entity.id,entity.currentVCName,entity.currentVCNameDescription,entity.previousVCName,entity.previousVCNameDescription,entity.nextVCName,entity.nextVCNameDescription,@(entity.unlock_sort),@(entity.currentVCTotalScroe),entity.previousVC_minScroe,entity.previousVC_minScroePercent,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6];
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
+ (BOOL)updateObjects:(NSArray<GameLockSort*>*)objs withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@" id= ? , currentVCName= ? , currentVCNameDescription= ? , previousVCName= ? , previousVCNameDescription= ? , nextVCName= ? , nextVCNameDescription= ? , unlock_sort= ? , currentVCTotalScroe= ? , previousVC_minScroe= ? , previousVC_minScroePercent= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? , for_expand4= ? , for_expand5= ? , for_expand6= ? ";
    //NSString *insertValues =@"entity.id,entity.currentVCName,entity.currentVCNameDescription,entity.previousVCName,entity.previousVCNameDescription,entity.nextVCName,entity.nextVCNameDescription,@(entity.unlock_sort),@(entity.currentVCTotalScroe),entity.previousVC_minScroe,entity.previousVC_minScroePercent,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [objs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            GameLockSort* entity = (GameLockSort*)obj;
            
            @try {
                NSString *tempSql = [NSString stringWithFormat:@"UPDATE GameLockSort set  id= ? , currentVCName= ? , currentVCNameDescription= ? , previousVCName= ? , previousVCNameDescription= ? , nextVCName= ? , nextVCNameDescription= ? , unlock_sort= ? , currentVCTotalScroe= ? , previousVC_minScroe= ? , previousVC_minScroePercent= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? , for_expand4= ? , for_expand5= ? , for_expand6= ? "];
                NSString *sql = [NSString stringWithFormat:@"%@ %@",tempSql,where];
                BOOL result = [db executeUpdate:sql,entity.id,entity.currentVCName,entity.currentVCNameDescription,entity.previousVCName,entity.previousVCNameDescription,entity.nextVCName,entity.nextVCNameDescription,@(entity.unlock_sort),@(entity.currentVCTotalScroe),entity.previousVC_minScroe,entity.previousVC_minScroePercent,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6];
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
    result = [GameLockSort deleteWithWhereString:@"" success:success failure:failure]; 
    return result;
}


@end
