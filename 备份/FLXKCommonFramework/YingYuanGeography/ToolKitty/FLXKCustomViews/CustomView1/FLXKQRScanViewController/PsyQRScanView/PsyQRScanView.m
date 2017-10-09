//  - - GitHub下载地址 https://github.com/kingsic/SGQRCode.git - - - - - - - - - //

/*
 二维码扫描的步骤：
 1、创建设备会话对象，用来设置设备数据输入
 2、获取摄像头，并且将摄像头对象加入当前会话中
 3、实时获取摄像头原始数据显示在屏幕上
 4、扫描到二维码/条形码数据，通过协议方法回调
 
 AVCaptureSession 会话对象。此类作为硬件设备输入输出信息的桥梁，承担实时获取设备数据的责任
 AVCaptureDeviceInput 设备输入类。这个类用来表示输入数据的硬件设备，配置抽象设备的port
 AVCaptureMetadataOutput 输出类。这个支持二维码、条形码等图像数据的识别
 AVCaptureVideoPreviewLayer 图层类。用来快速呈现摄像头获取的原始数据
 二维码扫描功能的实现步骤是创建好会话对象，用来获取从硬件设备输入的数据，并实时显示在界面上。在扫描到相应图像数据的时候，通过AVCaptureVideoPreviewLayer类型进行返回
 */


//  PsyQRScanView.m
//  LTLeyoyoWH
//
//  Created by 肖科 on 16/12/27.
//  Copyright © 2016年 LakeTony. All rights reserved.
//

