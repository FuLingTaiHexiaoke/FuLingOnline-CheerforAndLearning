//
//  LoginVC.m
//  YingYuanGeography
//
//  Created by 肖科 on 2017/8/14.
//  Copyright © 2017年 com.psylife. All rights reserved.
//

#import "LoginVC.h"

#import "LYTextField.h"
#import "LYButton.h"
#import "FLXKHttpRequestModelHelper.h"

#import "FLXKProgressHUD.h"

#import "QRCodeReaderViewController.h"



@interface LoginVC ()<QRCodeReaderDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userClassTextField;
@property (weak, nonatomic) IBOutlet UITextField *userIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *userSexTextField;
//@property (weak, nonatomic) IBOutlet UIView *userNameTextField;
//@property (weak, nonatomic) IBOutlet UITextField *userIDTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIButton *scanButton;

@property (weak, nonatomic) IBOutlet UIImageView *uploadImageView;

@property(nonatomic,assign)BOOL isFirstScanResult;

@end

@implementation LoginVC
#pragma mark - ViewController LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        //调用隐藏方法
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    
//    [[UIFont familyNames]enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"%d obj: %@",idx,obj);
//    }];
}

- (void)setupUI{
    
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(uploadLocalFile:)];
    
    [self.uploadImageView addGestureRecognizer:longPress];
    self.uploadImageView.userInteractionEnabled = YES;
    
}

//实现隐藏方法
- (BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public Methods



#pragma mark - Private Methods

- (IBAction)loginButtonClicked:(UIButton *)sender {
    [[FLXKSharedAppSingleton sharedSingleton] playButtonClickSound];
    BOOL isNotEmpty =  (isNotEmptyString(self.userNameTextField.text) && isNotEmptyString(self.userClassTextField.text) && isNotEmptyString(self.userIDTextField.text) && isNotEmptyString(self.userSexTextField.text));
    if (DEBUG && !isNotEmpty) {
        self.userNameTextField.text=@"test_name";
        self.userClassTextField.text=@"test_class";
        self.userIDTextField.text=@"test_id";
        self.userSexTextField.text=@"男";
        isNotEmpty=!isNotEmpty;
    }
    if (isNotEmpty) {
        //检查此用户是否登录过。为新用户添加用户游戏状态数据
        //        [[FLXKSharedAppSingleton sharedSingleton]recordUserId: self.userNameTextField.text user_name:self.userClassTextField.text user_class:self.userIDTextField.text user_sex:self.userSexTextField.text user_type:@"" user_school:@""];
        [[FLXKSharedAppSingleton sharedSingleton]recordUserId: self.userIDTextField.text user_name:self.userNameTextField.text user_class:self.userClassTextField.text user_sex:self.userSexTextField.text user_type:@"" user_school:@""];
        
        //数据记录到文本文件中
        [[FLXKSharedAppSingleton sharedSingleton] recordDataWithScore:@"空" soreDescription:@"空" userAnswer:@"空" rightAnswer:@"空" testSortNum:@"空" testName:@"登录" testTimeLong:@"空"];
        
        UIViewController *nextVC = InstantiateVCWithID(@"MainViewController");
        [self presentViewController:nextVC animated:YES completion:nil];
    }
    else{
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先输入完整信息！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter show];
    }
}


//set up collectionview
- (void)uploadLocalFile:(UIGestureRecognizer* )gestureRecognizer{
    if (gestureRecognizer.state==UIGestureRecognizerStateBegan) {
        [FLXKProgressHUD showLoadingWithTip:@"正在上传..."];
        [self setUserInteractionEnabled:NO];
        WEAKSELF(weakSelf);
        [[FLXKHttpRequestModelHelper registerSuccessCallback:^(id obj) {
            NSLog(@"obj %@", obj);
            // Update the UI on the main thread
            [FLXKProgressHUD showSuccessWithTip:@"上传成功！"];
            [weakSelf setUserInteractionEnabled:YES];
        } failureCallback:^(NSError *err) {
            if (err) {
                [FLXKProgressHUD showErrorWithTip:@"上传失败！"];
            }
            [weakSelf setUserInteractionEnabled:YES];
            
        }] uploadLocalFile];
    }
}

- (void)setUserInteractionEnabled:(BOOL)enable{
    self.uploadImageView.userInteractionEnabled = enable;
    self.loginButton.userInteractionEnabled = enable;
}

#pragma mark - QRCodeReaderViewController

- (IBAction)scanButtonAction:(id)sender {
    _isFirstScanResult=YES;
    NSArray *types = @[AVMetadataObjectTypeQRCode];
    QRCodeReaderViewController* _reader        = [QRCodeReaderViewController readerWithMetadataObjectTypes:types];
    _reader.delegate = self;
    
    [_reader setCompletionWithBlock:^(NSString *resultAsString) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [self presentViewController:_reader animated:YES completion:NULL];
}

#pragma mark - Delegates

#pragma mark - QRCodeReaderDelegate

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    if (_isFirstScanResult && isNotEmptyString(result)) {
        _isFirstScanResult=NO;
        NSArray *array = [result componentsSeparatedByString:@"&"];
        if ([array count]>=4) {
            self.userNameTextField.text=array[0];
            self.userClassTextField.text=array[1];
            self.userIDTextField.text=array[2];
            self.userSexTextField.text=array[3];
        }
        else
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"二维码扫描有误，请重新扫描" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }
}

@end
