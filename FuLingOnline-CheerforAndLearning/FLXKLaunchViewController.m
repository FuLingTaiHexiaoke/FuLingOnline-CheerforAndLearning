//
//  FLXKLaunchViewController.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/10/12.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "FLXKLaunchViewController.h"
#import "FLXKHttpRequest.h"
#import "UIImageView+WebCache.h"
#import "FLXKAdImageInfoModel.h"
#import "config.h"
//#import "baseConfig.h"
@interface FLXKLaunchViewController ()
{

}
@property (weak, nonatomic) IBOutlet UIImageView *advImageView;
@property (weak, nonatomic) IBOutlet UIImageView *companyLogoView;
@property (strong, nonatomic)  NSArray *adImageInfoArray;
@property (strong, nonatomic)  FLXKAdImageInfoModel *adImageInfoModel;
@end

@implementation FLXKLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载广告图片
//    [self httpLoadImageWithImageName:@"" withImageView:self.advImageView];
    //加载公司logo
//    [self httpLo#import "UIImageView+WebCache.h"adImageWithImageName:@"" withImageView:self.companyLogoView];
    
    //1)get the image url from server
    [self getAdImageInfo];
    //加载广告图片
//    [self.advImageView sd_setImageWithURL:[NSURL URLWithString:_adImageInfoModel.imageUrl] placeholderImage:[UIImage imageNamed:@""]];
    //加载公司logo
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(FLXKLaunchViewController*)initialAppViewControllerFromDefaultStoryBoard{
      return [[UIStoryboard storyboardWithName:NSStringFromClass([FLXKLaunchViewController class]) bundle:nil] instantiateInitialViewController];
}

- (void)launchAppInWindow:(UIWindow*)window {
//    WMFStyleManager* manager = [WMFStyleManager new];
//    [manager applyStyleToWindow:window];
//    [WMFStyleManager setSharedStyleManager:manager];
    
    [window setRootViewController:self];
    [window makeKeyAndVisible];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForegroundWithNotification:) name:UIApplicationWillEnterForegroundNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackgroundWithNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
//    [self showSplashView];
    
//    @weakify(self)
//    
//    [self.savedArticlesFetcher fetchAndObserveSavedPageList];
//    if ([[NSProcessInfo processInfo] wmf_isOperatingSystemMajorVersionAtLeast:9]) {
//        self.spotlightManager = [[WMFSavedPageSpotlightManager alloc] initWithDataStore:self.session.dataStore];
//    }
//    [self presentOnboardingIfNeededWithCompletion:^(BOOL didShowOnboarding) {
//        @strongify(self)
//        [self loadMainUI];
//        [self hideSplashViewAnimated:!didShowOnboarding];
//        [self resumeApp];
//        [[PiwikTracker wmf_configuredInstance] wmf_logView:[self rootViewControllerForTab:WMFAppTabTypeExplore]];
//    }];
}

-(void)getAdImageInfo{
//    http://127.0.0.1:3000/api/getAdimg
    
    [FLXKHttpRequest get:[NSString stringWithFormat:@"%@/api/getAdimg",BaseURL] success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray* dicArray=(NSArray*)responseObject;
        if (dicArray.count>0) {
            NSDictionary* dic=(NSDictionary*)[dicArray lastObject];
            FLXKAdImageInfoModel* adImageInfoModel=[[FLXKAdImageInfoModel alloc]init];
            [adImageInfoModel setValuesForKeysWithDictionary:dic];
            self.adImageInfoModel=adImageInfoModel;
            [self.advImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",BaseURL,_adImageInfoModel.imgUrl]] placeholderImage:[UIImage imageNamed:@""]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        FLXKLog(@"%@",error.description);
    }];
}

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
