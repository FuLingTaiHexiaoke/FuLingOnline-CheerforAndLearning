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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *emotionContainerScrollViewHeight;


//state record
@property(nonatomic, assign) NSRange currentShowingRange;//当前显示的表情组的范围
@property(nonatomic, assign)BOOL isChangingInputView;
@property (assign, nonatomic)  CGFloat lastEmotionViewHeight;

//控制bottombar类型控件的升降外部属性
@property(nonatomic,weak)UITextView *editingTextView;
@property(nonatomic,weak)UIButton* emotionSwithButton;
@property(nonatomic,weak)UIBarButtonItem* emotionSwithBarButtonItem;
@property(nonatomic,weak)UIView *emotionSwithButtonContainer;
@property(nonatomic,weak)UIView *emotionEditingVCView;
@property(nonatomic,assign)BOOL shouldHideToolBar;//作用于约束计算，是否自动隐藏ToolBar输入框
//预留工具箱、语音记录按钮属性
@property(nonatomic,weak)UIButton* toolkitButton;
@property(nonatomic,weak)UIButton* voiceRecordButton;

//自动调整SVO(scrollview.offset)的值，使scrollview中点击的view和ToolBar动态贴紧
@property(nonatomic,assign)BOOL SVO_ShouldAutoOffset;

//models
//@property(nonatomic,strong)NSMutableArray<EmotionGroupDetailModel *>* emotionGroupDetailModels;
@end

@implementation FLXKEmotionBoard

#pragma mark - Public Methods

+(instancetype)sharedEmotionBoardWithEditingTextView:(UITextView *)editingTextView swithButton:(UIButton *)swithButton swithButtonContainer:(UIView *)swithButtonContainer emotionEditingVCView:(UIView *)emotionEditingVCView emotionGroupShowingOption:(EmotionGroupShowingOption)emotionGroupShowingOption  {
    //add emotionGroupOptions
    [FLXKEmotionBoard setEmotionGroupOptions:emotionGroupShowingOption];
    
    FLXKEmotionBoard * sharedEmotionBoard=[FLXKEmotionBoard sharedEmotionBoard];
    sharedEmotionBoard.editingTextView=editingTextView;
    sharedEmotionBoard.emotionSwithButtonContainer=swithButtonContainer;
    sharedEmotionBoard.emotionSwithButton=swithButton;
    sharedEmotionBoard.emotionEditingVCView=emotionEditingVCView;
    //add action
    [sharedEmotionBoard.emotionSwithButton addTarget:sharedEmotionBoard action:@selector(changeInputViewType:) forControlEvents:UIControlEventTouchUpInside];
    sharedEmotionBoard.emotionSwithButton.tag=FLXKEmotionKeyboard;
    
    //    //add emotionGroupOptions
    //    [FLXKEmotionBoard setEmotionGroupOptions:emotionGroupShowingOption];
    
    NSNumber*  lastOptions=( NSNumber* ) FLXKUserDefaultsObjForKey(SelectedEmotionGroupOptionsUserDefaultsKey);
    if (lastOptions.integerValue!=emotionGroupShowingOption) {
        [sharedEmotionBoard.emotionContainerScrollView loadPagesAccordingEmotionGroupOptions];
        [sharedEmotionBoard.emotionGroupIndexCollectionView loadGroupsAccordingEmotionGroupOptions];
        //        [self reloadPages];
    }
    FLXKUserDefaultsSetObjForKey([NSNumber numberWithInteger:emotionGroupShowingOption], SelectedEmotionGroupOptionsUserDefaultsKey);
    FLXKUserDefaultsSynchronize
    
    return sharedEmotionBoard;
}

+(instancetype)sharedEmotionBoardWithEditingTextView:(UITextView *)editingTextView swithButton:(UIButton *)swithButton swithButtonContainer:(UIView *)swithButtonContainer emotionEditingVCView:(UIView *)emotionEditingVCView emotionGroupShowingOption:(EmotionGroupShowingOption)emotionGroupShowingOption shouldHideToolBar:(BOOL)shouldHideToolBar SVO_ShouldAutoOffset:(BOOL)SVO_ShouldAutoOffset{
    FLXKEmotionBoard * sharedEmotionBoard=[FLXKEmotionBoard sharedEmotionBoardWithEditingTextView:editingTextView swithButton:swithButton swithButtonContainer:swithButtonContainer emotionEditingVCView:emotionEditingVCView emotionGroupShowingOption:emotionGroupShowingOption shouldHideToolBar:shouldHideToolBar];
    sharedEmotionBoard.SVO_ShouldAutoOffset=SVO_ShouldAutoOffset;
    return sharedEmotionBoard;
}

