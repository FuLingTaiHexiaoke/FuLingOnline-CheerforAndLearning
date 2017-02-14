//
//  FLXKEmotionBoard.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/12/23.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "FLXKEmotionBoard.h"

//subviews

#import "FLXKEmotionShowingScrollView.h"
#import "FLXKEmotionGroupIndexCollectionView.h"

//utilites
#import "UIImage+EmotionExtension.h"
#import "EmotionTextAttachment.h"
#import "NSAttributedString+EmotionExtension.h"
#import "UIImage+GIF.h"
#import "FLXKEmotionConfig.h"
#import "KYAnimatedPageControl.h"
#import "Masonry.h"

//entity
#import "EmotionGroup.h"
#import "EmotionItem.h"
#import "EmotionRecentItems.h"

//models
#import "EmotionGroupDetailModel.h"


typedef NS_ENUM(NSUInteger, InputViewType) {
    FLXKSystemKeyboard,
    FLXKEmotionKeyboard,
    FLXKToolKitBoard,
    FLXKVoiceRecordBoard,
};


@interface FLXKEmotionBoard ()<UIScrollViewDelegate,FLXKEmotionShowingScrollViewDelegate,FLXKEmotionGroupIndexCollectionViewDelegate>
//IBOutlet views
@property (weak, nonatomic) IBOutlet UIView *pageControlPlaceholder;
@property (strong, nonatomic) KYAnimatedPageControl *pageControl;
@property (weak, nonatomic) IBOutlet FLXKEmotionShowingScrollView *emotionContainerScrollView;
@property (weak, nonatomic) IBOutlet FLXKEmotionGroupIndexCollectionView *emotionGroupIndexCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *leftBottomButton;
@property (weak, nonatomic) IBOutlet UIButton *rightBottomButton;

//state record
@property(nonatomic, assign) NSRange currentShowingRange;//当前显示的表情组的范围
@property(nonatomic, assign)BOOL isChangingInputView;


//控制bottombar类型控件的升降外部属性
@property(nonatomic,weak)UITextView *editingTextView;
@property(nonatomic,weak)UIButton* emotionSwithButton;
@property(nonatomic,weak)UIBarButtonItem* emotionSwithBarButtonItem;
@property(nonatomic,weak)UIView *emotionSwithButtonContainer;
@property(nonatomic,weak)UIView *emotionEditingVCView;
//预留工具箱、语音记录按钮属性
@property(nonatomic,weak)UIButton* toolkitButton;
@property(nonatomic,weak)UIButton* voiceRecordButton;

//models
//@property(nonatomic,strong)NSMutableArray<EmotionGroupDetailModel *>* emotionGroupDetailModels;
@end

@implementation FLXKEmotionBoard

#pragma mark - Public Methods

