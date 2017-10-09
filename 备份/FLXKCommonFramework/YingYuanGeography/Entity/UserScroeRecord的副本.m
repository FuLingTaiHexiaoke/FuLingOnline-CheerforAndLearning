//
//  UserScroeRecord.m
//  YingYuanGeography
//
//  Created by 肖科 on 2017/8/4.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "UserScroeRecord.h"
#import "FLXKDBHelper.h"

@implementation UserScroeRecord

//createTable
+ (BOOL)createTable
{
    __block BOOL res = YES;
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if ([db tableExists:@"userscroerecord"])
        {
            return ;
        }
        NSString *tableName = NSStringFromClass(self.class);
        NSString *columeAndType = @"user_id TEXT,user_name TEXT,user_class TEXT,user_type TEXT,user_school TEXT,currentScroe TEXT,currentScroeDescription TEXT,for_expand1 TEXT,for_expand2 TEXT,for_expand3 TEXT,accordingVCName TEXT,testType TEXT,menuButtonTag INTEGER,menuButtonName TEXT,accordingButtonTag INTEGER,accordingButtonName TEXT,VCName TEXT,VCNameDescription TEXT,for_expand4 TEXT,for_expand5 TEXT,for_expand6 TEXT,for_expand7 TEXT,for_expand8 TEXT,for_expand9 TEXT,for_expand10 TEXT";
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
        if ([db tableExists:@"userscroerecord"])
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
+ (NSArray<UserScroeRecord*> *)selectAll
{
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    NSMutableArray *entitiyResults = [NSMutableArray array];
    [FLXKDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM UserScroeRecord"];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            UserScroeRecord *entity = [[UserScroeRecord alloc] init];
            entity.user_id=[resultSet stringForColumn:@"user_id"];
            entity.user_name=[resultSet stringForColumn:@"user_name"];
            entity.user_class=[resultSet stringForColumn:@"user_class"];
            entity.user_type=[resultSet stringForColumn:@"user_type"];
            entity.user_school=[resultSet stringForColumn:@"user_school"];
            entity.currentScroe=[resultSet stringForColumn:@"currentScroe"];
            entity.currentScroeDescription=[resultSet stringForColumn:@"currentScroeDescription"];
            entity.for_expand1=[resultSet stringForColumn:@"for_expand1"];
            entity.for_expand2=[resultSet stringForColumn:@"for_expand2"];
            entity.for_expand3=[resultSet stringForColumn:@"for_expand3"];
            entity.accordingVCName=[resultSet stringForColumn:@"accordingVCName"];
            entity.testType=[resultSet stringForColumn:@"testType"];
            entity.menuButtonTag=[resultSet longLongIntForColumn:@"menuButtonTag"];
            entity.menuButtonName=[resultSet stringForColumn:@"menuButtonName"];
            entity.accordingButtonTag=[resultSet longLongIntForColumn:@"accordingButtonTag"];
            entity.accordingButtonName=[resultSet stringForColumn:@"accordingButtonName"];
            entity.VCName=[resultSet stringForColumn:@"VCName"];
            entity.VCNameDescription=[resultSet stringForColumn:@"VCNameDescription"];
            entity.for_expand4=[resultSet stringForColumn:@"for_expand4"];
            entity.for_expand5=[resultSet stringForColumn:@"for_expand5"];
            entity.for_expand6=[resultSet stringForColumn:@"for_expand6"];
            entity.for_expand7=[resultSet stringForColumn:@"for_expand7"];
            entity.for_expand8=[resultSet stringForColumn:@"for_expand8"];
            entity.for_expand9=[resultSet stringForColumn:@"for_expand9"];
            entity.for_expand10=[resultSet stringForColumn:@"for_expand10"];
            [entitiyResults addObject:entity];
            FMDBRelease(entity);
        }
    }];
    return entitiyResults;
};
//selectByCriteria
+ (NSArray<UserScroeRecord*> *)selectByCriteria:(NSString *)criteria
{
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    NSMutableArray *entitiyResults = [NSMutableArray array];
    [FLXKDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM UserScroeRecord %@",criteria];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            UserScroeRecord *entity = [[UserScroeRecord alloc] init];
            entity.user_id=[resultSet stringForColumn:@"user_id"];
            entity.user_name=[resultSet stringForColumn:@"user_name"];
            entity.user_class=[resultSet stringForColumn:@"user_class"];
            entity.user_type=[resultSet stringForColumn:@"user_type"];
            entity.user_school=[resultSet stringForColumn:@"user_school"];
            entity.currentScroe=[resultSet stringForColumn:@"currentScroe"];
            entity.currentScroeDescription=[resultSet stringForColumn:@"currentScroeDescription"];
            entity.for_expand1=[resultSet stringForColumn:@"for_expand1"];
            entity.for_expand2=[resultSet stringForColumn:@"for_expand2"];
            entity.for_expand3=[resultSet stringForColumn:@"for_expand3"];
            entity.accordingVCName=[resultSet stringForColumn:@"accordingVCName"];
            entity.testType=[resultSet stringForColumn:@"testType"];
            entity.menuButtonTag=[resultSet longLongIntForColumn:@"menuButtonTag"];
            entity.menuButtonName=[resultSet stringForColumn:@"menuButtonName"];
            entity.accordingButtonTag=[resultSet longLongIntForColumn:@"accordingButtonTag"];
            entity.accordingButtonName=[resultSet stringForColumn:@"accordingButtonName"];
            entity.VCName=[resultSet stringForColumn:@"VCName"];
            entity.VCNameDescription=[resultSet stringForColumn:@"VCNameDescription"];
            entity.for_expand4=[resultSet stringForColumn:@"for_expand4"];
            entity.for_expand5=[resultSet stringForColumn:@"for_expand5"];
            entity.for_expand6=[resultSet stringForColumn:@"for_expand6"];
            entity.for_expand7=[resultSet stringForColumn:@"for_expand7"];
            entity.for_expand8=[resultSet stringForColumn:@"for_expand8"];
            entity.for_expand9=[resultSet stringForColumn:@"for_expand9"];
            entity.for_expand10=[resultSet stringForColumn:@"for_expand10"];
            [entitiyResults addObject:entity];
            FMDBRelease(entity);
        }
    }];
    return entitiyResults;
};

