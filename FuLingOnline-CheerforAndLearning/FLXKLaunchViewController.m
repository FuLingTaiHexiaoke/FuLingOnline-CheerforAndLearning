//
//  FLXKLaunchViewController.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/10/12.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "FLXKLaunchViewController.h"

// Networking
#import "FLXKHttpRequest.h"
#import "UIImageView+WebCache.h"

// Model
#import "FLXKAdImageInfoModel.h"

//Animation
#import "CALayer+FLXKAddition.h"

//Autolayout
#import "Masonry.h"

//Style
#import "FLXKStyleManager.h"

//utilities
#import "EntityGeneratorViewController.h"

#import "FLXSuggestedSharingTableViewController.h"

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
    [self loadAppAnimation];
    [self showTweaksButton];
    
    if (DEBUG) {
        UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
        [btn addTarget:self action:@selector(showEntityGenerator) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=[UIColor yellowColor];
        [self.view addSubview:btn];
        
        UIButton* btn1=[[UIButton alloc]initWithFrame:CGRectMake(50, 150, 50, 50)];
        [btn1 addTarget:self action:@selector(showTabBar) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitle:@"showTabBar" forState:UIControlStateNormal];
        btn1.backgroundColor=[UIColor yellowColor];
        [self.view addSubview:btn1];
        
        UIButton* btn2=[[UIButton alloc]initWithFrame:CGRectMake(150, 150, 50, 50)];
        [btn2 addTarget:self action:@selector(showRouter_Launch_NotificationCenter) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setTitle:@"NotificationCenter" forState:UIControlStateNormal];
        btn2.backgroundColor=[UIColor yellowColor];
        [self.view addSubview:btn2];
        
    }
    
    //get user
    [FLXKSharedAppSingleton getSharedAPPUser];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
        self.navigationController.navigationBarHidden=NO;
}

-(void)dealloc{
     NSLog(@"%@ 销毁",NSStringFromClass(self.class));
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public Methods

+(UINavigationController*)initialAppViewControllerFromDefaultStoryBoard{
    return [[UIStoryboard storyboardWithName:NSStringFromClass([FLXKLaunchViewController class]) bundle:nil] instantiateInitialViewController];
}

- (void)launchAppInWindow:(UIWindow*)window {
    FLXKStyleManager* manager = [FLXKStyleManager new];
    [manager applyStyleToWindow:window];
    [FLXKStyleManager setSharedStyleManager:manager];
    
    [self loadAppSettingFromBundle];
    [window setRootViewController:self.navigationController];
    [window makeKeyAndVisible];
    //    [[UIApplication sharedApplication] keyWindow].tintColor = [UIColor orangeColor];
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

#pragma mark - Setup

- (void)loadMainUI {
    //    if ([self uiIsLoaded]) {
    //        return;
    //    }
    
    
    
    //    UINavigationController* navc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    //    [self addChildViewController:navc];
    //    [self.view addSubview:navc.view];
    //    [navc.view mas_makeConstraints:^(MASConstraintMaker* make) {
    //        make.top.and.bottom.and.leading.and.trailing.equalTo(self.view);
    //    }];
    //    //not clear
    //    //Container View Controller how to implement
    //    //if no transition then call this function immediately
    //    [navc didMoveToParentViewController:self];
    
    
    
    
    //        [self showTweaksButton];
}

//1)get the image url from server
-(void)getAdImageInfo{
    //    http://127.0.0.1:3000/api/getAdimg
    @weakify(self);
    [FLXKHttpRequest get:Url_GetAdvertisementImageInfo success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray* dicArray=(NSArray*)responseObject;
        if (dicArray.count>0) {
            NSDictionary* dic=(NSDictionary*)[dicArray lastObject];
            FLXKAdImageInfoModel* adImageInfoModel=[[FLXKAdImageInfoModel alloc]init];
            [adImageInfoModel setValuesForKeysWithDictionary:dic];
            @strongify(self);
            self.adImageInfoModel=adImageInfoModel;
            [self.advImageView sd_setImageWithURL:[NSURL URLWithString:BaseURL(_adImageInfoModel.imgUrl)] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageAllowInvalidSSLCertificates];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        FLXKLog(@"%@",error.description);
    }];
    
}


-(void)loadAppAnimation{
    
    //add click timing animation
    UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.right-50, 20, 30, 30)];
    [btn addTarget:self action:@selector(loadMainVC) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"跳过" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont  systemFontOfSize:10];
    [self.view addSubview:btn];
    
    [[CAShapeLayer layer]createClockTickCircleAminationLayerWithFrame:btn.bounds inView:btn duration:FBTweakValue(@"Animation", @"LaunchViewController",  @"TickCircle_Duration", 5.0) animationDidStopBlock:^{
    }];
    
    @weakify(self)
    [[CAShapeLayer layer]createFuLingMemoryAminationLayerWithFrame:CGRectMake(0, 0, self.view.width, _companyLogoView.height) inView:_companyLogoView duration:FBTweakValue(@"Animation", @"LaunchViewController",  @"FuLingMemory_Duration", 10.0) animationDidStopBlock:^{
        @strongify(self)
        //长江
        [[CAEmitterLayer layer]  createFlowingWater_CircleAminationLayerWithFrame:CGRectMake(0, 0, self.view.width, _companyLogoView.height) inView:_companyLogoView duration:20.0 isYangtze:YES  animationDidStopBlock:^{
            
        }];
        //乌江
        [[CAEmitterLayer layer]  createFlowingWater_CircleAminationLayerWithFrame:CGRectMake(0, 0, self.view.width, _companyLogoView.height) inView:_companyLogoView duration:20.0 isYangtze:NO  animationDidStopBlock:^{
            
        }];
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

- (void)showTweaksButton{
    UIButton* _tweaksButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width/4, 20, self.view.width/2, 20)];
    [_tweaksButton setTitle:@"Show Tweaks" forState:UIControlStateNormal];
    [_tweaksButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_tweaksButton addTarget:self action:@selector(showTweaksView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_tweaksButton];
}

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

-(void)showEntityGenerator{
    EntityGeneratorViewController* entityGeneratorViewController=[[EntityGeneratorViewController alloc]initWithNibName:@"EntityGeneratorViewController" bundle:nil];
    [self presentViewController:entityGeneratorViewController animated:YES completion:nil];
}

- (void)loadMainVC {
    FLXSuggestedSharingTableViewController* vc=(FLXSuggestedSharingTableViewController* ) [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"StdID_FLXSuggestedSharingTableViewController"];
//    [viewControllers addObject:vc];
    [self presentViewController:vc animated:YES completion:nil];
    
//        UIViewController* rootVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
//        [[UIApplication sharedApplication].keyWindow setRootViewController:rootVC];
//    Router(Router_FLXKTabBarController)
}


-(void)showTabBar{
    Router(Router_FLXKTabBarController)
    Router(Router_TabBar_FriendsSharing_NewsPublish)
}
-(void)showRouter_Launch_NotificationCenter{
    Router(Router_Launch_NotificationCenter)
}

@end