+(instancetype)sharedEmotionBoardWithEditingTextView:(UITextView *)editingTextView swithButton:(UIButton *)swithButton swithButtonContainer:(UIView *)swithButtonContainer emotionEditingVCView:(UIView *)emotionEditingVCView emotionGroupShowingOption:(EmotionGroupShowingOption)emotionGroupShowingOption {
    FLXKEmotionBoard * sharedEmotionBoard=[FLXKEmotionBoard sharedEmotionBoard];
    sharedEmotionBoard.editingTextView=editingTextView;
    sharedEmotionBoard.emotionSwithButtonContainer=swithButtonContainer;
    sharedEmotionBoard.emotionSwithButton=swithButton;
    sharedEmotionBoard.emotionEditingVCView=emotionEditingVCView;
    //add action
    [sharedEmotionBoard.emotionSwithButton addTarget:sharedEmotionBoard action:@selector(changeInputViewType:) forControlEvents:UIControlEventTouchUpInside];
    sharedEmotionBoard.emotionSwithButton.tag=FLXKEmotionKeyboard;
    
    [[NSNotificationCenter defaultCenter] addObserver:sharedEmotionBoard selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    return sharedEmotionBoard;
}

+(instancetype)sharedEmotionBoardWithEditingTextView:(UITextView *)editingTextView emotionSwithBarButtonItem:(UIBarButtonItem *)emotionSwithBarButtonItem swithButtonContainer:(UIView *)swithButtonContainer emotionEditingVCView:(UIView *)emotionEditingVCView{
    FLXKEmotionBoard * sharedEmotionBoard=[FLXKEmotionBoard sharedEmotionBoard];
    sharedEmotionBoard.editingTextView=editingTextView;
    sharedEmotionBoard.emotionSwithButtonContainer=swithButtonContainer;
    sharedEmotionBoard.emotionSwithBarButtonItem=emotionSwithBarButtonItem;
    sharedEmotionBoard.emotionEditingVCView=emotionEditingVCView;
    
    //add action
    sharedEmotionBoard.emotionSwithBarButtonItem.target=self;
    sharedEmotionBoard.emotionSwithBarButtonItem.action=@selector(changeInputViewTypeWithBarButtonItem:);
    sharedEmotionBoard.emotionSwithBarButtonItem.tag=FLXKEmotionKeyboard;
    
    [[NSNotificationCenter defaultCenter] addObserver:sharedEmotionBoard selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    return sharedEmotionBoard;
}

+(instancetype)sharedEmotionBoard{
    static FLXKEmotionBoard* sharedEmotionBoard=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray* nibViews =  [[NSBundle mainBundle] loadNibNamed:@"FLXKEmotionBoard" owner:nil options:nil];
        sharedEmotionBoard=[nibViews objectAtIndex:0];
    });
    return sharedEmotionBoard;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [EmotionGroup createTable];
        [EmotionItem createTable];
        [EmotionRecentItems createTable];
        //        //添加键盘弹出-隐藏通知
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    //setup the relationship between subview control
    _emotionContainerScrollView.delegate=self;
    _emotionContainerScrollView.pagingEnabled=YES;
    _emotionContainerScrollView.emotionSelectedDelegate=self;
    //        [self setDelegateForSubViewsInScrollView];
    _emotionGroupIndexCollectionView.emotionGroupSelectedDelegate=self;
    [self setupUIPageControl];
    NSLog(@"NSStringFromCGRect self.height: %@",NSStringFromCGRect(self.frame));
    
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        //        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    else{
        //添加键盘弹出-隐藏通知
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
        //添加键盘弹出-隐藏通知
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
    }
}

-(void)keyboardDidShowNotification:(NSNotification*)notification{
    if (self.editingTextView.inputView) {
        [self.emotionGroupIndexCollectionView selecteItemAtContentOffset:0];
    }
}

-(void)changeInputViewType:(UIButton *)sender{
    sender.tag= self.editingTextView.inputView?FLXKSystemKeyboard:FLXKSystemKeyboard;
    InputViewType inputViewType=sender.tag;
    switch (inputViewType) {
        case FLXKSystemKeyboard:
            [self.emotionSwithButton setImage:[UIImage ImageWithName:@"b_keyboard_emotion" ] forState:UIControlStateNormal];
            break;
        case FLXKEmotionKeyboard:
            [self.emotionSwithButton setImage:[UIImage ImageWithName:@"b_keyboard_system" ] forState:UIControlStateNormal];
            break;
        case FLXKToolKitBoard:
            sender.tag=FLXKSystemKeyboard;
            break;
        case FLXKVoiceRecordBoard:
            sender.tag=FLXKSystemKeyboard;
            break;
        default:
            break;
    }
    _isChangingInputView=YES;
    [self.editingTextView resignFirstResponder];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.09f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.editingTextView.inputView=self.editingTextView.inputView?nil:self;
        _isChangingInputView=NO;
        [self.editingTextView becomeFirstResponder];
    });
}

-(void)changeInputViewTypeWithBarButtonItem:(UIBarButtonItem *)sender{
    sender.tag= self.editingTextView.inputView?FLXKSystemKeyboard:FLXKSystemKeyboard;
    InputViewType inputViewType=sender.tag;
    switch (inputViewType) {
        case FLXKSystemKeyboard:
            self.emotionSwithBarButtonItem.title=@"键盘";
            break;
        case FLXKEmotionKeyboard:
            self.emotionSwithBarButtonItem.title=@"表情";
            break;
        case FLXKToolKitBoard:
            sender.tag=FLXKSystemKeyboard;
            break;
        case FLXKVoiceRecordBoard:
            sender.tag=FLXKSystemKeyboard;
            break;
        default:
            break;
    }
    _isChangingInputView=YES;
    [self.editingTextView resignFirstResponder];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.09f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.editingTextView.inputView=self.editingTextView.inputView?nil:self;
        _isChangingInputView=NO;
        [self.editingTextView becomeFirstResponder];
    });
}