//selectTotalScoreByCriteria
+ (NSString*)selectTotalScoreByCriteria:(NSString *)criteria
{
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
//    NSMutableArray *entitiyResults = [NSMutableArray array];
   __block  NSString* totalScore;
    [FLXKDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT SUM(currentScroe) FROM UserScroeRecord %@",criteria];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            totalScore=[resultSet stringForColumn:@"currentScroe"];
        }
    }];
    return totalScore;
};

//insertWithObject:
+ (BOOL)insertWithObject:(UserScroeRecord*)obj success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@"user_id,user_name,user_class,user_type,user_school,currentScroe,currentScroeDescription,for_expand1,for_expand2,for_expand3,accordingVCName,testType,menuButtonTag,menuButtonName,accordingButtonTag,accordingButtonName,VCName,VCNameDescription,for_expand4,for_expand5,for_expand6,for_expand7,for_expand8,for_expand9,for_expand10";
    //NSString *valueString =@"?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?";
    //NSString *insertValues =@"obj.user_id,obj.user_name,obj.user_class,obj.user_type,obj.user_school,obj.currentScroe,obj.currentScroeDescription,obj.for_expand1,obj.for_expand2,obj.for_expand3,obj.accordingVCName,obj.testType,@(obj.menuButtonTag),obj.menuButtonName,@(obj.accordingButtonTag),obj.accordingButtonName,obj.VCName,obj.VCNameDescription,obj.for_expand4,obj.for_expand5,obj.for_expand6,obj.for_expand7,obj.for_expand8,obj.for_expand9,obj.for_expand10";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        @try {
            NSString *sql = @"INSERT OR REPLACE INTO UserScroeRecord(user_id,user_name,user_class,user_type,user_school,currentScroe,currentScroeDescription,for_expand1,for_expand2,for_expand3,accordingVCName,testType,menuButtonTag,menuButtonName,accordingButtonTag,accordingButtonName,VCName,VCNameDescription,for_expand4,for_expand5,for_expand6,for_expand7,for_expand8,for_expand9,for_expand10) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            BOOL result = [db executeUpdate:sql,obj.user_id,obj.user_name,obj.user_class,obj.user_type,obj.user_school,obj.currentScroe,obj.currentScroeDescription,obj.for_expand1,obj.for_expand2,obj.for_expand3,obj.accordingVCName,obj.testType,@(obj.menuButtonTag),obj.menuButtonName,@(obj.accordingButtonTag),obj.accordingButtonName,obj.VCName,obj.VCNameDescription,obj.for_expand4,obj.for_expand5,obj.for_expand6,obj.for_expand7,obj.for_expand8,obj.for_expand9,obj.for_expand10];
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
+ (BOOL)insertWithObjects:(NSArray<UserScroeRecord*>*)objs success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@"user_id,user_name,user_class,user_type,user_school,currentScroe,currentScroeDescription,for_expand1,for_expand2,for_expand3,accordingVCName,testType,menuButtonTag,menuButtonName,accordingButtonTag,accordingButtonName,VCName,VCNameDescription,for_expand4,for_expand5,for_expand6,for_expand7,for_expand8,for_expand9,for_expand10";
    //NSString *valueString =@"?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?";
    //NSString *insertValues =@"entity.user_id,entity.user_name,entity.user_class,entity.user_type,entity.user_school,entity.currentScroe,entity.currentScroeDescription,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.accordingVCName,entity.testType,@(entity.menuButtonTag),entity.menuButtonName,@(entity.accordingButtonTag),entity.accordingButtonName,entity.VCName,entity.VCNameDescription,entity.for_expand4,entity.for_expand5,entity.for_expand6,entity.for_expand7,entity.for_expand8,entity.for_expand9,entity.for_expand10";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [objs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UserScroeRecord* entity = (UserScroeRecord*)obj;
            
            @try {
                NSString *sql = @"INSERT OR REPLACE INTO UserScroeRecord(user_id,user_name,user_class,user_type,user_school,currentScroe,currentScroeDescription,for_expand1,for_expand2,for_expand3,accordingVCName,testType,menuButtonTag,menuButtonName,accordingButtonTag,accordingButtonName,VCName,VCNameDescription,for_expand4,for_expand5,for_expand6,for_expand7,for_expand8,for_expand9,for_expand10) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                BOOL result = [db executeUpdate:sql,entity.user_id,entity.user_name,entity.user_class,entity.user_type,entity.user_school,entity.currentScroe,entity.currentScroeDescription,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.accordingVCName,entity.testType,@(entity.menuButtonTag),entity.menuButtonName,@(entity.accordingButtonTag),entity.accordingButtonName,entity.VCName,entity.VCNameDescription,entity.for_expand4,entity.for_expand5,entity.for_expand6,entity.for_expand7,entity.for_expand8,entity.for_expand9,entity.for_expand10];
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
+ (BOOL)updateObject:(UserScroeRecord*)obj withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@" user_id= ? , user_name= ? , user_class= ? , user_type= ? , user_school= ? , currentScroe= ? , currentScroeDescription= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? , accordingVCName= ? , testType= ? , menuButtonTag= ? , menuButtonName= ? , accordingButtonTag= ? , accordingButtonName= ? , VCName= ? , VCNameDescription= ? , for_expand4= ? , for_expand5= ? , for_expand6= ? , for_expand7= ? , for_expand8= ? , for_expand9= ? , for_expand10= ? ";
    //NSString *insertValues =@"entity.user_id,entity.user_name,entity.user_class,entity.user_type,entity.user_school,entity.currentScroe,entity.currentScroeDescription,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.accordingVCName,entity.testType,@(entity.menuButtonTag),entity.menuButtonName,@(entity.accordingButtonTag),entity.accordingButtonName,entity.VCName,entity.VCNameDescription,entity.for_expand4,entity.for_expand5,entity.for_expand6,entity.for_expand7,entity.for_expand8,entity.for_expand9,entity.for_expand10";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        UserScroeRecord* entity = (UserScroeRecord*)obj;
        
        @try {
            NSString *tempSql = [NSString stringWithFormat:@"UPDATE UserScroeRecord set  user_id= ? , user_name= ? , user_class= ? , user_type= ? , user_school= ? , currentScroe= ? , currentScroeDescription= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? , accordingVCName= ? , testType= ? , menuButtonTag= ? , menuButtonName= ? , accordingButtonTag= ? , accordingButtonName= ? , VCName= ? , VCNameDescription= ? , for_expand4= ? , for_expand5= ? , for_expand6= ? , for_expand7= ? , for_expand8= ? , for_expand9= ? , for_expand10= ? "];
            NSString *sql = [NSString stringWithFormat:@"%@ %@",tempSql,where];
            BOOL result = [db executeUpdate:sql,entity.user_id,entity.user_name,entity.user_class,entity.user_type,entity.user_school,entity.currentScroe,entity.currentScroeDescription,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.accordingVCName,entity.testType,@(entity.menuButtonTag),entity.menuButtonName,@(entity.accordingButtonTag),entity.accordingButtonName,entity.VCName,entity.VCNameDescription,entity.for_expand4,entity.for_expand5,entity.for_expand6,entity.for_expand7,entity.for_expand8,entity.for_expand9,entity.for_expand10];
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
+ (BOOL)updateObjects:(NSArray<UserScroeRecord*>*)objs withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@" user_id= ? , user_name= ? , user_class= ? , user_type= ? , user_school= ? , currentScroe= ? , currentScroeDescription= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? , accordingVCName= ? , testType= ? , menuButtonTag= ? , menuButtonName= ? , accordingButtonTag= ? , accordingButtonName= ? , VCName= ? , VCNameDescription= ? , for_expand4= ? , for_expand5= ? , for_expand6= ? , for_expand7= ? , for_expand8= ? , for_expand9= ? , for_expand10= ? ";
    //NSString *insertValues =@"entity.user_id,entity.user_name,entity.user_class,entity.user_type,entity.user_school,entity.currentScroe,entity.currentScroeDescription,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.accordingVCName,entity.testType,@(entity.menuButtonTag),entity.menuButtonName,@(entity.accordingButtonTag),entity.accordingButtonName,entity.VCName,entity.VCNameDescription,entity.for_expand4,entity.for_expand5,entity.for_expand6,entity.for_expand7,entity.for_expand8,entity.for_expand9,entity.for_expand10";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [objs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UserScroeRecord* entity = (UserScroeRecord*)obj;
            
            @try {
                NSString *tempSql = [NSString stringWithFormat:@"UPDATE UserScroeRecord set  user_id= ? , user_name= ? , user_class= ? , user_type= ? , user_school= ? , currentScroe= ? , currentScroeDescription= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? , accordingVCName= ? , testType= ? , menuButtonTag= ? , menuButtonName= ? , accordingButtonTag= ? , accordingButtonName= ? , VCName= ? , VCNameDescription= ? , for_expand4= ? , for_expand5= ? , for_expand6= ? , for_expand7= ? , for_expand8= ? , for_expand9= ? , for_expand10= ? "];
                NSString *sql = [NSString stringWithFormat:@"%@ %@",tempSql,where];
                BOOL result = [db executeUpdate:sql,entity.user_id,entity.user_name,entity.user_class,entity.user_type,entity.user_school,entity.currentScroe,entity.currentScroeDescription,entity.for_expand1,entity.for_expand2,entity.for_expand3,entity.accordingVCName,entity.testType,@(entity.menuButtonTag),entity.menuButtonName,@(entity.accordingButtonTag),entity.accordingButtonName,entity.VCName,entity.VCNameDescription,entity.for_expand4,entity.for_expand5,entity.for_expand6,entity.for_expand7,entity.for_expand8,entity.for_expand9,entity.for_expand10];
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
    result = [UserScroeRecord deleteWithWhereString:@"" success:success failure:failure]; 
    return result;
}


@end
