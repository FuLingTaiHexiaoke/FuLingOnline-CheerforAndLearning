//
//  FLXKHttpRequestModelHelper.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/12/14.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "FLXKHttpRequestModelHelper.h"
#import "FLXKHttpRequest.h"
#import "MJExtension.h"
#import "FLXKPathHelper.h"
#import "NSDate+Extensions.h"
#import "FLXKProgressHUD.h"

//models


@implementation FLXKHttpRequestModelHelper

+(FLXKHttpRequestModelHelper*)registerSuccessCallback:(successCallback)successCallback failureCallback:(failureCallback)failureCallback{
    FLXKHttpRequestModelHelper* strongSelf=[[FLXKHttpRequestModelHelper alloc]init];
    strongSelf.successCallback=successCallback;
    strongSelf.failureCallback=failureCallback;
    return strongSelf;
}

/**
 上传本地记录的数据文件
 */
- (void)uploadLocalFile{
    
    NSString* filePath = [FLXKPathHelper getFilePathWithNoCreate:LocalRecordFileName];
    
    if (![ [NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:nil]) {
        //        NSLog(@"文件不存在!");
        [FLXKProgressHUD showErrorWithTip:@"文件不存在，请登录。"];
        self.failureCallback(nil);
        return;
    }
    //    http://server1.psylife.cc:30012/yingyuandili/interface.html
    //    https://server1.psylife.cc:33012/yingyuandili/interface.html
    ///xuanbapcdpinfant/studentServlet?folder=&padName=pad&configId=1
    
    NSString* address= @"server1.psylife.cc";
    NSString* port= @"33012";
    NSString* iPad_Name= [[NSUserDefaults standardUserDefaults]stringForKey:@"iPad_Name"];
    
    NSString*   urlString = [NSString stringWithFormat: @"https://%@:%@/yingyuandili/studentServlet?folder=%@&padName=%@&configId=1",address,port,LocalRecordFileName,iPad_Name];

    [FLXKHttpRequest upload:urlString parameters:nil filePathString:filePath success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString* stateString=[responseObject objectForKey:@"state"];
        int state=[stateString intValue];
        switch (state) {
                //成功
            case 0:{
                //对当前文件备份，移除原有文件
                NSError* error;
                [[NSFileManager defaultManager]moveItemAtPath:filePath toPath:[FLXKPathHelper getFilePathWithNoCreate:[NSString stringWithFormat:@"数据记录_%@",[NSDate DateWithNormalFormat]]]  error:&error];
                if (error) {
                    [FLXKProgressHUD showErrorWithTip:@"文件上传成功，但本地数据备份失败!"];
                    NSLog(@"%@", error.description);
                }
                else{
                    
                }
                self.successCallback(responseObject);
                break;
            }
            case 1:
            {
                //                NSLog(@"上传文件时失败");
                [FLXKProgressHUD showErrorWithTip:@"文件上传失败!"];
                break;
            }
            case 2:
            {
                //                NSLog(@"入库时失败！");
                [FLXKProgressHUD showErrorWithTip:@"入库时失败！"];
                break;
            }
            default:
                break;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.failureCallback(error);
    }];
}


@end
