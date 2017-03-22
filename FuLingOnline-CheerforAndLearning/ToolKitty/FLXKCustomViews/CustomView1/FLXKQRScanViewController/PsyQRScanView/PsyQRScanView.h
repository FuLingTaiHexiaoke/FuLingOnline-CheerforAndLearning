//
//  PsyQRScanView.h
//  LTLeyoyoWH
//
//  Created by 肖科 on 16/12/27.
//  Copyright © 2016年 LakeTony. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PsyQRScanViewDidFinishWithResult) (NSString* scanResultString);
typedef void (^PsyQRScanViewRestarScanningBlcok) ();

@interface PsyQRScanView : UIView

- (void)startQRScanning;

- (void)stopQRScanning;

- (void)clearQRScanning;

@property(nonatomic,strong)PsyQRScanViewDidFinishWithResult  psyQRScanViewDidFinishWithResult;

@property(nonatomic,strong)PsyQRScanViewRestarScanningBlcok  psyQRScanViewRestarScanningBlcok;

-(void)setCameraPreviewLayerOriention;
@end
