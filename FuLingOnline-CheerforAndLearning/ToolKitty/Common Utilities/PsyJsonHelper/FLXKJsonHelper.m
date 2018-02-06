//
//  FLXKJsonHelper.m
//  Psy-TeachersTerminal
//
//  Created by 123 on 16/8/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#define DefaultEntityDirectory @"PsyDefaultJsonDirectory"
#define DefaultFileExtension @".json"

#import "FLXKJsonHelper.h"
#import "FLXKPathHelper.h"
#import "MJExtension.h"
#import "PsyZipArchive.h"


@interface FLXKJsonHelper<Type> ()

@end



@implementation FLXKJsonHelper

/**
 JsonString -> object
 */

////to convert jsonstring  to object
//+(id _Nonnull)convertJsonStringToObj:(NSString* _Nonnull)jsonString withType:(NSString* _Nonnull)type{
//    NSArray* objs=[FLXKJsonHelper convertJsonStringToObjs:jsonString withType:type];
//    if (objs && objs.count>0) {
//        return objs[0];
//    }
//    else{
//        return nil;
//    }
//
//}

//to convert jsonstring  to objects
+(id _Nonnull )convertJsonStringToObjs:(NSString* _Nonnull)jsonString withType:(NSString* _Nonnull)type{
    NSArray *objArray=[NSArray array];
    if (jsonString) {
        //start to read data
        NSError *error;
        NSData* jsonData=[jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSArray* dictArray=[NSJSONSerialization  JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        if (!error) {
            // JSON array -> Model array
            objArray = [NSClassFromString(type) mj_objectArrayWithKeyValuesArray:dictArray];
        }
        else{
            objArray=nil;
        }
    }
    return objArray;
}

//to convert json to objects
//+(NSArray<Type>* _Nonnull )convertJsonToObjs:(NSString* _Nonnull)json withType:(NSString* _Nonnull)type{
//
//}

/**
 object  -> JsonString
 */

//to convert object to jsonstring
//+(NSString* _Nonnull)generateJsonStringFromObj:(id _Nonnull)obj withType:(NSString* _Nonnull)type{
//    Class  a= NSClassFromString(type);
//    NSArray<a>*
//    NSArray* objs=[NSArray arrayWithObject:obj];
//    NSString* jsonString=[FLXKJsonHelper generateJsonStringFromObjs:objs withType:type];
//    return jsonString;
//}

//to convert objects to jsonstring
+(NSString* _Nonnull)generateJsonStringFromObjs:(id _Nonnull )objs withType:(NSString* _Nonnull)type{
    NSString *jsonString = @"";
    if (objs) {
        NSArray *dictArray = [NSClassFromString(type)  mj_keyValuesArrayWithObjectArray:objs];
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictArray options:NSJSONWritingPrettyPrinted error:&error];
        if (!error) {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        else{
            NSAssert(!error, @"an error throwed out!");
            jsonString=error.description;
        }
        
    }
    else{
        NSLog(@"Objs is nil,please check!");
        jsonString =@"";
    }
    return jsonString;
}



//
///**
// File -> JsonString
// */
//
//to convert jsonstring to objects
+(id _Nonnull)convertJsonStringToObjsFromFile:(nullable NSString*)filePath withType:(NSString* _Nonnull)type{
    
    if (filePath) {
        filePath=[FLXKPathHelper checkOrCreateFile:filePath];
        if (filePath) {
            //start to read data to file
            NSData* jsonData=[NSData dataWithContentsOfFile:filePath];
            NSArray* dictArray=[NSJSONSerialization  JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            // JSON array -> Model array
            NSArray *objArray = [NSClassFromString(type) mj_objectArrayWithKeyValuesArray:dictArray];
            return objArray;

        }
        else{
            return nil;
        }
    }
    else{
        NSString* designedPath = [DefaultEntityDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",type,DefaultFileExtension]];
        designedPath=[FLXKPathHelper checkOrCreateFile:designedPath];
        if (designedPath) {
            NSLog(@"%@",designedPath);
            //start to read data to file
            NSData* a=[NSData dataWithContentsOfFile:designedPath];
            NSArray* dictArray=[NSJSONSerialization  JSONObjectWithData:a options:NSJSONReadingMutableContainers error:nil];
            // JSON array -> Model array
            NSArray *objArray = [NSClassFromString(type) mj_objectArrayWithKeyValuesArray:dictArray];
            return objArray;
        }
        else{
            return nil;
        }
    }
}

/**
 JsonString -> File
 */

// write the JsonString convert from obj To File
+(NSError* _Nonnull)writeJsonStringFromObj:(id _Nonnull)obj withType:(NSString* _Nonnull)type toFile:(nullable NSString*)filePath{
    NSError* error=nil;
    if (obj) {
        NSArray* objs=[NSArray arrayWithObject:obj];
        error=[NSClassFromString(type) writeJsonStringFromObjs:objs withType:type ToFile:filePath];
    }
    else{
        error= [FLXKJsonHelper errorWithDescription:@"Obj is nil,please check!"];
    }
    return error;
}

// write the JsonString convert from objs To File
+(NSError* _Nonnull)writeJsonStringFromObjs:(id _Nonnull)objs withType:(NSString* _Nonnull)type ToFile:(nullable NSString*)filePath{
    NSError* error=nil;
    NSString *jsonString = @"";
    if (objs) {
        jsonString= [FLXKJsonHelper generateJsonStringFromObjs:objs withType:type];
        error=[FLXKJsonHelper writeJsonString:jsonString type:type  ToFile:filePath isAppend:NO];
    }
    else{
        error= [FLXKJsonHelper errorWithDescription:@"Objs is nil,please check!"];
    }
    return error;
}

// append the JsonString convert from objs To File
+(NSError* _Nonnull)appendJsonStringFromObjs:(id _Nonnull)objs  withType:(NSString* _Nonnull)type ToFile:(nullable NSString*)filePath{
    NSError* error=nil;
    NSString *jsonString = @"";
    if (objs) {
        jsonString= [FLXKJsonHelper generateJsonStringFromObjs:objs withType:type];
        error=[FLXKJsonHelper writeJsonString:jsonString type:type ToFile:filePath isAppend:YES];
    }
    else{
        error= [FLXKJsonHelper errorWithDescription:@"Objs is nil,please check!"];
    }
    return error;
    
}



//generate NSError with description
+(NSError* _Nonnull)errorWithDescription:(NSString* _Nonnull)description{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:description forKey:NSLocalizedDescriptionKey];
    NSError* error=[NSError errorWithDomain:@"EntityWithJson" code:100000 userInfo:userInfo];
    return error;
}


//write JsonString To File
+(NSError* _Nonnull)writeJsonString:( NSString* _Nonnull )jsonString type:(NSString*)type ToFile:(nullable NSString*)filePath isAppend:(BOOL)isAppend{
    NSError* error=nil;
    if (filePath) {
        filePath=[FLXKPathHelper checkOrCreateFile:filePath ];
        if (!filePath) {
              return  error=[FLXKJsonHelper errorWithDescription:@"文件创建失败"];
        }
            //start to write data to file
            if (isAppend) {
                NSLog(@"%@",filePath);
                NSFileHandle *fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
                //            long endOfFileIndex= [fileHandler seekToEndOfFile];
                long endOfFileIndex=[fileHandler availableData].length;
                //charge if there already have data
                if (endOfFileIndex>0) {
                    [fileHandler seekToFileOffset:endOfFileIndex-1];
                    //jsonString replace the head and end '[' ']' and add ','
                    jsonString= [jsonString stringByReplacingOccurrencesOfString:@"[" withString:@","];
                    //                jsonString=  [jsonString stringByReplacingOccurrencesOfString:@"]" withString:@""];
                    [fileHandler writeData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
                    [fileHandler closeFile];
                }
                else{
                    [jsonString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                }
              
            }
            // if not append
            else{
                [jsonString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            return error;
        }
    
      else{
        NSString* designedPath = [DefaultEntityDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",type,DefaultFileExtension]];
        designedPath=[FLXKPathHelper checkOrCreateFile:designedPath];
        NSLog(@"%@",designedPath);
        //start to write data to file
        if (isAppend) {
            NSFileHandle *fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:designedPath];
            long endOfFileIndex=[fileHandler availableData].length;
            //charge if there already have data
            if (endOfFileIndex>0) {
                [fileHandler seekToFileOffset:endOfFileIndex-1];
                //jsonString replace the head and end '[' ']' and add ','
                jsonString= [jsonString stringByReplacingOccurrencesOfString:@"[" withString:@","];
                [fileHandler writeData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
                [fileHandler closeFile];
            }
            else{
                [jsonString writeToFile:designedPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            
        }
        
        else{
            [jsonString writeToFile:designedPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
//        //test to zip file
//        [PsyZipArchive createZipFileAtPath:[FLXKPathHelper checkOrCreatePath:@"PsyZipArchive/PsyZipArchive.zip"] withContentsOfDirectory:[FLXKPathHelper checkOrCreateDirectory:DefaultEntityDirectory]];
//        //test to unzip file funciton
//          [PsyZipArchive unzipFileAtPath:[FLXKPathHelper checkOrCreatePath:@"PsyZipArchive/PsyZipArchive.zip"] toDestination:[FLXKPathHelper checkOrCreateDirectory:@"PsyZipArchive/PsyZipArchive"]];
          
        return error;
    }
}

@end
