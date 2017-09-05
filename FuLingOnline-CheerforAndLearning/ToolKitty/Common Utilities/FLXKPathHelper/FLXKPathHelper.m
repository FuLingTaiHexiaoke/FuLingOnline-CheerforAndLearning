//
//  FLXKPathHelper.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/24.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKPathHelper.h"

#define isEmptyString(x)      (isNull(x) || [x isEqual:@""] || [x isEqual:@"(null)"])
#define isNotEmptyString(x)     ( !(isNull(x) || [x isEqual:@""] || [x isEqual:@"(null)"]))
#define DefaultImageDocumentInSandbox @"media"
#define DefaultPDFDocumentInSandbox @"PDF"
#define DefaultMovieDocumentInSandbox @"Movie"
#define DefaultMP3DocumentInSandbox @"MP3"
#define DefaultTxtDocumentInSandbox @"Txt"
#define DefaultMediaDocumentInSandbox @"Media"//资源总文件
/**
 An array of NSNumber objects, shows the best order for path scale search.
 e.g. iPhone3GS:@[@1,@2,@3] iPhone5:@[@2,@3,@1]  iPhone6 Plus:@[@3,@2,@1]
 */
static NSArray *_NSBundlePreferredScales() {
    static NSArray *scales;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat screenScale = [UIScreen mainScreen].scale;
        if (screenScale <= 1) {
            scales = @[@1,@2,@3];
        } else if (screenScale <= 2) {
            scales = @[@2,@3,@1];
        } else {
            scales = @[@3,@2,@1];
        }
    });
    return scales;
}

/**
 Add scale modifier to the file name (without path extension),
 From @"name" to @"name@2x".
 
 e.g.
 <table>
 <tr><th>Before     </th><th>After(scale:2)</th></tr>
 <tr><td>"icon"     </td><td>"icon@2x"     </td></tr>
 <tr><td>"icon "    </td><td>"icon @2x"    </td></tr>
 <tr><td>"icon.top" </td><td>"icon.top@2x" </td></tr>
 <tr><td>"/p/name"  </td><td>"/p/name@2x"  </td></tr>
 <tr><td>"/path/"   </td><td>"/path/"      </td></tr>
 </table>
 
 @param scale Resource scale.
 @return String by add scale modifier, or just return if it's not end with file name.
 */
static NSString *_NSStringByAppendingNameScale(NSString *string, CGFloat scale) {
    if (!string) return nil;
    if (fabs(scale - 1) <= __FLT_EPSILON__ || string.length == 0 || [string hasSuffix:@"/"]) return string.copy;
    return [string stringByAppendingFormat:@"@%@x", @(scale)];
}


///**
// Return the path scale.
//
// e.g.
// <table>
// <tr><th>Path            </th><th>Scale </th></tr>
// <tr><td>"icon.png"      </td><td>1     </td></tr>
// <tr><td>"icon@2x.png"   </td><td>2     </td></tr>
// <tr><td>"icon@2.5x.png" </td><td>2.5   </td></tr>
// <tr><td>"icon@2x"       </td><td>1     </td></tr>
// <tr><td>"icon@2x..png"  </td><td>1     </td></tr>
// <tr><td>"icon@2x.png/"  </td><td>1     </td></tr>
// </table>
// */
//static CGFloat _NSStringPathScale(NSString *string) {
//    if (string.length == 0 || [string hasSuffix:@"/"]) return 1;
//    NSString *name = string.stringByDeletingPathExtension;
//    __block CGFloat scale = 1;
//
//    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:@"@[0-9]+\\.?[0-9]*x$" options:NSRegularExpressionAnchorsMatchLines error:nil];
//    [pattern enumerateMatchesInString:name options:kNilOptions range:NSMakeRange(0, name.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
//        if (result.range.location >= 3) {
//            scale = [string substringWithRange:NSMakeRange(result.range.location + 1, result.range.length - 2)].doubleValue;
//        }
//    }];
//
//    return scale;
//}


@interface  NSString (StandardPaths)



/*
 @abstract 检查文件相对路径中是否含有文件类型后缀。没有返回nil
 @param ext:文件类型
 */
- (NSString *)checkPathExtensionWithType:(NSString* )ext;

@end

@implementation FLXKPathHelper

+ (NSArray *)preferredScales {
    static NSArray *scales;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat screenScale = [UIScreen mainScreen].scale;
        if (screenScale <= 1) {
            scales = @[@1,@2,@3];
        } else if (screenScale <= 2) {
            scales = @[@2,@3,@1];
        } else {
            scales = @[@3,@2,@1];
        }
    });
    return scales;
}

/**
 @abstract 单例返回当前沙盒根目录路径
 @return 当前沙盒根目录路径
 */
