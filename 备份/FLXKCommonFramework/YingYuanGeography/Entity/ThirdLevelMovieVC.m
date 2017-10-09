//
//  ThirdLevelCommonImages.m
//  YingYuanGeography
//
//  Created by 肖科 on 2017/8/2.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "ThirdLevelMovieVC.h"
#import "FLXKDBHelper.h"
@implementation ThirdLevelMovieVC

//createTable
+ (BOOL)createTable
{
    __block BOOL res = YES;
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if ([db tableExists:@"thirdlevelmovievc"])
        {
            return ;
        }
        NSString *tableName = NSStringFromClass(self.class);
        NSString *columeAndType = @"id TEXT,title TEXT,coverName TEXT,MovieName TEXT,detail_description TEXT,orderTag INTEGER,accordingButtonTag INTEGER,accordingButtonName TEXT,VCName TEXT,VCNameDescription TEXT,for_expand1 TEXT,for_expand2 TEXT,for_expand3 TEXT";
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
        if ([db tableExists:@"thirdlevelmovievc"])
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
+ (NSArray<ThirdLevelMovieVC*> *)selectAll
{
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    NSMutableArray *entitiyResults = [NSMutableArray array];
    [FLXKDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ThirdLevelMovieVC"];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            ThirdLevelMovieVC *entity = [[ThirdLevelMovieVC alloc] init];
            entity.id=[resultSet stringForColumn:@"id"];
            entity.title=[resultSet stringForColumn:@"title"];
            entity.coverName=[resultSet stringForColumn:@"coverName"];
            entity.MovieName=[resultSet stringForColumn:@"MovieName"];
            entity.detail_description=[resultSet stringForColumn:@"detail_description"];
            entity.orderTag=[resultSet longLongIntForColumn:@"orderTag"];
            entity.accordingButtonTag=[resultSet longLongIntForColumn:@"accordingButtonTag"];
            entity.accordingButtonName=[resultSet stringForColumn:@"accordingButtonName"];
            entity.VCName=[resultSet stringForColumn:@"VCName"];
            entity.VCNameDescription=[resultSet stringForColumn:@"VCNameDescription"];
            entity.for_expand1=[resultSet stringForColumn:@"for_expand1"];
            entity.for_expand2=[resultSet stringForColumn:@"for_expand2"];
            entity.for_expand3=[resultSet stringForColumn:@"for_expand3"];
            [entitiyResults addObject:entity];
            FMDBRelease(entity);
        }
    }];
    return entitiyResults;
};
//selectByCriteria
+ (NSArray<ThirdLevelMovieVC*> *)selectByCriteria:(NSString *)criteria
{
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    NSMutableArray *entitiyResults = [NSMutableArray array];
    [FLXKDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ThirdLevelMovieVC %@",criteria];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            ThirdLevelMovieVC *entity = [[ThirdLevelMovieVC alloc] init];
            entity.id=[resultSet stringForColumn:@"id"];
            entity.title=[resultSet stringForColumn:@"title"];
            entity.coverName=[resultSet stringForColumn:@"coverName"];
            entity.MovieName=[resultSet stringForColumn:@"MovieName"];
            entity.detail_description=[resultSet stringForColumn:@"detail_description"];
            entity.orderTag=[resultSet longLongIntForColumn:@"orderTag"];
            entity.accordingButtonTag=[resultSet longLongIntForColumn:@"accordingButtonTag"];
            entity.accordingButtonName=[resultSet stringForColumn:@"accordingButtonName"];
            entity.VCName=[resultSet stringForColumn:@"VCName"];
            entity.VCNameDescription=[resultSet stringForColumn:@"VCNameDescription"];
            entity.for_expand1=[resultSet stringForColumn:@"for_expand1"];
            entity.for_expand2=[resultSet stringForColumn:@"for_expand2"];
            entity.for_expand3=[resultSet stringForColumn:@"for_expand3"];
            [entitiyResults addObject:entity];
            FMDBRelease(entity);
        }
    }];
    return entitiyResults;
};
//insertWithObject:
+ (BOOL)insertWithObject:(ThirdLevelMovieVC*)obj success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@"id,title,coverName,MovieName,detail_description,orderTag,accordingButtonTag,accordingButtonName,VCName,VCNameDescription,for_expand1,for_expand2,for_expand3";
    //NSString *valueString =@"?,?,?,?,?,?,?,?,?,?,?,?,?";
    //NSString *insertValues =@"obj.id,obj.title,obj.coverName,obj.MovieName,obj.detail_description,@(obj.orderTag),@(obj.accordingButtonTag),obj.accordingButtonName,obj.VCName,obj.VCNameDescription,obj.for_expand1,obj.for_expand2,obj.for_expand3";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        @try {
            NSString *sql = @"INSERT OR REPLACE INTO ThirdLevelMovieVC(id,title,coverName,MovieName,detail_description,orderTag,accordingButtonTag,accordingButtonName,VCName,VCNameDescription,for_expand1,for_expand2,for_expand3) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
            BOOL result = [db executeUpdate:sql,obj.id,obj.title,obj.coverName,obj.MovieName,obj.detail_description,@(obj.orderTag),@(obj.accordingButtonTag),obj.accordingButtonName,obj.VCName,obj.VCNameDescription,obj.for_expand1,obj.for_expand2,obj.for_expand3];
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
+ (BOOL)insertWithObjects:(NSArray<ThirdLevelMovieVC*>*)objs success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@"id,title,coverName,MovieName,detail_description,orderTag,accordingButtonTag,accordingButtonName,VCName,VCNameDescription,for_expand1,for_expand2,for_expand3";
    //NSString *valueString =@"?,?,?,?,?,?,?,?,?,?,?,?,?";
    //NSString *insertValues =@"entity.id,entity.title,entity.coverName,entity.MovieName,entity.detail_description,@(entity.orderTag),@(entity.accordingButtonTag),entity.accordingButtonName,entity.VCName,entity.VCNameDescription,entity.for_expand1,entity.for_expand2,entity.for_expand3";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [objs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ThirdLevelMovieVC* entity = (ThirdLevelMovieVC*)obj;
            
            @try {
                NSString *sql = @"INSERT OR REPLACE INTO ThirdLevelMovieVC(id,title,coverName,MovieName,detail_description,orderTag,accordingButtonTag,accordingButtonName,VCName,VCNameDescription,for_expand1,for_expand2,for_expand3) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
                BOOL result = [db executeUpdate:sql,entity.id,entity.title,entity.coverName,entity.MovieName,entity.detail_description,@(entity.orderTag),@(entity.accordingButtonTag),entity.accordingButtonName,entity.VCName,entity.VCNameDescription,entity.for_expand1,entity.for_expand2,entity.for_expand3];
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
+ (BOOL)updateObject:(ThirdLevelMovieVC*)obj withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@" id= ? , title= ? , coverName= ? , MovieName= ? , detail_description= ? , orderTag= ? , accordingButtonTag= ? , accordingButtonName= ? , VCName= ? , VCNameDescription= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? ";
    //NSString *insertValues =@"entity.id,entity.title,entity.coverName,entity.MovieName,entity.detail_description,@(entity.orderTag),@(entity.accordingButtonTag),entity.accordingButtonName,entity.VCName,entity.VCNameDescription,entity.for_expand1,entity.for_expand2,entity.for_expand3";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        ThirdLevelMovieVC* entity = (ThirdLevelMovieVC*)obj;
        
        @try {
            NSString *tempSql = [NSString stringWithFormat:@"UPDATE ThirdLevelMovieVC set  id= ? , title= ? , coverName= ? , MovieName= ? , detail_description= ? , orderTag= ? , accordingButtonTag= ? , accordingButtonName= ? , VCName= ? , VCNameDescription= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? "];
            NSString *sql = [NSString stringWithFormat:@"%@ %@",tempSql,where];
            BOOL result = [db executeUpdate:sql,entity.id,entity.title,entity.coverName,entity.MovieName,entity.detail_description,@(entity.orderTag),@(entity.accordingButtonTag),entity.accordingButtonName,entity.VCName,entity.VCNameDescription,entity.for_expand1,entity.for_expand2,entity.for_expand3];
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
+ (BOOL)updateObjects:(NSArray<ThirdLevelMovieVC*>*)objs withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@" id= ? , title= ? , coverName= ? , MovieName= ? , detail_description= ? , orderTag= ? , accordingButtonTag= ? , accordingButtonName= ? , VCName= ? , VCNameDescription= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? ";
    //NSString *insertValues =@"entity.id,entity.title,entity.coverName,entity.MovieName,entity.detail_description,@(entity.orderTag),@(entity.accordingButtonTag),entity.accordingButtonName,entity.VCName,entity.VCNameDescription,entity.for_expand1,entity.for_expand2,entity.for_expand3";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [objs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ThirdLevelMovieVC* entity = (ThirdLevelMovieVC*)obj;
            
            @try {
                NSString *tempSql = [NSString stringWithFormat:@"UPDATE ThirdLevelMovieVC set  id= ? , title= ? , coverName= ? , MovieName= ? , detail_description= ? , orderTag= ? , accordingButtonTag= ? , accordingButtonName= ? , VCName= ? , VCNameDescription= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? "];
                NSString *sql = [NSString stringWithFormat:@"%@ %@",tempSql,where];
                BOOL result = [db executeUpdate:sql,entity.id,entity.title,entity.coverName,entity.MovieName,entity.detail_description,@(entity.orderTag),@(entity.accordingButtonTag),entity.accordingButtonName,entity.VCName,entity.VCNameDescription,entity.for_expand1,entity.for_expand2,entity.for_expand3];
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
    result = [ThirdLevelMovieVC deleteWithWhereString:@"" success:success failure:failure]; 
    return result;
}


@end
