//
//  b_sub_items.m
//  Psy-CommonFramework
//
//  Created by 肖科 on 17/3/30.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "b_sub_items.h"
#import "FLXKDBHelper.h"

@implementation b_sub_items

//createTable
+ (BOOL)createTable
{
    __block BOOL res = YES;
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if ([db tableExists:@"b_sub_items"])
        {
            return ;
        }
        NSString *tableName = NSStringFromClass(self.class);
        NSString *columeAndType = @"id TEXT,name TEXT,title TEXT,detail_description TEXT,image_name TEXT,item_id INTEGER,for_expand1 TEXT,for_expand2 TEXT,for_expand3 TEXT";
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
        if ([db tableExists:@"b_sub_items"])
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
+ (NSArray<b_sub_items*> *)selectAll
{
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    NSMutableArray *entitiyResults = [NSMutableArray array];
    [FLXKDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM b_sub_items"];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            b_sub_items *entity = [[b_sub_items alloc] init];
            entity.id=[resultSet stringForColumn:@"id"];
            entity.name=[resultSet stringForColumn:@"name"];
            entity.title=[resultSet stringForColumn:@"title"];
            entity.detail_description=[resultSet stringForColumn:@"detail_description"];
            entity.image_name=[resultSet stringForColumn:@"image_name"];
            entity.item_id=[resultSet longLongIntForColumn:@"item_id"];
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
+ (NSArray<b_sub_items*> *)selectByCriteria:(NSString *)criteria
{
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    NSMutableArray *entitiyResults = [NSMutableArray array];
    [FLXKDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM b_sub_items %@",criteria];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            b_sub_items *entity = [[b_sub_items alloc] init];
            entity.id=[resultSet stringForColumn:@"id"];
            entity.name=[resultSet stringForColumn:@"name"];
            entity.title=[resultSet stringForColumn:@"title"];
            entity.detail_description=[resultSet stringForColumn:@"detail_description"];
            entity.image_name=[resultSet stringForColumn:@"image_name"];
            entity.item_id=[resultSet longLongIntForColumn:@"item_id"];
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
+ (BOOL)insertWithObject:(b_sub_items*)obj success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@"id,name,title,detail_description,image_name,item_id,for_expand1,for_expand2,for_expand3";
    //NSString *valueString =@"?,?,?,?,?,?,?,?,?";
    //NSString *insertValues =@"obj.id,obj.name,obj.title,obj.detail_description,obj.image_name,@(obj.item_id),obj.for_expand1,obj.for_expand2,obj.for_expand3";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        @try {
            NSString *sql = @"INSERT OR REPLACE INTO b_sub_items(id,name,title,detail_description,image_name,item_id,for_expand1,for_expand2,for_expand3) VALUES (?,?,?,?,?,?,?,?,?)";
            BOOL result = [db executeUpdate:sql,obj.id,obj.name,obj.title,obj.detail_description,obj.image_name,@(obj.item_id),obj.for_expand1,obj.for_expand2,obj.for_expand3];
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
+ (BOOL)insertWithObjects:(NSArray<b_sub_items*>*)objs success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@"id,name,title,detail_description,image_name,item_id,for_expand1,for_expand2,for_expand3";
    //NSString *valueString =@"?,?,?,?,?,?,?,?,?";
    //NSString *insertValues =@"entity.id,entity.name,entity.title,entity.detail_description,entity.image_name,@(entity.item_id),entity.for_expand1,entity.for_expand2,entity.for_expand3";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [objs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            b_sub_items* entity = (b_sub_items*)obj;
            
            @try {
                NSString *sql = @"INSERT OR REPLACE INTO b_sub_items(id,name,title,detail_description,image_name,item_id,for_expand1,for_expand2,for_expand3) VALUES (?,?,?,?,?,?,?,?,?)";
                BOOL result = [db executeUpdate:sql,entity.id,entity.name,entity.title,entity.detail_description,entity.image_name,@(entity.item_id),entity.for_expand1,entity.for_expand2,entity.for_expand3];
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
+ (BOOL)updateObject:(b_sub_items*)obj withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@" id= ? , name= ? , title= ? , detail_description= ? , image_name= ? , item_id= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? ";
    //NSString *insertValues =@"entity.id,entity.name,entity.title,entity.detail_description,entity.image_name,@(entity.item_id),entity.for_expand1,entity.for_expand2,entity.for_expand3";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        b_sub_items* entity = (b_sub_items*)obj;
        
        @try {
            NSString *tempSql = [NSString stringWithFormat:@"UPDATE b_sub_items set  id= ? , name= ? , title= ? , detail_description= ? , image_name= ? , item_id= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? "];
            NSString *sql = [NSString stringWithFormat:@"%@ %@",tempSql,where];
            BOOL result = [db executeUpdate:sql,entity.id,entity.name,entity.title,entity.detail_description,entity.image_name,@(entity.item_id),entity.for_expand1,entity.for_expand2,entity.for_expand3];
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
+ (BOOL)updateObjects:(NSArray<b_sub_items*>*)objs withWhereString:(NSString*)where success:(void(^)())success failure:(void(^)(NSString* errorDescripe))failure
{
    __block BOOL isRollBack = NO;
    __block BOOL result = NO;
    //NSString *keyString =@" id= ? , name= ? , title= ? , detail_description= ? , image_name= ? , item_id= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? ";
    //NSString *insertValues =@"entity.id,entity.name,entity.title,entity.detail_description,entity.image_name,@(entity.item_id),entity.for_expand1,entity.for_expand2,entity.for_expand3";
    
    
    
    FLXKDBHelper *FLXKDB = [FLXKDBHelper shareInstance];
    [FLXKDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [objs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            b_sub_items* entity = (b_sub_items*)obj;
            
            @try {
                NSString *tempSql = [NSString stringWithFormat:@"UPDATE b_sub_items set  id= ? , name= ? , title= ? , detail_description= ? , image_name= ? , item_id= ? , for_expand1= ? , for_expand2= ? , for_expand3= ? "];
                NSString *sql = [NSString stringWithFormat:@"%@ %@",tempSql,where];
                BOOL result = [db executeUpdate:sql,entity.id,entity.name,entity.title,entity.detail_description,entity.image_name,@(entity.item_id),entity.for_expand1,entity.for_expand2,entity.for_expand3];
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
    result = [b_sub_items deleteWithWhereString:@"" success:success failure:failure]; 
    return result;
}


@end
