////
////  PsyZipArchive.m
////  Psy-TeachersTerminal
////
////  Created by 123 on 16/8/2.
////  Copyright © 2016年 apple. All rights reserved.
////
//
//#import "PsyZipArchive.h"
//
//@implementation PsyZipArchive
//
//
//// Password check
//+ (BOOL)isFilePasswordProtectedAtPath:(NSString *)path{
//  return  [SSZipArchive isFilePasswordProtectedAtPath:path];
//}
//
//// Unzip
////this method unzipFile without folder
//+ (BOOL)unzipFileAtPath:(NSString *)path toDestination:(NSString *)destination{
//   return [SSZipArchive unzipFileAtPath:path toDestination:destination];
//}
//
//+ (BOOL)unzipFileAtPath:(NSString *)path toDestination:(NSString *)destination delegate:(nullable id<SSZipArchiveDelegate>)delegate{
//        return [SSZipArchive  unzipFileAtPath:path toDestination:destination delegate:delegate];
//}
//
//+ (BOOL)unzipFileAtPath:(NSString *)path toDestination:(NSString *)destination overwrite:(BOOL)overwrite password:(nullable NSString *)password error:(NSError * *)error{
//      return    [SSZipArchive   unzipFileAtPath:path toDestination:destination overwrite:overwrite password:password error:error   ];
//}
//
//
//+ (BOOL)unzipFileAtPath:(NSString *)path
//          toDestination:(NSString *)destination
//     preserveAttributes:(BOOL)preserveAttributes
//              overwrite:(BOOL)overwrite
//               password:(nullable NSString *)password
//                  error:(NSError * *)error
//               delegate:(nullable id<SSZipArchiveDelegate>)delegate{
//    return    [SSZipArchive   unzipFileAtPath:path
//                                toDestination:destination
//                           preserveAttributes:preserveAttributes
//                                    overwrite:overwrite
//                                     password:password
//                                        error:error
//                                     delegate:delegate   ];
//}
//
//+ (BOOL)unzipFileAtPath:(NSString *)path
//          toDestination:(NSString *)destination
//        progressHandler:(void (^)(NSString *entry, unz_file_info zipInfo, long entryNumber, long total))progressHandler
//      completionHandler:(void (^)(NSString *path, BOOL succeeded, NSError *error))completionHandler{
//    return    [SSZipArchive  unzipFileAtPath:path
//                               toDestination:destination
//                             progressHandler:progressHandler
//                           completionHandler:completionHandler    ];
//}
//
//+ (BOOL)unzipFileAtPath:(NSString *)path
//          toDestination:(NSString *)destination
//              overwrite:(BOOL)overwrite
//               password:(nullable NSString *)password
//        progressHandler:(void (^)(NSString *entry, unz_file_info zipInfo, long entryNumber, long total))progressHandler
//      completionHandler:(void (^)(NSString *path, BOOL succeeded, NSError *error))completionHandler{
//    return    [SSZipArchive   unzipFileAtPath:path
//                                toDestination:destination
//                                    overwrite:overwrite
//                                     password:password
//                              progressHandler:progressHandler
//                            completionHandler:completionHandler   ];
//}
//
//// Zip
//
//// without password
//+ (BOOL)createZipFileAtPath:(NSString *)path withFilesAtPaths:(NSArray *)paths{
//      return    [SSZipArchive createZipFileAtPath:path withFilesAtPaths:paths     ];
//}
////this method can auto cover the older one without notification and notify
//+ (BOOL)createZipFileAtPath:(NSString *)path withContentsOfDirectory:(NSString *)directoryPath{
//      return    [SSZipArchive  createZipFileAtPath:path withContentsOfDirectory:directoryPath    ];
//}
//
//+ (BOOL)createZipFileAtPath:(NSString *)path withContentsOfDirectory:(NSString *)directoryPath keepParentDirectory:(BOOL)keepParentDirectory{
//      return    [SSZipArchive    createZipFileAtPath:path withContentsOfDirectory:directoryPath keepParentDirectory:keepParentDirectory  ];
//}
//
//// with password, password could be nil
//+ (BOOL)createZipFileAtPath:(NSString *)path withFilesAtPaths:(NSArray *)paths withPassword:(nullable NSString *)password{
//      return    [SSZipArchive  createZipFileAtPath:path withFilesAtPaths:paths withPassword:password    ];
//}
//+ (BOOL)createZipFileAtPath:(NSString *)path withContentsOfDirectory:(NSString *)directoryPath withPassword:(nullable NSString *)password{
//      return    [SSZipArchive    createZipFileAtPath:path withContentsOfDirectory:directoryPath withPassword:password  ];
//}
//+ (BOOL)createZipFileAtPath:(NSString *)path withContentsOfDirectory:(NSString *)directoryPath keepParentDirectory:(BOOL)keepParentDirectory withPassword:(nullable NSString *)password{
//      return    [SSZipArchive    createZipFileAtPath:path withContentsOfDirectory:directoryPath keepParentDirectory:keepParentDirectory withPassword:password  ];
//}
//
//- (instancetype)initWithPath:(NSString *)path{
//    self = [super init];
//    if (self){
//        self.zipArchiveHelper =[[SSZipArchive alloc] initWithPath:path];;
//        
//    }
//    else{
//        self=nil;
//    }
//    return self;
//}
//
//- (BOOL)open {
//    return  [self.zipArchiveHelper open];
//}
//- (BOOL)writeFile:(NSString *)path withPassword:(nullable NSString *)password{
//      return    [self.zipArchiveHelper    writeFile:path withPassword:password  ];
//}
//- (BOOL)writeFolderAtPath:(NSString *)path withFolderName:(NSString *)folderName withPassword:(nullable NSString *)password{
//      return    [self.zipArchiveHelper     writeFolderAtPath:path withFolderName:folderName withPassword:password ];
//}
//- (BOOL)writeFileAtPath:(NSString *)path withFileName:(nullable NSString *)fileName withPassword:(nullable NSString *)password{
//      return    [self.zipArchiveHelper   writeFileAtPath:path withFileName:fileName withPassword:password   ];
//}
//- (BOOL)writeData:(NSData *)data filename:(nullable NSString *)filename withPassword:(nullable NSString *)password{
//      return    [self.zipArchiveHelper    writeData:data filename:filename withPassword:password  ];
//}
//- (BOOL) close{
//      return    [self.zipArchiveHelper   close   ];
//    
//}
//
//@end