+(instancetype)sharedEmotionBoardWithEditingTextView:(UITextView *)editingTextView swithButton:(UIButton *)swithButton swithButtonContainer:(UIView *)swithButtonContainer emotionEditingVCView:(UIView *)emotionEditingVCView emotionGroupShowingOption:(EmotionGroupShowingOption)emotionGroupShowingOption shouldHideToolBar:(BOOL)shouldHideToolBar {
    //add emotionGroupOptions
    [FLXKEmotionBoard setEmotionGroupOptions:emotionGroupShowingOption];
    
    FLXKEmotionBoard * sharedEmotionBoard=[FLXKEmotionBoard sharedEmotionBoard];
    sharedEmotionBoard.editingTextView=editingTextView;
    sharedEmotionBoard.emotionSwithButtonContainer=swithButtonContainer;
    sharedEmotionBoard.emotionSwithButton=swithButton;
    sharedEmotionBoard.emotionEditingVCView=emotionEditingVCView;
    sharedEmotionBoard.shouldHideToolBar=shouldHideToolBar;
    //add action
    [sharedEmotionBoard.emotionSwithButton addTarget:sharedEmotionBoard action:@selector(changeInputViewType:) forControlEvents:UIControlEventTouchUpInside];
    sharedEmotionBoard.emotionSwithButton.tag=FLXKEmotionKeyboard;
    
    //    //add emotionGroupOptions
    //    [FLXKEmotionBoard setEmotionGroupOptions:emotionGroupShowingOption];
    
    NSNumber*  lastOptions=( NSNumber* ) FLXKUserDefaultsObjForKey(SelectedEmotionGroupOptionsUserDefaultsKey);
    if (lastOptions.integerValue!=emotionGroupShowingOption) {
        [sharedEmotionBoard.emotionContainerScrollView loadPagesAccordingEmotionGroupOptions];
        [sharedEmotionBoard.emotionGroupIndexCollectionView loadGroupsAccordingEmotionGroupOptions];
        //        [self reloadPages];
    }
    FLXKUserDefaultsSetObjForKey([NSNumber numberWithInteger:emotionGroupShowingOption], SelectedEmotionGroupOptionsUserDefaultsKey);
    FLXKUserDefaultsSynchronize
    
    return sharedEmotionBoard;
}


-(void)reloadPages{
    [[FLXKEmotionBoard sharedEmotionBoard].emotionContainerScrollView loadPagesAccordingEmotionGroupOptions];
    [[FLXKEmotionBoard sharedEmotionBoard].emotionGroupIndexCollectionView loadGroupsAccordingEmotionGroupOptions];
}

+(void)setEmotionGroupOptions:(EmotionGroupShowingOption)emotionGroupOptions {
    NSMutableString* where=[NSMutableString stringWithFormat:@" where emotionGroupImageType in ( "];
    
    [where appendString:@" 0 "];
    
    if (emotionGroupOptions&EmotionGroup_emoji_text_emotion_image) {
        [where appendString:@",1"];
    }
    if (emotionGroupOptions&EmotionGroup_additonal_text_emotion_image) {
        [where appendString:@",2"];
    }
    if (emotionGroupOptions&EmotionGroup_recent_text_emotion_image) {
        [where appendString:@",3"];
    }
    if (emotionGroupOptions&EmotionGroup_big_static_image) {
        [where appendString:@",4"];
    }
    if (emotionGroupOptions&EmotionGroup_big_gif_image) {
        [where appendString:@",5"];
    }
    [where appendString:@" ) "];
    FLXKUserDefaultsSetObjForKey(where, SelectedEmotionGroupOptionsSQLUserDefaultsKey);
    FLXKUserDefaultsSynchronize;
}


