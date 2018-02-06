////
////  PsyZipArchive.h
////  Psy-TeachersTerminal
////
////  Created by 123 on 16/8/2.
////  Copyright © 2016年 apple. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//#import "SSZipArchive.h"
//@protocol PsyZipArchiveDelegate <NSObject>
//
//@optional
////
////- (void)zipArchiveWillUnzipArchiveAtPath:(NSString * _Nullable)path zipInfo:(unz_global_info)zipInfo;
////- (void)zipArchiveDidUnzipArchiveAtPath:(NSString * _Nullable)path zipInfo:(unz_global_info)zipInfo unzippedPath:(NSString * _Nullable)unzippedPath;
////
////- (BOOL)zipArchiveShouldUnzipFileAtIndex:(NSInteger)fileIndex totalFiles:(NSInteger)totalFiles archivePath:(NSString * _Nullable)archivePath fileInfo:(unz_file_info)fileInfo;
////- (void)zipArchiveWillUnzipFileAtIndex:(NSInteger)fileIndex totalFiles:(NSInteger)totalFiles archivePath:(NSString * _Nullable)archivePath fileInfo:(unz_file_info)fileInfo;
////- (void)zipArchiveDidUnzipFileAtIndex:(NSInteger)fileIndex totalFiles:(NSInteger)totalFiles archivePath:(NSString * _Nullable)archivePath fileInfo:(unz_file_info)fileInfo;
////- (void)zipArchiveDidUnzipFileAtIndex:(NSInteger)fileIndex totalFiles:(NSInteger)totalFiles archivePath:(NSString * _Nullable)archivePath unzippedFilePath:(NSString * _Nullable)unzippedFilePath;
////
////- (void)zipArchiveProgressEvent:(unsigned long long)loaded total:(unsigned long long)total;
////- (void)zipArchiveDidUnzipArchiveFile:(NSString * _Nullable)zipFile entryPath:(NSString * _Nullable)entryPath destPath:(NSString * _Nullable)destPath;
//
//@end
//
//
//
//@interface PsyZipArchive : NSObject
//
//@property(nonatomic,nullable)SSZipArchive* zipArchiveHelper;
//
//// Password check
//+ (BOOL)isFilePasswordProtectedAtPath:(NSString * _Nullable)path;
//
//// Unzip
//+ (BOOL)unzipFileAtPath:(NSString * _Nullable)path toDestination:(NSString * _Nullable)destination;
//+ (BOOL)unzipFileAtPath:(NSString * _Nullable)path toDestination:(NSString * _Nullable)destination delegate:(nullable id<SSZipArchiveDelegate>)delegate;
//
//+ (BOOL)unzipFileAtPath:(NSString *  _Nonnull)path toDestination:(NSString *  _Nonnull)destination overwrite:(BOOL)overwrite password:(nullable NSString * )password error:(NSError * _Nullable  * _Nullable)error;
//
//
//+ (BOOL)unzipFileAtPath:(NSString *  _Nonnull)path
//          toDestination:(NSString *  _Nonnull)destination
//     preserveAttributes:(BOOL)preserveAttributes
//              overwrite:(BOOL)overwrite
//               password:(nullable NSString * )password
//                  error:(NSError * _Nullable  * _Nullable )error
//               delegate:(nullable id<SSZipArchiveDelegate>)delegate;
//
//+ (BOOL)unzipFileAtPath:(NSString *  _Nonnull)path
//          toDestination:(NSString *  _Nonnull)destination
//        progressHandler:(void (^ _Nullable)(NSString * _Nullable entry, unz_file_info zipInfo, long entryNumber, long total))progressHandler
//      completionHandler:(void (^ _Nullable)(NSString * _Nullable path, BOOL succeeded, NSError * _Nullable error))completionHandler;
//
//+ (BOOL)unzipFileAtPath:(NSString * _Nullable)path
//          toDestination:(NSString * _Nullable)destination
//              overwrite:(BOOL)overwrite
//               password:(nullable NSString * )password
//        progressHandler:(void (^ _Nullable)(NSString * _Nullable entry, unz_file_info zipInfo, long entryNumber, long total))progressHandler
//      completionHandler:(void (^ _Nullable)(NSString * _Nullable path, BOOL succeeded, NSError * _Nullable error))completionHandler;
//
//// Zip
//
////those methods can auto cover the older one without notification and notify
//
//// without password
//+ (BOOL)createZipFileAtPath:(NSString * _Nullable)path withFilesAtPaths:(NSArray * _Nonnull)paths;
//+ (BOOL)createZipFileAtPath:(NSString * _Nullable)path withContentsOfDirectory:(NSString * _Nonnull)directoryPath;
//
//+ (BOOL)createZipFileAtPath:(NSString * _Nullable)path withContentsOfDirectory:(NSString * _Nonnull)directoryPath keepParentDirectory:(BOOL)keepParentDirectory;
//
//// with password, password could be nil
//+ (BOOL)createZipFileAtPath:(NSString * _Nullable)path withFilesAtPaths:(NSArray * _Nonnull)paths withPassword:(nullable NSString * )password;
//+ (BOOL)createZipFileAtPath:(NSString * _Nullable)path withContentsOfDirectory:(NSString * _Nullable)directoryPath withPassword:(nullable NSString * )password;
//+ (BOOL)createZipFileAtPath:(NSString * _Nullable)path withContentsOfDirectory:(NSString * _Nullable)directoryPath keepParentDirectory:(BOOL)keepParentDirectory withPassword:( NSString * _Nullable)password;
//
//- (instancetype _Nullable)initWithPath:(NSString * _Nonnull)path;
//@property (NS_NONATOMIC_IOSONLY, readonly) BOOL open;
//- (BOOL)writeFile:(NSString * _Nullable)path withPassword:(NSString * _Nullable)password;
//- (BOOL)writeFolderAtPath:(NSString * _Nullable)path withFolderName:(NSString * _Nullable)folderName withPassword:(nullable NSString * )password;
//- (BOOL)writeFileAtPath:(NSString * _Nullable)path withFileName:(nullable NSString * )fileName withPassword:( NSString * _Nullable)password;
//- (BOOL)writeData:(NSData * _Nullable)data filename:(nullable NSString * )filename withPassword:( NSString * _Nullable)password;
//@property (NS_NONATOMIC_IOSONLY, readonly) BOOL close;
//
//@end
//
//
