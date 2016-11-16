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
#import "AppConfig.h"
//#import "Global.h"
#import "CALayer+FLXKAddition.h"

//#import <libextobjc/EXTScope.h>

//dignostic
#import <Tweaks/FBTweakInline.h>
#import "FBTweakViewController.h"

//Utilities
#import "UIView+Extensions.h"

@interface FLXKLaunchViewController () <FBTweakObserver, FBTweakViewControllerDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *advImageView;
@property (weak, nonatomic) IBOutlet UIImageView *companyLogoView;
@property (strong, nonatomic)  NSArray *adImageInfoArray;
@property (strong, nonatomic)  FLXKAdImageInfoModel *adImageInfoModel;
@end

@implementation FLXKLaunchViewController

#pragma mark - ViewController LifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];
    //get the image url from server
    [self getAdImageInfo];

    //加载公司logo
    _companyLogoView.backgroundColor=RGB(54,196,126);
    
    //add click timing animation
    UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.right-50, 20, 30, 30)];
    [btn setTitle:@"跳过" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont  systemFontOfSize:10];
    [_advImageView addSubview:btn];
    [[CAShapeLayer layer]createClockTickCircleAminationLayerWithFrame:btn.bounds inView:btn duration:FBTweakValue(@"Animation", @"LaunchViewController",  @"Duration", 5.0) animationDidStopBlock:^{
        NSLog(@"animation did stop!");
    }];
    
    @weakify(self)
    [[CAShapeLayer layer]createFuLingMemoryAminationLayerWithFrame:CGRectMake(0, 0, self.view.width, _companyLogoView.height) inView:_companyLogoView duration:FBTweakValue(@"Animation", @"LaunchViewController",  @"F_Duration", 10.0) animationDidStopBlock:^{
        NSLog(@"animation did stop!");
        @strongify(self)
      [[CAShapeLayer layer]  createFlowingWaterAminationLayerWithFrame:CGRectMake(0, 0, self.view.width, _companyLogoView.height) inView:_companyLogoView duration:20.0 animationDidStopBlock:^{
          
      }];
    }];

   
    UIButton* _tweaksButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, self.view.width-50, 20)];
    [_tweaksButton setTitle:@"Show Tweaks" forState:UIControlStateNormal];
    [_tweaksButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_tweaksButton addTarget:self action:@selector(showTweaksView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_tweaksButton];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public Methods

+(FLXKLaunchViewController*)initialAppViewControllerFromDefaultStoryBoard{
    return [[UIStoryboard storyboardWithName:NSStringFromClass([FLXKLaunchViewController class]) bundle:nil] instantiateInitialViewController];
}

- (void)launchAppInWindow:(UIWindow*)window {
    //    WMFStyleManager* manager = [WMFStyleManager new];
    //    [manager applyStyleToWindow:window];
    //    [WMFStyleManager setSharedStyleManager:manager];
    [self loadAppSettingFromBundle];
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

#pragma mark - Private Methods

//1)get the image url from server
-(void)getAdImageInfo{
    //    http://127.0.0.1:3000/api/getAdimg
    @weakify(self);
    [FLXKHttpRequest get:BaseURL(@"api/getAdimg") success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray* dicArray=(NSArray*)responseObject;
        if (dicArray.count>0) {
            NSDictionary* dic=(NSDictionary*)[dicArray lastObject];
            FLXKAdImageInfoModel* adImageInfoModel=[[FLXKAdImageInfoModel alloc]init];
            [adImageInfoModel setValuesForKeysWithDictionary:dic];
            @strongify(self);
            self.adImageInfoModel=adImageInfoModel;
            [self.advImageView sd_setImageWithURL:[NSURL URLWithString:BaseURL(_adImageInfoModel.imgUrl)] placeholderImage:[UIImage imageNamed:@""]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        FLXKLog(@"%@",error.description);
    }];
    
}

#pragma mark - Register AppSetting
//注册app动态参数
-(void)loadAppSettingFromBundle{
    NSString* settingBundlePath=[[NSBundle mainBundle]pathForResource:@"Settings" ofType:@"bundle"];
    NSString* rootPlistPath=nil;
    if (DEBUG) {
        rootPlistPath=[settingBundlePath stringByAppendingPathComponent:@"Root.plist"];
    }
    else{
        rootPlistPath=[settingBundlePath stringByAppendingPathComponent:@"Root.plist"];
    }
    if ([[NSFileManager defaultManager]fileExistsAtPath:rootPlistPath]) {
        NSDictionary* settingDic=[NSDictionary dictionaryWithContentsOfFile:rootPlistPath];
        NSArray* settingArray=[settingDic objectForKey:@"PreferenceSpecifiers"];
        NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[settingArray count]];
        for(NSDictionary *prefSpecification in settingArray){
            NSString *key = [prefSpecification objectForKey:@"Key"];
            if(key){
                [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
            }
        }
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark - Delegates


#pragma mark - FBTweakViewController And Delegate

- (void)showTweaksView
{
    FBTweakViewController *viewController = [[FBTweakViewController alloc] initWithStore:[FBTweakStore sharedInstance]];
    viewController.tweaksDelegate = self;
    [self presentViewController:viewController animated:YES completion:NULL];
}

-(void)tweakViewControllerPressedDone:(FBTweakViewController *)tweakViewController
{
    [tweakViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)tweakDidChange:(FBTweak *)tweak
{
//    if (tweak == _flipTweak) {
////        _window.layer.sublayerTransform = CATransform3DMakeScale(1.0, [_flipTweak.currentValue boolValue] ? -1.0 : 1.0, 1.0);
//    }
}
@end