#import "PsyQRScanView.h"
#import <AVFoundation/AVFoundation.h>
@interface PsyQRScanView()<AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate>
/** 会话对象 */
@property (nonatomic, strong) AVCaptureSession *session;
/** 图层类 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@end

@implementation PsyQRScanView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self checkCaptureAuthorisation];
    }
    return self;
}


-(void)dealloc{
    [self clearQRScanning];
    NSLog(@"%@ 销毁",self);
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)checkCaptureAuthorisation
{
    NSString *mediaType = AVMediaTypeVideo;
    
    // verifying authorization
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
            if (granted) { // ok
                [self didChangeAccessCameraState:YES];
            }
            else { // denied
                [self didChangeAccessCameraState:NO];
            }
        }];
    }
    else if (authStatus == AVAuthorizationStatusAuthorized) {
        [self didChangeAccessCameraState:YES];
    }
    else { // denied or restricted
        [self didChangeAccessCameraState:NO];
    }
}


- (void)didChangeAccessCameraState:(BOOL)isGranted
{
    if (isGranted) { // just granted
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(statusBarOrientationChange:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
        [self setupScanningQRCode];
        [self addCapturePreviewSubLayer];
        [self startQRScanning];
    }
    else { // just deny, show alert
        [self alertCameraAuth];
    }
}

- (void)startQRScanning
{
    if (_session && !_session.isRunning) {
        // start the session running to start the flow of data
        //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ////            [self setCameraPreviewLayerOriention];
        //            [self.session startRunning];
        //        });
        [self setCameraPreviewLayerOriention];
        [self.session startRunning];
        
        if ([_session.outputs count] > 0) {
            AVCaptureMetadataOutput* output = (AVCaptureMetadataOutput*)[_session.outputs objectAtIndex:0];
            CGRect tempRect = [_previewLayer metadataOutputRectOfInterestForRect:_previewLayer.bounds];
            NSLog(@"NSStringFromCGRect(output.rectOfInterest) %@ tempRect %@",NSStringFromCGRect(_previewLayer.bounds), NSStringFromCGRect(tempRect) );
            output.rectOfInterest=tempRect;
        }
        
    }
    
}

- (void)stopQRScanning
{
    if (_session && _session.isRunning) {
        //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //            [self.session stopRunning];
        //        });
        [self.session stopRunning];
    }
}

- (void)clearQRScanning
{
    // clear capture
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //
    //        [_session stopRunning];
    //
    //        if ([_session.inputs count] > 0) {
    //            AVCaptureInput* input = [_session.inputs objectAtIndex:0];
    //            [_session removeInput:input];
    //        }
    //        if ([_session.outputs count] > 0) {
    //            AVCaptureVideoDataOutput* output = (AVCaptureVideoDataOutput*)[_session.outputs objectAtIndex:0];
    //            [_session removeOutput:output];
    //        }
    //
    //        [_previewLayer removeFromSuperlayer];
    //
    //        _previewLayer = nil;
    //        _session = nil;
    //    });
    
    [_session stopRunning];
    
    if ([_session.inputs count] > 0) {
        AVCaptureInput* input = [_session.inputs objectAtIndex:0];
        [_session removeInput:input];
    }
    if ([_session.outputs count] > 0) {
        AVCaptureVideoDataOutput* output = (AVCaptureVideoDataOutput*)[_session.outputs objectAtIndex:0];
        [_session removeOutput:output];
    }
    
    [_previewLayer removeFromSuperlayer];
    
    _previewLayer = nil;
    _session = nil;
}

- (void)restarAVCaptureSessionRunning{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.psyQRScanViewRestarScanningBlcok) {
            self.psyQRScanViewRestarScanningBlcok();
        }
        [self startQRScanning];
    });
}


// helper
- (void)addCapturePreviewSubLayer
{
    // add video preview layer
    _previewLayer.frame = self.layer.bounds;
    //    _previewLayer.frame =   CGRectMake(100, 200,200, 200);
    // 8、将图层插入当前视图
    [self.layer insertSublayer:_previewLayer atIndex:0];
}



#pragma mark - - - 二维码扫描
- (void)setupScanningQRCode {
    // 1、获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2、创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3、创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    // 4、设置代理 在主线程里刷新
    // configure output
    // create a new serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("captureOutputQueue", NULL);
    [output setMetadataObjectsDelegate:self queue:dispatchQueue];
    //    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 设置扫描范围(每一个取值0～1，以屏幕右上角为坐标原点)
    // 注：微信二维码的扫描范围是整个屏幕，这里并没有做处理（可不用设置）
    
    //    output.rectOfInterest = CGRectMake(0.1, 0.1, 0.8,0.8);
    
    // 5、初始化链接对象（会话对象）
    self.session = [[AVCaptureSession alloc] init];
    // 高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    // 5.1 添加会话输入
    if ([_session canAddInput:input]) {
        [_session addInput:input];
    }
    else{
        [self setupScanningQRCode];
        return;
    }
    
    // 5.2 添加会话输出
    if ([_session canAddOutput:output]) {
        [_session addOutput:output];
        
    }
    else{
        [self setupScanningQRCode];
        return;
    }
    
    // 6、设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // 7、实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //    _previewLayer.frame = self.layer.bounds;
    
    // 9、启动会话
    //    [_session startRunning];
}

#pragma mark - MetadataObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0) {
        //        NSLog(@"loginCount: netString:2");
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        NSString* resultString=obj.stringValue;
        if ([resultString componentsSeparatedByString:@"&"].count==4) {
            
            // 0、扫描成功之后的提示音
            [self playSoundEffect:@"sound.caf"];
            
            // 1、如果扫描完成，停止会话
            //            [self.session stopRunning];
            [self stopQRScanning];
            
            [self performSelector:@selector(restarAVCaptureSessionRunning) withObject:self afterDelay:10.0];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.psyQRScanViewDidFinishWithResult) {
                    self.psyQRScanViewDidFinishWithResult(obj.stringValue);
                }});
        }
    }
}

// helper
- (void)alertCameraAuth
{
    NSString *title = @"登录提示";
    NSString *message = @"相机功能未被授权，为使用扫码登录功能，请在“设置-隐私-相机”选项中，允许应用访问你的相机。然后重启程序。";
    NSString *cancelTitle = nil;
    NSString *otherTitle = @"好";
    // alert view
    UIAlertView *tipAlert = [[UIAlertView alloc] initWithTitle:title
                                                       message:message
                                                      delegate:nil
                                             cancelButtonTitle:cancelTitle
                                             otherButtonTitles:otherTitle, nil];
    [tipAlert show];
}


#pragma mark - - - 扫描提示声

- (void)playSoundEffect:(NSString *)name{
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    // 1、获得系统声音ID
    SystemSoundID soundID = 0;
    /**
     * inFileUrl:音频文件url
     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    
    // 如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundDidCompleteCallback, NULL);
    
    // 2、播放音频
    AudioServicesPlaySystemSound(soundID); // 播放音效
}


void soundDidCompleteCallback(SystemSoundID soundID,void * clientData){
    NSLog(@"播放完成...");
}

#pragma mark - PreviewLayerOriention Change

- (void)statusBarOrientationChange:(NSNotification *)notification
{
    [self setCameraPreviewLayerOriention];
}

-(void)setCameraPreviewLayerOriention {
    UIInterfaceOrientation newStatusBarOrientation=[[UIApplication sharedApplication] statusBarOrientation];
    if (newStatusBarOrientation!=UIInterfaceOrientationUnknown) {
        if (newStatusBarOrientation==UIInterfaceOrientationLandscapeLeft) {
            self.previewLayer.connection.videoOrientation=AVCaptureVideoOrientationLandscapeLeft  ;
        }
        else if (newStatusBarOrientation==UIInterfaceOrientationLandscapeRight) {
            self.previewLayer.connection.videoOrientation= AVCaptureVideoOrientationLandscapeRight  ;
        }
        else if (newStatusBarOrientation==UIInterfaceOrientationPortrait) {
            self.previewLayer.connection.videoOrientation=AVCaptureVideoOrientationPortrait;
        }
        else if (newStatusBarOrientation==UIInterfaceOrientationPortraitUpsideDown) {
            self.previewLayer.connection.videoOrientation=AVCaptureVideoOrientationPortraitUpsideDown;
        }
    }
}



@end