+ (NSString *)DocumentDirectory
{
    static NSString *path;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //user documents folder
        path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        
    });
    
    return path;
}

/**
 @abstract 只返回沙盒文件需要的路径，用于移动文件
 @return 当前沙盒根目录路径
 */
+ (NSString *)getFilePathWithNoCreate:(NSString *)filePath
{
    if (!filePath.pathExtension) {
        NSAssert(filePath.pathExtension, @"文件没有后缀！");
    }
    NSFileManager* fileManager  = [NSFileManager defaultManager];
    NSString* pathToCreate=@"";
    NSString* checkingPath=[[FLXKPathHelper DocumentDirectory] stringByAppendingPathComponent:filePath];
    
    BOOL isDirectory=NO;
    BOOL isExist = [fileManager fileExistsAtPath:checkingPath isDirectory:&isDirectory];
    //if it is a Directory
    if (isDirectory && isExist) {
        [fileManager removeItemAtPath:checkingPath error:nil];
    }
    if (!isExist || (isDirectory && isExist)) {
        // first to create the Directory
        NSArray<NSString*> *pathComponents=[filePath componentsSeparatedByString:@"/"];
        NSString*  directoryPath = [self checkOrCreateDirectory:filePath];
        pathToCreate = [directoryPath stringByAppendingPathComponent:[pathComponents lastObject]];
        NSLog(@"文件路径获取成功！路径：%@",pathToCreate);
        
        //then create file
        //        BOOL res= [fileManager createFileAtPath:pathToCreate contents:nil attributes:nil];
        //        if (res) {
        //          NSLog(@"文件创建成功！路径：%@",pathToCreate);
        //        }else{
        //            NSAssert(res, @"文件创建失败！");
        //            return nil;
        //        }
    }
    else{
        pathToCreate=checkingPath;
    }
    return pathToCreate;
}

/**
 @abstract 检查沙盒默认路径中是否存在图片资源
 @param name 资源文件名称（文件名称中不能包含路径，只能是图片的名称）
 @return 符合名称的图片对象
 */
+ (UIImage *)imageNamed:(NSString *)name{
    return  [self imageNamed:name inDirectory:DefaultImageDocumentInSandbox];
}

/**
 @abstract 检查（documents和mainBundle）路径中是否存在图片资源，有则实例化一个
 @param name 资源文件名称（文件名称中不能包含路径，只能是图片的名称）
 @param subpath 子路径
 @return 符合名称的图片对象
 */
+ (UIImage *)imageNamed:(NSString *)name inDirectory:(NSString *)subpath {
    if (name.length == 0) return nil;
    if ([name hasPrefix:@"/"]) return nil;
    if ([name hasSuffix:@"/"]) return nil;
    
    NSString *res = name.stringByDeletingPathExtension;
    NSString *ext = name.pathExtension;
    NSString *path = nil;
    CGFloat scale = 1;
    
    // If no extension, guess by system supported (same as UIImage).
    //    NSArray *exts = ext.length > 0 ? @[ext] : @[@"", @"png", @"jpeg", @"jpg", @"gif", @"webp", @"apng",@"PNG",@"JPG"];
    //    NSArray *exts = ext.length > 0 ? @[ext] : @[@"png", @"jpeg", @"jpg", @"gif", @"webp", @"apng",@"PNG",@"JPG"];
    NSArray *exts = ext.length > 0 ? @[ext] : @[@"png",@"jpg", @"gif",@"PNG",@"JPG"];
    NSArray *scales = _NSBundlePreferredScales();
    for (int s = 0; s < scales.count; s++) {
        scale = ((NSNumber *)scales[s]).floatValue;
        NSString *scaledName = _NSStringByAppendingNameScale(res, scale);
        for (NSString *e in exts) {
            path = [self pathForResource:scaledName resourceType:e inDirectory:subpath];
            if (path) break;
        }
        if (path) break;
    }
    
    if (path.length == 0){
        UIImage* image = [UIImage imageNamed:res];
        if (!image) {
            image = [UIImage imageNamed:@"defaultImage"];
        }
        return image;
    }
    else{
        NSData *data = [NSData dataWithContentsOfFile:path];
        return  [[UIImage alloc] initWithData:data scale:scale];
    }
}

/**
 @abstract 便捷方法，预先检查沙盒默认路径中是否存在资源
 @param fileName 资源文件名称
 @return 符合资源文件名称的完整路径
 */
+(NSString*)mediaPathWithName:(NSString *)fileName
{
    return [FLXKPathHelper PDFPathWithName:fileName inDirectory:DefaultMediaDocumentInSandbox];
}

/**
 @abstract 先检查沙盒默认路径中是否存在资源，然后检查程序安装包中是否有此资源文件
 @param fileName 资源文件名称
 @param subpath 子路径
 @return 符合资源文件名称的完整路径
 */