-(void)didSelectedEmotionGroupItem:(NSRange)range{
    [self setCurrentShowingRange:range];
}

-(void)didSelectedEmotionItem:(EmotionItem*)emotionItem{
    if (emotionItem.emotionItemImageType==1) {
        [self   insertEmoji:emotionItem.emotionItemName];
    }
    else{
        [self insertEmotion:emotionItem.id emotionName:emotionItem.emotionItemName imageName:emotionItem.emotionItemSmallImageUrl];
    }
}

-(void)setCurrentShowingRange:(NSRange)currentShowingRange{
    _currentShowingRange=currentShowingRange;
    
    //_emotionContainerScrollView
    CGFloat tempStartLength=currentShowingRange.location*Screen_Width;
    CGFloat tempContentLength=(currentShowingRange.length-1)*Screen_Width;
    CGFloat  contentOffset=  _emotionContainerScrollView.contentOffset.x;
    if (tempStartLength>contentOffset || contentOffset>tempContentLength+tempStartLength) {
        [_emotionContainerScrollView setContentOffset:CGPointMake(currentShowingRange.location*Screen_Width, 0) animated:NO];
    }
    
    [_emotionContainerScrollView setCurrentShowingPageIndex:currentShowingRange.location] ;
    
    //pagecontrol
    [self changePageControlShowing];
}

////读取表情配置文件生成models
//-(NSMutableArray<EmotionGroupDetailModel *>*)emotionGroupDetailModels{
//    NSMutableArray<EmotionGroupDetailModel *>* emotionGroupDetailModels=[NSMutableArray array];
//    [[EmotionGroup selectAll]enumerateObjectsUsingBlock:^(EmotionGroup * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        EmotionGroupDetailModel * model=[[EmotionGroupDetailModel alloc]init];
//        model.groupId=obj.id;
//        model.groupName=obj.emotionGroupName;
//        model.groupImageUrl=obj.emotionGroupImageUrl;
//        [emotionGroupDetailModels addObject:model];
//    }];
//    return emotionGroupDetailModels;
//}


- (void)insertEmotion:(NSInteger)emotionID emotionName:(NSString*)emotionName imageName:(NSString*)imageName{
    //Create emoji attachment
    EmotionTextAttachment *emotionTextAttachment = [EmotionTextAttachment new];
    //Set tag and image
    emotionTextAttachment.emotionName =emotionName;
    emotionTextAttachment.image = [UIImage ImageWithName:imageName];
    //Set emoji size
    emotionTextAttachment.emotionSize =  CGSizeMake(20, 20);
    
    //Insert emoji image
    [self.editingTextView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:emotionTextAttachment]
                                                     atIndex:self.editingTextView.selectedRange.location];
    //Move selection location
    self.editingTextView.selectedRange = NSMakeRange(self.editingTextView.selectedRange.location + 1, self.editingTextView.selectedRange.length);
    
    //Reset text style
    [self resetTextStyle];
}

- (void)insertEmoji:(NSString*)EmojiName{
    //Insert emoji
    [self.editingTextView.textStorage insertAttributedString:[[NSAttributedString alloc] initWithString: EmojiName]
                                                     atIndex:self.editingTextView.selectedRange.location];
    //Move selection location
    self.editingTextView.selectedRange = NSMakeRange(self.editingTextView.selectedRange.location + 2, self.editingTextView.selectedRange.length);
    
    //Reset text style
    [self resetTextStyle];
}

- (void)resetTextStyle {
    
    //After changing text selection, should reset style.
    NSRange wholeRange = NSMakeRange(0, self.editingTextView.textStorage.length);
    
    [self.editingTextView.textStorage removeAttribute:NSFontAttributeName range:wholeRange];
    
    [self.editingTextView.textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:wholeRange];
    
}

//-(void)deleteElementInTextView{
//    if (self.editingTextView.selectedRange.location>0) {
//        if (self.editingTextView.selectedRange.location==self.editingTextView.textStorage.length) {
//            NSRange deleteRange=NSMakeRange(self.editingTextView.selectedRange.location-1, 1);
//            [self.editingTextView.textStorage  deleteCharactersInRange:deleteRange];
//        }
//        else{
//            NSRange deleteRange=NSMakeRange(self.editingTextView.selectedRange.location-1, 1);
//            [self.editingTextView.textStorage  deleteCharactersInRange:deleteRange];
//            self.editingTextView.selectedRange = NSMakeRange(self.editingTextView.selectedRange.location-1, self.editingTextView.selectedRange.length);
//        }
//    }
//}

