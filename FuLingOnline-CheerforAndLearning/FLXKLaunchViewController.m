//
//  FLXKLaunchViewController.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/10/12.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "FLXKLaunchViewController.h"
#import "FLXKHttpRequest.h"
@interface FLXKLaunchViewController ()
{

}
@property (weak, nonatomic) IBOutlet UIImageView *advImageView;
@property (weak, nonatomic) IBOutlet UIImageView *companyLogoView;
@end

@implementation FLXKLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载广告图片
    [self httpLoadImageWithImageName:@"" withImageView:self.advImageView];
    //加载公司logo
    [self httpLoadImageWithImageName:@"" withImageView:self.companyLogoView];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
////判断是否加载公告页
//+(void)loadAdvertisementImages{
//    
//}
//
////加载上部广告视图
//-(void)adImageView{
//    
//}

-(void)httpLoadImageWithImageName:(NSString*)imageName withImageView:(UIImageView*)imageContainerView{
//    NSString* urlString=[NSString stringWithFormat:@"",]
//    FLXKHttpRequest download:<#(NSString *)#> parameters:<#(NSDictionary *)#> savePathString:<#(NSString *)#> success:<#^(NSURLSessionDataTask *task, id responseObject)success#> success:<#^(NSURLSessionDataTask *task, NSError *error)failure#>
}
//请求广告图片
//+(void)loadAdvertisementImages{
//    
//}
//加载倒计时动画
//加载底部视图

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
