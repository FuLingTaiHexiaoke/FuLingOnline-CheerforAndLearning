//
//  FLXKCheckAppVersion.m
//  Psy-CommonFramework
//
//  Created by 肖科 on 17/1/3.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "FLXKCheckAppVersion.h"
#import "AppConfig.h"
#import "FLXKHttpRequest.h"
#import <UIKit/UIKit.h>
@interface FLXKCheckAppVersion()
@property(strong,nonatomic)NSString* updateUrl;
@property(weak,nonatomic)UIViewController* checkContainer;
@end

@implementation FLXKCheckAppVersion
/*{
 "school":"",
 "versionText":"您有一个新的版本",
 "androidUrl":"",
 "type":"",
 "iosUrl":"http://server.psylife.cc:9090/load/bailaohui/ios.html",
 "url":"http://server.psylife.cc:9090/load/bailaohui/ios.html",
 "isMust":"0",
 "version":"1.11"
 }
 */
-(void)checkAppUpdateWithContainer:(UIViewController*)checkContainer
{
//    if ( ![FLXKHttpRequest isReachable]) {
//        return;
//    }
    
    NSString *url = [NSString stringWithFormat:APP_Update_URL,APP_Update_HOST];
    self.checkContainer=checkContainer;
    [FLXKHttpRequest get:url success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *newVersion = [responseObject objectForKey:@"version"];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        if ([newVersion isKindOfClass:[NSString class]]) {
            if (![newVersion isEqualToString:appVersion]) {
                _updateUrl = [responseObject objectForKey:@"iosUrl"];
                NSLog(@"%@",_updateUrl);
                [self showAlertWithTitle:[responseObject objectForKey:@"versionText"]];
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error.description);
    }];
    
}

#pragma mark - 版本更新提示
- (void)showAlertWithTitle:(NSString *)title {
    if (iOS8Later) {
     UIAlertController*   alertControllerVersionCheck = [UIAlertController alertControllerWithTitle:@"系统提示" message:title preferredStyle:UIAlertControllerStyleAlert];
        [ alertControllerVersionCheck addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            
        }]];
        [alertControllerVersionCheck addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            NSLog(@"%@",_updateUrl);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_updateUrl]];
            
        }]];
        if (self.checkContainer) {
            [self.checkContainer presentViewController:alertControllerVersionCheck animated:YES completion:nil];
        }
    } else {
        __weak __typeof(self) weakSelf=self;
        UIAlertView*  alerViewVersionCheck= [[UIAlertView alloc] initWithTitle:@"系统提示" message:title delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alerViewVersionCheck show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        NSLog(@"%@",_updateUrl);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_updateUrl]];
    }
}
@end
