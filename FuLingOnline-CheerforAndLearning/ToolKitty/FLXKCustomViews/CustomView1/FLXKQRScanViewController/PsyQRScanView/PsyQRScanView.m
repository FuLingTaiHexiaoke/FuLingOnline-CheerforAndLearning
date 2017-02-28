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
        [self setupScanningQRCode];
        [self setCameraPreviewLayerOriention];
        //view Orientation change
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(statusBarOrientationChange:)
//                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
//                                                   object:nil];
    }
    return self;
}




//-(void)dealloc{
//    
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//}

#pragma mark - - - 二维码扫描
- (void)setupScanningQRCode {
    // 1、获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2、创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3、创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    // 4、设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 设置扫描范围(每一个取值0～1，以屏幕右上角为坐标原点)
    // 注：微信二维码的扫描范围是整个屏幕，这里并没有做处理（可不用设置）
    
    
    output.rectOfInterest = CGRectMake(0.1, 0.1, 0.8,0.8);
    
    // 5、初始化链接对象（会话对象）
    self.session = [[AVCaptureSession alloc] init];
    // 高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    // 5.1 添加会话输入
    [_session addInput:input];
    
    // 5.2 添加会话输出
    [_session addOutput:output];
    
    // 6、设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // 7、实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = self.layer.bounds;
    //    _previewLayer.frame =   CGRectMake(100, 200,200, 200);
    // 8、将图层插入当前视图
    [self.layer insertSublayer:_previewLayer atIndex:0];
    
    // 9、启动会话
    [_session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    // 会频繁的扫描，调用代理方法
    
    // 0、扫描成功之后的提示音
    [self playSoundEffect:@"sound.caf"];
    
    // 1、如果扫描完成，停止会话
    [self.session stopRunning];
    
    [self performSelector:@selector(restarAVCaptureSessionRunning) withObject:self afterDelay:5.0];
    // 2、删除预览图层
//    [self.previewLayer removeFromSuperlayer];
    
    // 3、设置界面显示扫描结果
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
//        NSLog(@"metadataObjects = %@", metadataObjects);
        
//        if ([obj.stringValue hasPrefix:@"http"]) {
//
//            NSLog(@"stringValue = = %@", obj.stringValue);
//
//            
//        } else { // 扫描结果为条形码
//
//            NSLog(@"stringValue = = %@", obj.stringValue);
//
//        }
        
        if (self.psyQRScanViewDidFinishWithResult) {
            self.psyQRScanViewDidFinishWithResult(obj.stringValue);
        }
        
    }
}

- (void)restarAVCaptureSessionRunning{
    [_session startRunning];
}


#pragma mark - - - 扫描提示声
/**
 *  播放完成回调函数
 *
 *  @param soundID    系统声音ID
 *  @param clientData 回调时传递的数据
 */
void soundDidCompleteCallback(SystemSoundID soundID,void * clientData){
    NSLog(@"播放完成...");
}

/**
 *  播放音效文件
 *
 *  @param name 音频文件名称
 */
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