+(instancetype)sharedEmotionBoard{
    static FLXKEmotionBoard* sharedEmotionBoard=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray* nibViews =  [[NSBundle mainBundle] loadNibNamed:@"FLXKEmotionBoard" owner:nil options:nil];
        sharedEmotionBoard=[nibViews objectAtIndex:0];
        
    });
    
    //delete registered notifications
    [[NSNotificationCenter defaultCenter] removeObserver:sharedEmotionBoard];
    //add notification
    [[NSNotificationCenter defaultCenter] addObserver:sharedEmotionBoard selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:sharedEmotionBoard selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    return sharedEmotionBoard;
}

-(void)removeNotifications{
    //delete registered notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [EmotionGroup createTable];
        [EmotionItem createTable];
        [EmotionRecentItems createTable];
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
    self.lastEmotionViewHeight=self.frame.size.height;
    [self setupUIPageControl];
    //    NSLog(@"NSStringFromCGRect self.height: %@",NSStringFromCGRect(self.frame));
    
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    //    BOOL isHeightChanged=self.lastEmotionViewHeight==self.frame.size.height?NO:YES;
    //    if (newSuperview && isHeightChanged) {
    //        self.lastEmotionViewHeight=self.frame.size.height;
    //        [self reloadPages];
    //        self.pageControl.frame = CGRectMake(0, 0, self.pageControlPlaceholder.frame.size.width, self.pageControlPlaceholder.frame.size.height);
    //          NSLog(@"pageControlPlaceholder.frame:%@",NSStringFromCGRect(self.pageControl.frame) );
    //    }
}

