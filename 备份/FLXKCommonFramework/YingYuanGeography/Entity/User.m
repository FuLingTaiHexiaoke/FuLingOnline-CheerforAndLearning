//
//  User.m
//  YingYuanGeography
//
//  Created by 肖科 on 2017/8/4.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "User.h"
#import "FLXKDBHelper.h"

@implementation User

//createTable
+ (BOOL)createTable
{
    __block BOOL res = YES;
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if ([db tableExists:@"user"])
        {
            return ;
        }
        NSString *tableName = NSStringFromClass(self.class);
        NSString *columeAndType = @"user_id TEXT,user_name TEXT,user_class TEXT,user_type TEXT,user_school TEXT,user_sex TEXT,user_birthday TEXT,user_use_timestamp TEXT,user_total_time TEXT,user_total_times TEXT,for_expand1 TEXT,for_expand2 TEXT,for_expand3 TEXT,for_expand4 TEXT,for_expand5 TEXT,for_expand6 TEXT";
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
        if ([db tableExists:@"user"])
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
+ (NSArray<User*> *)selectAll
{
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    NSMutableArray *entitiyResults = [NSMutableArray array];
    [FLXKDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM User"];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            User *entity = [[User alloc] init];
            entity.user_id=[resultSet stringForColumn:@"user_id"];
            entity.user_name=[resultSet stringForColumn:@"user_name"];
            entity.user_class=[resultSet stringForColumn:@"user_class"];
            entity.user_type=[resultSet stringForColumn:@"user_type"];
            entity.user_school=[resultSet stringForColumn:@"user_school"];
            entity.user_sex=[resultSet stringForColumn:@"user_sex"];
            entity.user_birthday=[resultSet stringForColumn:@"user_birthday"];
            entity.user_use_timestamp=[resultSet stringForColumn:@"user_use_timestamp"];
            entity.user_total_time=[resultSet stringForColumn:@"user_total_time"];
            entity.user_total_times=[resultSet stringForColumn:@"user_total_times"];
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
+ (NSArray<User*> *)selectByCriteria:(NSString *)criteria
{
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    NSMutableArray *entitiyResults = [NSMutableArray array];
    [FLXKDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM User %@",criteria];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            User *entity = [[User alloc] init];
            entity.user_id=[resultSet stringForColumn:@"user_id"];
            entity.user_name=[resultSet stringForColumn:@"user_name"];
            entity.user_class=[resultSet stringForColumn:@"user_class"];
            entity.user_type=[resultSet stringForColumn:@"user_type"];
            entity.user_school=[resultSet stringForColumn:@"user_school"];
            entity.user_sex=[resultSet stringForColumn:@"user_sex"];
            entity.user_birthday=[resultSet stringForColumn:@"user_birthday"];
            entity.user_use_timestamp=[resultSet stringForColumn:@"user_use_timestamp"];
            entity.user_total_time=[resultSet stringForColumn:@"user_total_time"];
            entity.user_total_times=[resultSet stringForColumn:@"user_total_times"];
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
+ (BOOL)insertWithObject:(User*)obj success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@"user_id,user_name,user_class,user_type,user_school,user_sex,user_birthday,user_use_timestamp,user_total_time,user_total_times,for_expand1,for_expand2,for_expand3,for_expand4,for_expand5,for_expand6";
    //NSString *valueString =@"?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?";
    //NSString *insertValues =@"obj.user_id,obj.user_name,obj.user_class,obj.user_type,obj.user_school,obj.user_sex,obj.user_birthday,obj.user_use_timestamp,obj.user_total_time,obj.user_total_times,obj.for_expand1,obj.for_expand2,obj.for_expand3,obj.for_expand4,obj.for_expand5,obj.for_expand6";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        @try {
            NSString *sql = @"INSERT OR REPLACE INTO User(user_id,user_name,user_class,user_type,user_school,user_sex,user_birthday,user_use_timestamp,user_total_time,user_total_times,for_expand1,for_expand2,for_expand3,for_expand4,for_expand5,for_expand6) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            BOOL result = [db executeUpdate:sql,obj.user_id,obj.user_name,obj.user_class,obj.user_type,obj.user_school,obj.user_sex,obj.user_birthday,obj.user_use_timestamp,obj.user_total_time,obj.user_total_times,obj.for_expand1,obj.for_expand2,obj.for_expand3,obj.for_expand4,obj.for_expand5,obj.for_expand6];
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
+ (BOOL)insertWithObjects:(NSArray<User*>*)objs success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@"user_id,user_name,user_class,user_type,user_school,user_sex,user_birthday,user_use_timestamp,user_total_time,user_total_times,for_expand1,for_expand2,for_expand3,for_expand4,for_expand5,for_expand6";
    //NSString *valueString =@"?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?";
    //NSString *insertValues =@"entity.user_id,entity.user_name,entity.user_class,entity.user_type,entity.user_school,entity.user_sex,entity.user_birthday,entity.user_use_timestamp,entity.user_total_time,entity.user_total_times,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [objs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            User* entity = (User*)obj;
            
            @try {
                NSString *sql = @"INSERT OR REPLACE INTO User(user_id,user_name,user_class,user_type,user_school,user_sex,user_birthday,user_use_timestamp,user_total_time,user_total_times,for_expand1,for_expand2,for_expand3,for_expand4,for_expand5,for_expand6) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                BOOL result = [db executeUpdate:sql,entity.user_id,entity.user_name,entity.user_class,entity.user_type,entity.user_school,entity.user_sex,entity.user_birthday,entity.user_use_timestamp,entity.user_total_time,entity.user_total_times,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6];
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
+ (BOOL)updateObject:(User*)obj withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@" user_id= ? , user_name= ? , user_class= ? , user_type= ? , user_school= ? , user_sex= ? , user_birthday= ? , user_use_timestamp= ? , user_total_time= ? , user_total_times= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? , for_expand4= ? , for_expand5= ? , for_expand6= ? ";
    //NSString *insertValues =@"entity.user_id,entity.user_name,entity.user_class,entity.user_type,entity.user_school,entity.user_sex,entity.user_birthday,entity.user_use_timestamp,entity.user_total_time,entity.user_total_times,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        User* entity = (User*)obj;
        
        @try {
            NSString *tempSql = [NSString stringWithFormat:@"UPDATE User set  user_id= ? , user_name= ? , user_class= ? , user_type= ? , user_school= ? , user_sex= ? , user_birthday= ? , user_use_timestamp= ? , user_total_time= ? , user_total_times= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? , for_expand4= ? , for_expand5= ? , for_expand6= ? "];
            NSString *sql = [NSString stringWithFormat:@"%@ %@",tempSql,where];
            BOOL result = [db executeUpdate:sql,entity.user_id,entity.user_name,entity.user_class,entity.user_type,entity.user_school,entity.user_sex,entity.user_birthday,entity.user_use_timestamp,entity.user_total_time,entity.user_total_times,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6];
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
+ (BOOL)updateObjects:(NSArray<User*>*)objs withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@" user_id= ? , user_name= ? , user_class= ? , user_type= ? , user_school= ? , user_sex= ? , user_birthday= ? , user_use_timestamp= ? , user_total_time= ? , user_total_times= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? , for_expand4= ? , for_expand5= ? , for_expand6= ? ";
    //NSString *insertValues =@"entity.user_id,entity.user_name,entity.user_class,entity.user_type,entity.user_school,entity.user_sex,entity.user_birthday,entity.user_use_timestamp,entity.user_total_time,entity.user_total_times,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [objs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            User* entity = (User*)obj;
            
            @try {
                NSString *tempSql = [NSString stringWithFormat:@"UPDATE User set  user_id= ? , user_name= ? , user_class= ? , user_type= ? , user_school= ? , user_sex= ? , user_birthday= ? , user_use_timestamp= ? , user_total_time= ? , user_total_times= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? , for_expand4= ? , for_expand5= ? , for_expand6= ? "];
                NSString *sql = [NSString stringWithFormat:@"%@ %@",tempSql,where];
                BOOL result = [db executeUpdate:sql,entity.user_id,entity.user_name,entity.user_class,entity.user_type,entity.user_school,entity.user_sex,entity.user_birthday,entity.user_use_timestamp,entity.user_total_time,entity.user_total_times,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.for_expand4,entity.for_expand5,entity.for_expand6];
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
    result = [User deleteWithWhereString:@"" success:success failure:failure]; 
    return result;
}


@end