+(NSString*)mediaPathWithName:(NSString *)fileName inDirectory:(NSString *)subpath
{
    return [self pathForResource:fileName resourceType:nil inDirectory:subpath];
}


/**
 @abstract 便捷方法，预先检查沙盒默认路径中是否存在资源
 @param fileName 资源文件名称
 @return 符合资源文件名称的完整路径
 */
+(NSString*)PDFPathWithName:(NSString *)fileName
{
    return [FLXKPathHelper PDFPathWithName:fileName inDirectory:DefaultPDFDocumentInSandbox];
}

/**
 @abstract 先检查沙盒默认路径中是否存在资源，然后检查程序安装包中是否有此资源文件
 @param fileName 资源文件名称
 @param subpath 子路径
 @return 符合资源文件名称的完整路径
 */
+(NSString*)PDFPathWithName:(NSString *)fileName inDirectory:(NSString *)subpath
{
    return [self pathForResource:fileName resourceType:@"pdf" inDirectory:subpath]?:[self pathForResource:@"defaultPDF.pdf" resourceType:@"pdf" inDirectory:nil];
}

/**
 @abstract 便捷方法，预先添加默认文件后缀名称，先检查（documents和mainBundle）路径中是否存在资源
 @param fileName 资源文件名称
 @return 符合资源文件名称的完整路径
 */
+(NSString *)audioPathWithName:(NSString*)fileName
{
    return [FLXKPathHelper audioPathWithName:fileName inDirectory:DefaultMP3DocumentInSandbox];
}

/**
 @abstract 先检查沙盒默认路径中是否存在资源，然后检查程序安装包中是否有此资源文件
 @param fileName 资源文件名称
 @param subpath 子路径
 @return 符合资源文件名称的完整路径
 */
+(NSString*)audioPathWithName:(NSString *)fileName inDirectory:(NSString *)subpath
{
    return [self pathForResource:fileName resourceType:@"mp3" inDirectory:subpath]?:[self pathForResource:@"defaultMP3.mp3" resourceType:@"mp3" inDirectory:nil];
}

/**
 @abstract 便捷方法，预先添加默认文件后缀名称，先检查（documents和mainBundle）路径中是否存在资源
 @param fileName 资源文件名称
 @return 符合资源文件名称的完整路径
 */
+(NSString *)moviePathWithName:(NSString*)fileName
{
    return [FLXKPathHelper moviePathWithName:fileName inDirectory:DefaultMovieDocumentInSandbox];
}

/**
 @abstract 先检查沙盒默认路径中是否存在资源，然后检查程序安装包中是否有此资源文件
 @param fileName 资源文件名称
 @param subpath 子路径
 @return 符合资源文件名称的完整路径
 */
+(NSString*)moviePathWithName:(NSString *)fileName inDirectory:(NSString *)subpath
{
    return [self pathForResource:fileName resourceType:@"mp4" inDirectory:subpath]?:[self pathForResource:@"defaultMovie.mp4" resourceType:@"mp4" inDirectory:nil];
}

/**
 @abstract 检查资源文件是否存在，存在则返回完整沙盒路径（包括documents和mainBundle）
 @param name 资源文件名称
 @param ext 文件类型
 @return 完整沙盒路径
 */
+( NSString *)pathForResource:( NSString *)name resourceType:( NSString *)ext
{
    return [self pathForResource:name resourceType:ext inDirectory:nil];
}

/**
 @abstract 检查资源文件是否存在，存在则返回完整沙盒路径（包括documents和mainBundle）
 @param name 资源文件名称
 @param ext 文件类型
 @param subpath 子路径
 @return 完整沙盒路径
 */