-(void)keyboardWillShowNotification:(NSNotification*)notification{
    if (self.editingTextView.inputView) {
        [self.emotionGroupIndexCollectionView selecteItemAtContentOffset:0];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    BOOL isHeightChanged=self.lastEmotionViewHeight==self.frame.size.height?NO:YES;
    if (isHeightChanged) {
        self.lastEmotionViewHeight=self.frame.size.height;
        [self reloadPages];
        self.pageControl.frame = CGRectMake(0, 0, self.pageControlPlaceholder.frame.size.width, self.pageControlPlaceholder.frame.size.height);
        //        NSLog(@"pageControlPlaceholder.frame:%@",NSStringFromCGRect(self.pageControl.frame) );
    }
}

-(void)changeInputViewType:(UIButton *)sender{
    sender.tag= self.editingTextView.inputView?FLXKSystemKeyboard:FLXKEmotionKeyboard;
    InputViewType inputViewType=sender.tag;
    switch (inputViewType) {
        case FLXKSystemKeyboard:
            [self.emotionSwithButton setImage:[UIImage ImageWithName:@"emotion_b_keyboard" ] forState:UIControlStateNormal];
            break;
        case FLXKEmotionKeyboard:
            [self.emotionSwithButton setImage:[UIImage ImageWithName:@"emotion_b_keyboard_system" ] forState:UIControlStateNormal];
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
    
    if (currentShowingRange.length!=0) {
        [_emotionContainerScrollView setCurrentShowingPageIndex:currentShowingRange.location] ;
    }
    
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
    
    //Insert emotion image
    [self.editingTextView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:emotionTextAttachment]
                                                     atIndex:self.editingTextView.selectedRange.location];
    //Move selection location
    self.editingTextView.selectedRange = NSMakeRange(self.editingTextView.selectedRange.location + 1, self.editingTextView.selectedRange.length);
    
    //Reset text style
//    [self resetTextStyle];
    
    //notify to change the height and so on.
    if ([((UIResponder*)self.editingTextView.delegate)  canPerformAction:@selector(textViewDidChange:) withSender:self.editingTextView]) {
            [self.editingTextView.delegate textViewDidChange:self.editingTextView];
    }
}

- (void)insertEmoji:(NSString*)EmojiName{
    //Insert emoji
    [self.editingTextView.textStorage insertAttributedString:[[NSAttributedString alloc] initWithString: EmojiName]
                                                     atIndex:self.editingTextView.selectedRange.location];
    //Move selection location
    self.editingTextView.selectedRange = NSMakeRange(self.editingTextView.selectedRange.location + 2, self.editingTextView.selectedRange.length);
    
    //Reset text style
//    [self resetTextStyle];
    
    //notify to change the height and so on.
//    [self.editingTextView.delegate textViewDidChange:self.editingTextView];
    if ([((UIResponder*)self.editingTextView.delegate)  canPerformAction:@selector(textViewDidChange:) withSender:self.editingTextView]) {
        [self.editingTextView.delegate textViewDidChange:self.editingTextView];
    }
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
    //    NSLog(@"%zd-表情删除-%zd",range.length,range.location);
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
        
        //notify to change the height and so on.
//        [self.editingTextView.delegate textViewDidChange:self.editingTextView];
        if ([((UIResponder*)self.editingTextView.delegate)  canPerformAction:@selector(textViewDidChange:) withSender:self.editingTextView]) {
            [self.editingTextView.delegate textViewDidChange:self.editingTextView];
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
    return    [[FLXKEmotionBoard sharedEmotionBoard].editingTextView.attributedText getPlainString];
}



-(void)setupUIPageControl{
    self.pageControl = [[KYAnimatedPageControl alloc]
                        initWithFrame:CGRectMake(0, 0, self.pageControlPlaceholder.frame.size.width, self.pageControlPlaceholder.frame.size.height)];
    //     NSLog(@"pageControl.frame:%@",NSStringFromCGRect(self.pageControl.frame) );
    self.pageControl.pageCount = 8;
    self.pageControl.unSelectedColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.pageControl.selectedColor = [UIColor colorWithWhite:0.6 alpha:1];
    self.pageControl.bindScrollView = self.emotionContainerScrollView;
    self.pageControl.shouldShowProgressLine = NO;
    self.pageControl.indicatorStyle = IndicatorStyleGooeyCircle;
    self.pageControl.indicatorSize = 10;
    self.pageControl.swipeEnable = YES;
    [self.pageControlPlaceholder addSubview:self.pageControl];
    self.pageControl.didSelectIndexBlock = ^(NSInteger index) {
        //        NSLog(@"Did Selected index : %ld", (long)index);
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
    //remove added notification
    if (self.editingTextView==nil) {
        [self removeNotifications];
    }
    
    //get animation properties
    float animationDuration = [[[notif userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationCurve animationCurve = [[[notif userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    
    //get keyboard frame properties
    CGRect keyboardStartingFrame = [[[notif userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect keyboardEndingFrame = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    float  keyboadStartingHeight =Screen_Height - keyboardStartingFrame.origin.y;
    float  keyboadEndingHeight = Screen_Height- keyboardEndingFrame.origin.y;
    
    //    NSLog(@"keyboardStartingFrame %@",NSStringFromCGRect(keyboardStartingFrame) );
    //    NSLog(@"keyboardEndingFrame %@",NSStringFromCGRect(keyboardEndingFrame) );
    //    NSLog(@"self.frame:%@",NSStringFromCGRect(self.frame) );
    //        NSLog(@"self.emotionContainerScrollViewframe:%@",NSStringFromCGRect(self.emotionContainerScrollView.frame) );
    //    NSLog(@"keyboadStartingHeight: %f",keyboadStartingHeight);
    //    NSLog(@"keyboadEndingHeight: %f",keyboadEndingHeight);
    //    NSLog(@"_emotionContainerScrollViewHeight: %f",_emotionContainerScrollViewHeight.constant);
    
    
    //I do not why this happened,if you know tell me.
    //    if ([NSStringFromCGRect(keyboardStartingFrame) isEqualToString:NSStringFromCGRect(keyboardEndingFrame) ]) {
    //        if (animationDuration!=0 && !self.editingTextView.isFirstResponder) {
    //            [self changeEmotionSwithButtonContainerWithAnimationDuration:animationDuration animationCurve:animationCurve keyboadStartingHeight:keyboadStartingHeight keyboadEndingHeight:keyboadEndingHeight];
    //        }
    //        return;
    //    }
    
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
    CGFloat  heightToChange= keyboadStartingHeight>0?(keyboadStartingHeight<=keyboadEndingHeight?keyboadEndingHeight:0):keyboadEndingHeight;
    
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
        //        Masonry约束是无法更新 NSLayoutConstraint 约束。因为Masonry在更新约束的时候会去遍历查找view上面的约束集，先判断view上的约束的类是否为 MASLayoutConstraint的类，如果是才会进行更新。所以，如果你是用XIB、StoryBoard拉线添加的约束或者是通过代码方式使用NSLayoutConstraint类添加的约束都无法在代码里用Masonry的 mas_updateConstraints 方法进行约束更新
        
        //         __block CGFloat containerHeight=0;
        //        //高度约束
        //        containerHeight=containerHeight==0?self.emotionSwithButtonContainer.frame.size.height:containerHeight;
        //
        //        if (self.shouldHideToolBar) {
        //            heightToChange= heightToChange>200?heightToChange:-100;
        //        }
        //
        //        [UIView animateWithDuration:0.1 delay:0.0 usingSpringWithDamping:10.0 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //            [self.emotionSwithButtonContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        //                make.height.mas_equalTo(containerHeight);
        //                make.bottom.mas_equalTo(((UIViewController*)(self.emotionEditingVCView.nextResponder)).mas_bottomLayoutGuideTop).offset(-heightToChange);
        //            }];
        //            [self.emotionEditingVCView layoutIfNeeded];
        //        } completion:^(BOOL finished) {
        //
        //        }];
        
        //删除以前添加的约束
        [self.emotionEditingVCView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.firstItem==self.emotionSwithButtonContainer ) {
                [self.emotionEditingVCView removeConstraint:obj];
            }
        }];
        
        __block CGFloat containerHeight=0;
        [self.emotionSwithButtonContainer.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.firstAttribute==NSLayoutAttributeHeight) {
                containerHeight=obj.constant==0?self.emotionSwithButtonContainer.frame.size.height:obj.constant;
                [self.emotionSwithButtonContainer removeConstraint:obj];
            }
        }];
        
        
        //高度约束
        containerHeight=containerHeight==0?self.emotionSwithButtonContainer.frame.size.height:containerHeight;
        //        containerHeight=self.emotionSwithButtonContainer.frame.size.height;
        NSLayoutConstraint *heightCos = [NSLayoutConstraint constraintWithItem:self.emotionSwithButtonContainer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0 constant:containerHeight];
        [self.emotionSwithButtonContainer addConstraint:heightCos];
        
        //左边约束
        NSLayoutConstraint *leftCos = [NSLayoutConstraint constraintWithItem:self.emotionSwithButtonContainer attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.emotionEditingVCView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        [self.emotionEditingVCView addConstraint:leftCos];
        
        if (self.shouldHideToolBar) {
            heightToChange= heightToChange>200?heightToChange:-200;
        }
        else{
            heightToChange= heightToChange>200?heightToChange:0;
        }
        //底部约束
        NSLayoutConstraint *bottomCos = [NSLayoutConstraint constraintWithItem:self.emotionSwithButtonContainer attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:((UIViewController*)(self.emotionEditingVCView.nextResponder)).bottomLayoutGuide attribute:NSLayoutAttributeTop multiplier:1.0 constant:-heightToChange];
        [self.emotionEditingVCView addConstraint:bottomCos];
        
        //右边约束
        NSLayoutConstraint *rightCos = [NSLayoutConstraint constraintWithItem:self.emotionSwithButtonContainer attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.emotionEditingVCView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        [self.emotionEditingVCView addConstraint:rightCos];
        
        //宽度约束
        NSLayoutConstraint *widthCos = [NSLayoutConstraint constraintWithItem:self.emotionSwithButtonContainer attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.emotionEditingVCView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
        [self.emotionEditingVCView addConstraint:widthCos];
        
        [UIView animateWithDuration:0.1 delay:0.0 options:animationCurve<<16 animations:^{
            [self.emotionEditingVCView layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
        
        
        //按钮和ToolBar贴紧操作
        if (heightToChange>0    &&  _SVO_ShouldAutoOffset) {//显示的时候才调整tableview.offset
            //获取SVO_TapedView在KeyWindow中的Rect
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            CGFloat   toolBarY  = Screen_Height-containerHeight-heightToChange;
            CGRect   tapedViewFrame  = [_SVO_TapedView convertRect:_SVO_TapedView.bounds toView:keyWindow];
            CGFloat   tapedViewY  = tapedViewFrame.origin.y+tapedViewFrame.size.height;
            //计算偏差
            CGFloat relativeLenght=toolBarY-tapedViewY;
            CGPoint offset=_SVO_ScrollView.contentOffset;
            offset.y -= relativeLenght;
            //根据偏差进行位移
            if (offset.y < 0) {
                offset.y = 0;
            }
            [_SVO_ScrollView setContentOffset:offset animated:YES];
        }
    }
    

}

@end
