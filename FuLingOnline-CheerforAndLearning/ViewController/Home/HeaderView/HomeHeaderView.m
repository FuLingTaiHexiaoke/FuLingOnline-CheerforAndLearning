//
//  HomeHeaderView.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/11/24.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "HomeHeaderView.h"

@interface HomeHeaderView()
@property (weak, nonatomic) IBOutlet UIScrollView *carouselScrollView;
@property (weak, nonatomic) IBOutlet UIView *carouselDescriptionContainer;
@property (weak, nonatomic) IBOutlet UILabel *carouselDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *carouselPageControl;
@property (weak, nonatomic) IBOutlet UIButton *topicButton1;
@property (weak, nonatomic) IBOutlet UIButton *topicButton2;
@property (weak, nonatomic) IBOutlet UIButton *topicButton3;
@end

@implementation HomeHeaderView

+(HomeHeaderView *)newInstance
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"HomeHeaderView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

#pragma mark - View Lifecircle

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        //init sub details
    }
    return self;
}
-(void)awakeFromNib{
   //init sub details
    
}

#pragma mark - Model setting



@end