+( NSString *)pathForResource:( NSString *)name resourceType:( NSString *)ext inDirectory:( NSString *)subpath
{
    if (name.length == 0) return nil;
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString* searchingPath;
    searchingPath= [name checkPathExtensionWithType:ext];
    if (isEmptyString(searchingPath.pathExtension)) {
        return nil;
    }
    if (isNotEmptyString(subpath)) {
        searchingPath=[subpath stringByAppendingPathComponent:searchingPath];
    }
    //检查程序沙盒中是否存在此文件
    searchingPath = [[FLXKPathHelper DocumentDirectory] stringByAppendingPathComponent:searchingPath];
    BOOL isExistInSandbox = [fileManager fileExistsAtPath:searchingPath];
    if(!isExistInSandbox)
    {
        NSString*  bundlePath;
        NSArray * pathComponentArray = [searchingPath componentsSeparatedByString:@"/"];
        NSString*  fileName= [pathComponentArray lastObject];
        
        //检查安装包是否存在此文件
        bundlePath= [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
        BOOL isFileExistInBundleResourcePath = [fileManager fileExistsAtPath:bundlePath];
        if(!isFileExistInBundleResourcePath)
        {
            bundlePath = nil;
        }
        searchingPath=bundlePath;
    }
    return searchingPath;
}


/**
 @abstract 首先验证文件是否已经存在，不存在则创建一个新的文件。
 @param filePath 资源文件相对路径，例如：Path/test.txt
 @return 符合名要求的完整资源文件路径
 */
+(NSString*)checkOrCreateFile:(NSString*)filePath{
    if (!filePath.pathExtension) {
        NSAssert(filePath.pathExtension, @"文件没有后缀！");
    }
    NSFileManager* fileManager  = [NSFileManager defaultManager];
    __block NSString* pathToCreate=@"";
    NSString* checkingPath=[[FLXKPathHelper DocumentDirectory] stringByAppendingPathComponent:filePath];
    
    BOOL isDirectory=NO;
    BOOL isExist = [fileManager fileExistsAtPath:checkingPath isDirectory:&isDirectory];
    //if it is a Directory
    if (isDirectory && isExist) {
        [fileManager removeItemAtPath:checkingPath error:nil];
    }
    if (!isExist || (isDirectory && isExist)) {
        // first to create the Directory
        NSArray<NSString*> *pathComponents=[filePath componentsSeparatedByString:@"/"];
        NSString*  directoryPath = [self checkOrCreateDirectory:filePath];
        pathToCreate = [directoryPath stringByAppendingPathComponent:[pathComponents lastObject]];
        //then create file
        BOOL res= [fileManager createFileAtPath:pathToCreate contents:nil attributes:nil];
        if (res) {
            NSLog(@"文件创建成功！路径：%@",pathToCreate);
        }else{
            NSAssert(res, @"文件创建失败！");
            return nil;
        }
    }
    else{
        pathToCreate=checkingPath;
    }
    return pathToCreate;
}

/**
 @abstract  首先验证路径是否已经存在，不存在则创建一个新的路径。
 @param directoryPath 路径名称（可包含文件名称）(例如：text1/test2/flxkdb.txt 或者 text1/test2  或者 flxkdb.txt)
 @return 符合名要求的完整路径
 */
+(NSString*)checkOrCreateDirectory:(NSString*)directoryPath{
    NSString* pathToCreate;
    NSString* pathExtension=directoryPath.pathExtension;
    NSMutableArray<NSString*> *directoryComponents=[NSMutableArray arrayWithArray:[directoryPath componentsSeparatedByString:@"/"]] ;
    
    //去除掉文件名称(flxkdb.txt )
    if (pathExtension && directoryComponents.count<2 ) {
        return [FLXKPathHelper DocumentDirectory];
    }
    //目录+文件名称(test2/flxkdb.txt)
    else if (pathExtension && directoryComponents.count>1 ){
        [directoryComponents removeLastObject];
    }
    //只有目录(test2/...)
    else{
        
    }
    
    NSFileManager* fileManager  = [NSFileManager defaultManager];
    pathToCreate=[[FLXKPathHelper DocumentDirectory] stringByAppendingPathComponent:[directoryComponents componentsJoinedByString:@"/"]];
    
    //如何已经存在当前目录，则直接返回当前目录路径。
    BOOL isDirectory=NO;
    BOOL isExist = [fileManager fileExistsAtPath:pathToCreate isDirectory:&isDirectory];
    //已经存在
    if (isDirectory && isExist) {
    }
    //不存在，则马上创建一个新目录
    else{
        BOOL result= [fileManager createDirectoryAtPath:pathToCreate withIntermediateDirectories:YES attributes:nil error:nil];
        if (result) {
            
        }else{
            return nil;
        }
    }
    return pathToCreate;
}


/**
 @abstract  记录NSString到本地文件
 @param data NSString类型字符串
 @param fileName txt文件名称
 @return 返回是否成功记录数据
 */
+(BOOL)recordData:(NSString *)data fileName:(NSString *)fileName{
    BOOL success=YES;
    NSString* filePath=  [self checkOrCreateFile:fileName];
    if (!filePath) {
        return NO;
    }
    NSFileHandle* fileHandler=[NSFileHandle fileHandleForWritingAtPath:filePath];
    if (!fileHandler) {
        return NO;
    }
    [fileHandler seekToEndOfFile];
    [fileHandler writeData:[data dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandler closeFile];
    
    return success;
}
@end




@implementation NSString (StandardPaths)

/*
 @abstract 检查文件相对路径中是否含有文件类型后缀。没有返回nil
 @param ext:文件类型
 */
- (NSString *)checkPathExtensionWithType:(NSString* )ext
{
    NSString *extension = self.pathExtension;
    if (isNotEmptyString(extension))
    {
        return self;
    }
    if(ext){
        return  [self stringByAppendingPathExtension:ext];
    }
    return nil;
}


@end
