//
//  PsyQRScanView.h
//  LTLeyoyoWH
//
//  Created by 肖科 on 16/12/27.
//  Copyright © 2016年 LakeTony. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PsyQRScanViewDidFinishWithResult) (NSString* scanResultString);

@interface PsyQRScanView : UIView

@property(nonatomic,strong)PsyQRScanViewDidFinishWithResult  psyQRScanViewDidFinishWithResult;
-(void)setCameraPreviewLayerOriention;
@end
