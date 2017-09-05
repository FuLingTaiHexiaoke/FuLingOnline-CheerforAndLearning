//
//  FLXKPathHelper.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/24.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLXKPathHelper : NSObject

/**
 @abstract 单例返回当前沙盒根目录路径
 @return 当前沙盒根目录路径
 */
+(NSString *)DocumentDirectory;

/**
 @abstract 只返回沙盒文件需要的路径，用于移动文件
 @return 当前沙盒根目录路径
 */
+ (NSString *)getFilePath:(NSString *)filePath;

/**
 @abstract 检查沙盒默认路径中是否存在图片资源
 @param name 资源文件名称（文件名称中不能包含路径，只能是图片的名称）
 @return 符合名称的图片对象
 */
+ (UIImage *)imageNamed:(NSString *)name;
/**
 @abstract 检查（documents和mainBundle）路径中是否存在图片资源，有则实例化一个
 @param name 资源文件名称（文件名称中不能包含路径，只能是图片的名称）
 @param subpath 子路径
 @return 符合名称的图片对象
 */
+ (UIImage *)imageNamed:(NSString *)name inDirectory:(NSString *)subpath;


/**
 @abstract 便捷方法，预先检查沙盒默认路径中是否存在资源
 @param fileName 资源文件名称
 @return 符合资源文件名称的完整路径
 */
+(NSString*)mediaPathWithName:(NSString *)fileName;

/**
 @abstract 先检查沙盒默认路径中是否存在资源，然后检查程序安装包中是否有此资源文件
 @param fileName 资源文件名称
 @param subpath 子路径
 @return 符合资源文件名称的完整路径
 */
+(NSString*)mediaPathWithName:(NSString *)fileName inDirectory:(NSString *)subpath;


/**
 @abstract 便捷方法，预先检查沙盒默认路径中是否存在资源
 @param fileName 资源文件名称
 @return 符合资源文件名称的完整路径
 */
+(NSString*)PDFPathWithName:(NSString *)fileName;
/**
 @abstract 先检查沙盒默认路径中是否存在资源，然后检查程序安装包中是否有此资源文件
 @param fileName 资源文件名称
 @param subpath 子路径
 @return 符合资源文件名称的完整路径
 */
+(NSString*)PDFPathWithName:(NSString *)fileName inDirectory:(NSString *)subpath;

/**
 @abstract 便捷方法，预先添加默认文件后缀名称，先检查（documents和mainBundle）路径中是否存在资源
 @param fileName 资源文件名称
 @return 符合资源文件名称的完整路径
 */
+(NSString *)audioPathWithName:(NSString*)fileName;

/**
 @abstract 先检查沙盒默认路径中是否存在资源，然后检查程序安装包中是否有此资源文件
 @param fileName 资源文件名称
 @param subpath 子路径
 @return 符合资源文件名称的完整路径
 */
+(NSString*)audioPathWithName:(NSString *)fileName inDirectory:(NSString *)subpath;

/**
 @abstract 便捷方法，预先添加默认文件后缀名称，先检查（documents和mainBundle）路径中是否存在资源
 @param fileName 资源文件名称
 @return 符合资源文件名称的完整路径
 */
+(NSString *)moviePathWithName:(NSString*)fileName;

/**
 @abstract 先检查沙盒默认路径中是否存在资源，然后检查程序安装包中是否有此资源文件
 @param fileName 资源文件名称
 @param subpath 子路径
 @return 符合资源文件名称的完整路径
 */
+(NSString*)moviePathWithName:(NSString *)fileName inDirectory:(NSString *)subpath;

/**
 @abstract 检查资源文件是否存在，存在则返回完整沙盒路径（包括documents和mainBundle）
 @param name 资源文件名称
 @param resourceType 文件类型
 @return 完整沙盒路径
 */
+(NSString *)pathForResource:( NSString *)name resourceType:( NSString *)resourceType;

/**
 @abstract 检查资源文件是否存在，存在则返回完整沙盒路径（包括documents和mainBundle）
 @param name 资源文件名称
 @param ext 文件类型
 @param subpath 子路径
 @return 完整沙盒路径
 */
+( NSString *)pathForResource:( NSString *)name resourceType:( NSString *)ext inDirectory:( NSString *)subpath;

/**
 @abstract 首先验证文件是否已经存在，不存在则创建一个新的文件。
 @param filePath 资源文件相对路径，例如：Path/test.txt
 @return 符合名要求的完整资源文件路径
 */
+(NSString*)checkOrCreateFile:(NSString*)filePath;

/**
 @abstract  首先验证路径是否已经存在，不存在则创建一个新的路径。
 @param directoryPath 路径名称
 @return 符合名要求的完整路径
 */
+(NSString*)checkOrCreateDirectory:(NSString*)directoryPath;

/**
 @abstract  记录NSString到本地文件
 @param data NSString类型字符串
 @param fileName txt文件名称
 @return 返回是否成功记录数据
 */
+(BOOL)recordData:(NSString *)data fileName:(NSString *)fileName;
@end