-(void)deleteElementInTextView{
    NSRange range = self.editingTextView.selectedRange;
    NSLog(@"%zd-表情删除-%zd",range.length,range.location);
    if (self.editingTextView.text.length > 0) {
        NSUInteger location  = self.editingTextView.selectedRange.location;
        NSString *head = [self.editingTextView.text substringToIndex:location];
        //部分选中
        if (range.length>0&&location>0){
            NSMutableAttributedString *str = self.editingTextView.textStorage;
            [str deleteCharactersInRange:range];
            self.editingTextView.attributedText = str;
            self.editingTextView.selectedRange = NSMakeRange(location,0);
        }
        //没有选中
        else if (range.length==0 && location > 0){
            NSMutableAttributedString *str = self.editingTextView.textStorage;
            [self lastRange:head];
            [str deleteCharactersInRange:[self lastRange:head]];
            self.editingTextView.attributedText = str;
            self.editingTextView.selectedRange = NSMakeRange([self lastRange:head].location,0);
        }
        else if (range.length==0 && location == 0){
            self.editingTextView.selectedRange = NSMakeRange(0,0);
        }
        //全选
        else{
            self.editingTextView.text =@"";
        }
    }
}


/**
 *  计算选中的最后一个是字符还是表情返回最后的rang长度
 */
- (NSRange)lastRange:(NSString *)str {
    NSRange lastRange = [str rangeOfComposedCharacterSequenceAtIndex:str.length-1];
    return lastRange;
}

+(NSString*)getPlainTextString{
    return    [[FLXKEmotionBoard sharedEmotionBoard].editingTextView.attributedText getPlainStringtest];
}



-(void)setupUIPageControl{
    self.pageControl = [[KYAnimatedPageControl alloc]
                        initWithFrame:self.pageControlPlaceholder.superview.frame];
    self.pageControl.pageCount = 8;
    self.pageControl.unSelectedColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.pageControl.selectedColor = [UIColor colorWithWhite:0.6 alpha:1];
    self.pageControl.bindScrollView = self.emotionContainerScrollView;
    self.pageControl.shouldShowProgressLine = NO;
    self.pageControl.indicatorStyle = IndicatorStyleGooeyCircle;
    self.pageControl.indicatorSize = 10;
    self.pageControl.swipeEnable = YES;
    [self addSubview:self.pageControl];
    self.pageControl.didSelectIndexBlock = ^(NSInteger index) {
        NSLog(@"Did Selected index : %ld", (long)index);
    };
}

#pragma mark -  UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self changePageControlShowing];
    [_emotionContainerScrollView setCurrentShowingPageIndex:(NSInteger) scrollView.contentOffset.x/(Screen_Width)] ;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.indicator.lastContentOffset = scrollView.contentOffset.x;
    
    [self.emotionGroupIndexCollectionView selecteItemAtContentOffset:scrollView.contentOffset.x];
    
    [_emotionContainerScrollView setCurrentShowingPageIndex:(NSInteger) scrollView.contentOffset.x/(Screen_Width)] ;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    //    [self.pageControl.indicator restoreAnimation:@(1.0 / self.pageControl.pageCount)];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.pageControl.indicator.lastContentOffset = scrollView.contentOffset.x;
}

-(void)changePageControlShowing{
    [self.pageControl setCurrentShowingRange:self.currentShowingRange];
}



