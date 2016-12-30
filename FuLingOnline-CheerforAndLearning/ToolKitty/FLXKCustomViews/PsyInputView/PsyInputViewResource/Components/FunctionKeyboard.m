//
//  FuncKeyboard.m
//  MyKeyboard
//
//  Created by 张鹏 on 16/1/1.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "FunctionKeyboard.h"

@interface FunctionKeyboard ()

@property (nonatomic,strong) UIButton * photoButton;
@property (nonatomic,strong) UIButton * videoButton;
@property (nonatomic,strong) UIButton * locationButton;

@end

@implementation FunctionKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupMoudle];
    }
    return self;
}

- (void)setupMoudle
{
    self.photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.photoButton.frame = CGRectMake(10, 10, 75, 75);
    self.photoButton.backgroundColor = [UIColor lightGrayColor];
    self.photoButton.tag = 1;
    //[self.photoButton setTitle:@"相册" forState:UIControlStateNormal];
    [self.photoButton setImage:[UIImage imageNamed:@"sharemore_pic"] forState:UIControlStateNormal];
    [self addSubview:self.photoButton];
    [self.photoButton addTarget:self action:@selector(tapFunctionButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.videoButton.frame = CGRectMake(95, 10, 75, 75);
    self.videoButton.backgroundColor = [UIColor lightGrayColor];
    self.videoButton.tag = 2;
    [self .videoButton setImage:[UIImage imageNamed:@"sharemore_videovoip"] forState:UIControlStateNormal];
    [self addSubview:self.videoButton];
    [self.videoButton addTarget:self action:@selector(tapFunctionButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.locationButton.frame = CGRectMake(180, 10, 75, 75);
    self.locationButton.backgroundColor = [UIColor lightGrayColor];
    self.locationButton.tag = 3;
    [self .locationButton setImage:[UIImage imageNamed:@"sharemore_location"] forState:UIControlStateNormal];
    [self addSubview:self.locationButton];
    [self.locationButton addTarget:self action:@selector(tapFunctionButton:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)tapFunctionButton:(UIButton *)sender
{
    if (self.functionKeyboardBlock)
    {
        self.functionKeyboardBlock (sender.tag);
        
    }
}

@end
