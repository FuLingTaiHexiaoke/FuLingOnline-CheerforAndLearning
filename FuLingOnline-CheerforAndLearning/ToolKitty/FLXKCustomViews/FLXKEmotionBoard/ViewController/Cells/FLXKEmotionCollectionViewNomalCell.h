//
//  FLXKEmotionCollectionViewNomalCell.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/1/19.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmotionItem;

@interface FLXKEmotionCollectionViewNomalCell : UICollectionViewCell
@property(nonatomic,strong)EmotionItem* item;
@property (weak, nonatomic) IBOutlet UIButton *emotionButton;
@end