-(void)keyboardWillChangeFrame:(NSNotification*)notif{
    //get animation properties
    float animationDuration = [[[notif userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationCurve animationCurve = [[[notif userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    
    //get keyboard frame properties
    CGRect keyboardStartingFrame = [[[notif userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect keyboardEndingFrame = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    float  keyboadStartingHeight =Screen_Height - keyboardStartingFrame.origin.y;
    float  keyboadEndingHeight = Screen_Height- keyboardEndingFrame.origin.y;
    
    
    //I do not why this happened,if you know tell me.
    if ([NSStringFromCGRect(keyboardStartingFrame) isEqualToString:NSStringFromCGRect(keyboardEndingFrame) ]) {
        if (animationDuration!=0) {
            [self changeEmotionSwithButtonContainerWithAnimationDuration:animationDuration animationCurve:animationCurve keyboadStartingHeight:keyboadStartingHeight+1 keyboadEndingHeight:keyboadEndingHeight];
        }
        return;
    }
    
    if(_isChangingInputView) {
        return;
    }
    
    [self changeEmotionSwithButtonContainerWithAnimationDuration:animationDuration animationCurve:animationCurve keyboadStartingHeight:keyboadStartingHeight keyboadEndingHeight:keyboadEndingHeight];
    
}

-(void)changeEmotionSwithButtonContainerWithAnimationDuration:(CGFloat)animationDuration animationCurve:(UIViewAnimationCurve)animationCurve
                                        keyboadStartingHeight:(CGFloat)keyboadStartingHeight keyboadEndingHeight:(CGFloat)keyboadEndingHeight{

    //在此，我们需要判断用户程序中emotionSwithButtonContainer是用Layout布局还是Frame，并根据不同的布局方式，动态调整emotionSwithButtonContainer的高度。
    __block  BOOL isAutoLayout=NO;
    [self.emotionEditingVCView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.firstItem==self.emotionSwithButtonContainer ) {
            isAutoLayout=YES;
            *stop=YES;
        }
    }];
    
    //keyboadStartingHeight>0代表keyboard目前处于显示阶段
    CGFloat  heightToChange= keyboadStartingHeight>0?0:keyboadEndingHeight;
    
    if (!isAutoLayout) {
        //此时是frame,所以我们需要更改frame.origin.x
        CGRect oldFrame=self.emotionSwithButtonContainer.frame;
        oldFrame.origin.x=Screen_Height-heightToChange-oldFrame.size.height;
        [UIView animateWithDuration:animationDuration delay:0.0 options:animationCurve<<16 animations:^{
            self.emotionSwithButtonContainer.frame=oldFrame;
        } completion:^(BOOL finished) {
        }];
    }
    else{
        //删除以前添加的约束
        [self.emotionEditingVCView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.firstItem==self.emotionSwithButtonContainer ) {
                [self.emotionEditingVCView removeConstraint:obj];
            }
        }];
        
        __block CGFloat containerHeight=0;
        [self.emotionSwithButtonContainer.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            containerHeight=obj.constant==0?self.emotionSwithButtonContainer.frame.size.height:obj.constant;
            [self.emotionSwithButtonContainer removeConstraint:obj];
        }];
        
        //高度约束
        containerHeight=containerHeight==0?self.emotionSwithButtonContainer.frame.size.height:containerHeight;
        NSLayoutConstraint *heightCos = [NSLayoutConstraint constraintWithItem:self.emotionSwithButtonContainer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0 constant:containerHeight];
        [self.emotionSwithButtonContainer addConstraint:heightCos];
        
        //左边约束
        NSLayoutConstraint *leftCos = [NSLayoutConstraint constraintWithItem:self.emotionSwithButtonContainer attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.emotionEditingVCView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        [self.emotionEditingVCView addConstraint:leftCos];
        
        //底部约束
        NSLayoutConstraint *bottomCos = [NSLayoutConstraint constraintWithItem:self.emotionSwithButtonContainer attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.emotionEditingVCView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-heightToChange];
        [self.emotionEditingVCView addConstraint:bottomCos];
        
        //右边约束
        NSLayoutConstraint *rightCos = [NSLayoutConstraint constraintWithItem:self.emotionSwithButtonContainer attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.emotionEditingVCView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        [self.emotionEditingVCView addConstraint:rightCos];
        
        //        NSLog(@"frame %@",NSStringFromCGRect(self.emotionSwithButtonContainer.frame) );
        [UIView animateWithDuration:animationDuration delay:0.0 options:animationCurve<<16 animations:^{
            [self.emotionEditingVCView layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    }
    //    NSLog(@"frame %@",NSStringFromCGRect(self.emotionSwithButtonContainer.frame) );
    //    NSLog(@"%@",self.emotionSwithButtonContainer.constraints);
    //    NSLog(@"emotionEditingVCView %@",self.emotionEditingVCView.constraints);
}

@end
