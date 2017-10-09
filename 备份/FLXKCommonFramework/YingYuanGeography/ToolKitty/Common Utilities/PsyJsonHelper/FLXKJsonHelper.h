//
//  FLXKJsonHelper.h
//  Psy-TeachersTerminal
//
//  Created by 123 on 16/8/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLXKJsonHelper<__covariant Type> : NSObject


/**
JsonString -> object
 */

//to convert jsonstring  to object
//+(Type _Nonnull)convertJsonStringToObj:(NSString* _Nonnull)jsonString withType:(NSString* _Nonnull)type;

//to convert jsonstring  to objects
+(NSArray<Type>* _Nonnull )convertJsonStringToObjs:(NSString* _Nonnull)jsonString withType:(NSString* _Nonnull)type;

////to convert json to objects
//+(NSArray<Type>* _Nonnull )convertJsonToObjs:(NSString* _Nonnull)jsonString withType:(NSString* _Nonnull)type;

/**
 object  -> JsonString
 */

//to convert object to jsonstring
//+(NSString* _Nonnull)generateJsonStringFromObj:(Type _Nonnull)obj withType:(NSString* _Nonnull)type;

//to convert objects to jsonstring
+(NSString* _Nonnull)generateJsonStringFromObjs:( NSArray<Type>* _Nonnull )objs withType:(NSString* _Nonnull)type;




/**
 File -> JsonString
 */

//to convert jsonstring to objects
+(NSArray<Type>* _Nonnull)convertJsonStringToObjsFromFile:(nullable NSString*)filePath withType:(NSString* _Nonnull)type;



/**
 JsonString -> File
 */

// write the JsonString convert from obj To File
//+(NSError* _Nonnull)writeJsonStringFromObj:(Type _Nonnull)obj withType:(NSString* _Nonnull)type toFile:(nullable NSString*)filePath;

// write the JsonString convert from objs To File
+(NSError* _Nonnull)writeJsonStringFromObjs:(NSArray<Type>* _Nonnull)objs withType:(NSString* _Nonnull)type ToFile:(nullable NSString*)filePath;

// append the JsonString convert from obj To File
//+(NSError* _Nonnull)appendJsonStringFromObj:(Type _Nonnull)obj withType:(NSString* _Nonnull)type toFile:(nullable NSString*)filePath;

// append the JsonString convert from objs To File
+(NSError* _Nonnull)appendJsonStringFromObjs:(NSArray<Type>* _Nonnull)objs withType:(NSString* _Nonnull)type ToFile:(nullable NSString*)filePath;



//generate NSError with description
+(NSError* _Nonnull)errorWithDescription:(NSString* _Nonnull)description;

//write JsonString To File
+(NSError* _Nonnull)writeJsonString:( NSString* _Nonnull )jsonString type:(NSString* _Nonnull)type ToFile:(nullable NSString*)filePath isAppend:(BOOL)isAppend;



@end
