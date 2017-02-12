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
//#import "EmojiTextAttachment.h"
#import "EmotionTextAttachment.h"
#import "NSAttributedString+EmotionExtension.h"
#import "UIImage+GIF.h"
#import "FLXKEmotionConfig.h"
#import "KYAnimatedPageControl.h"
//entity
#import "EmotionGroup.h"
#import "EmotionItem.h"
#import "EmotionRecentItems.h"

//models
#import "EmotionGroupDetailModel.h"

@interface FLXKEmotionBoard ()<UIScrollViewDelegate,FLXKEmotionShowingScrollViewDelegate,FLXKEmotionGroupIndexCollectionViewDelegate>
//@property(nonatomic)UIPageControl* pageControl;
@property(nonatomic,strong)NSMutableArray *faces;
@property(nonatomic,strong)UIScrollView *faceScroll;
@property(nonatomic,strong)UITextView *editingTextView;
@property(nonatomic,strong)UIView *swithButtonContainer;
@property(nonatomic,strong)UIView *swithButton;

//IBOutlet views
@property (weak, nonatomic) IBOutlet UIView *pageControlPlaceholder;
@property (strong, nonatomic) KYAnimatedPageControl *pageControl;
@property (weak, nonatomic) IBOutlet FLXKEmotionShowingScrollView *emotionContainerScrollView;
@property (weak, nonatomic) IBOutlet FLXKEmotionGroupIndexCollectionView *emotionGroupIndexCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *leftBottomButton;
@property (weak, nonatomic) IBOutlet UIButton *rightBottomButton;

//models
@property(nonatomic,strong)NSMutableArray<EmotionGroupDetailModel *>* emotionGroupDetailModels;

//state record
@property(nonatomic, assign) NSRange currentShowingRange;//当前显示的表情组的范围


@end

@implementation FLXKEmotionBoard

#pragma mark - Public Methods

+(instancetype)sharedEmotionBoardWithEditingTextView:(UITextView *)editingTextView swithButtonContainer:(UIView *)swithButtonContainer swithButton:(UIView *)swithButton{
    FLXKEmotionBoard * sharedEmotionBoard=[FLXKEmotionBoard sharedEmotionBoard];
    sharedEmotionBoard.editingTextView=editingTextView;
    sharedEmotionBoard.swithButtonContainer=swithButtonContainer;
    sharedEmotionBoard.swithButton=swithButton;
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
        
        //        NSString *path=[[NSBundle mainBundle] pathForResource:@"expression" ofType:@"plist"];
        //        NSDictionary *faceDic=[NSDictionary dictionaryWithContentsOfFile:path];
        //        NSArray<NSString*>* a=[faceDic allValues];
        //        NSMutableString* b=[NSMutableString string];
        //        for (int i=0; i<a.count; i++) {
        //              [b appendString:[NSString stringWithFormat:@"%@\n",a[i]]];
        //        }
        //         NSLog(@"%@\n", b);
        NSLog(@"NSStringFromCGRect self.height: %@",NSStringFromCGRect(self.frame));

        //添加键盘弹出-隐藏通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];

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


-(void)keyboardDidShowNotification:(NSNotification*)notification{
    if (self.editingTextView.inputView) {
        [self.emotionGroupIndexCollectionView selecteItemAtContentOffset:0];
    }
}

//-(void)setDelegateForSubViewsInScrollView{
//_emotionContainerScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//    <#code#>
//}
//}

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

//读取表情配置文件生成models
-(NSMutableArray<EmotionGroupDetailModel *>*)emotionGroupDetailModels{
    NSMutableArray<EmotionGroupDetailModel *>* emotionGroupDetailModels=[NSMutableArray array];
    [[EmotionGroup selectAll]enumerateObjectsUsingBlock:^(EmotionGroup * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        EmotionGroupDetailModel * model=[[EmotionGroupDetailModel alloc]init];
        model.groupId=obj.id;
        model.groupName=obj.emotionGroupName;
        model.groupImageUrl=obj.emotionGroupImageUrl;
        [emotionGroupDetailModels addObject:model];
    }];
    return emotionGroupDetailModels;
}


- (void)insertEmotion:(NSInteger)emotionID emotionName:(NSString*)emotionName imageName:(NSString*)imageName{
    //Create emoji attachment
    EmotionTextAttachment *emotionTextAttachment = [EmotionTextAttachment new];
    
    //Set tag and image
    emotionTextAttachment.emotionName =emotionName;

    emotionTextAttachment.image = [UIImage ImageWithName:imageName];
//  emotionTextAttachment.image = [UIImage sd_animatedGIFNamed:imageName];
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
    //Insert emoji image
    NSLog(@"location:%lu", (unsigned long)self.editingTextView.selectedRange.location);
    NSLog(@"length:%lu", (unsigned long)self.editingTextView.textStorage.length);
    //    [self.editingTextView.textStorage insertAttributedString:[[NSAttributedString alloc] initWithString: EmojiName]
    [self.editingTextView.textStorage insertAttributedString:[[NSAttributedString alloc] initWithString: EmojiName]
                                                     atIndex:self.editingTextView.selectedRange.location];
    //Move selection location
    self.editingTextView.selectedRange = NSMakeRange(self.editingTextView.selectedRange.location + 2, self.editingTextView.selectedRange.length);
    
    NSLog(@"location:%lu", (unsigned long)self.editingTextView.selectedRange.location);
    NSLog(@"length:%lu", (unsigned long)self.editingTextView.textStorage.length);
    
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
    //    if (self.editingTextView.selectedRange.location>0) {
    //        if (self.editingTextView.selectedRange.location==self.editingTextView.textStorage.length) {
    //            NSRange deleteRange=NSMakeRange(self.editingTextView.selectedRange.location-2, 2);
    //            [self.editingTextView.textStorage  deleteCharactersInRange:deleteRange];
    //        }
    //        else{
    //            NSRange deleteRange=NSMakeRange(self.editingTextView.selectedRange.location-2, 2);
    //            [self.editingTextView.textStorage  deleteCharactersInRange:deleteRange];
    //            self.editingTextView.selectedRange = NSMakeRange(self.editingTextView.selectedRange.location-2, self.editingTextView.selectedRange.length);
    //        }
    //    }
    
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
 *  计算选中的最后一个是字符还是表情所占长度
 *
 *  @param str 要计算的字符串
 *
 *  @return 返回一个 NSRange
 */
- (NSRange)lastRange:(NSString *)str {
    NSRange lastRange = [str rangeOfComposedCharacterSequenceAtIndex:str.length-1];
    return lastRange;
}

+(NSString*)getPlainTextString{
    return    [[FLXKEmotionBoard sharedEmotionBoard].editingTextView.attributedText getPlainStringtest];
}



-(void)setupUIPageControl{
    //    //setup the pagecontroller
    //    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-20, self.frame.size.width,20)];
    //    //    pageControl.numberOfPages = 6; // 一共显示多少个圆点（多少页）
    //    // 设置非选中页的圆点颜色
    //    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    //    // 设置选中页的圆点颜色
    //    pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    //    // 禁止默认的点击功能
    //    pageControl.enabled = YES;
    //    [self addSubview:pageControl];
    //    _pageControl = pageControl;
//    self.pageControlPlaceholder.superview.frame
    NSLog(@"self.pageControlPlaceholder.superview.frame:%@", NSStringFromCGRect(self.pageControlPlaceholder.superview.frame));
    
 CGRect frame=  [self.pageControlPlaceholder convertRect:self.pageControlPlaceholder.frame toView:self];
//        NSLog(@"frame1:%@", NSStringFromCGRect(frame));
//    
//   frame=  [self convertRect:self.pageControlPlaceholder.superview.frame toView:self];
//    NSLog(@"frame2:%@", NSStringFromCGRect(frame));
//
//    frame=  [self.pageControlPlaceholder convertRect:self.pageControlPlaceholder.frame toView:self];
//    NSLog(@"frame3:%@", NSStringFromCGRect(frame));
//    
//    frame=  [self.pageControlPlaceholder.superview convertRect:self.pageControlPlaceholder.frame toView:self];
//    NSLog(@"frame4:%@", NSStringFromCGRect(frame));
    
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

#pragma mark-- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self changePageControlShowing];
    
//    [self.emotionGroupIndexCollectionView selectedItemAtIndexPath:];
//    if (scrollView.dragging || scrollView.isDecelerating || scrollView.tracking) {
//        //背景线条动画
//        [self.pageControl.pageControlLine
//         animateSelectedLineWithScrollView:scrollView];
//    }
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



//初始化表情视图
-(id)initWithFrame:(CGRect)frame editingTextView:(UITextView*)editingTextView containerView:(UIView*)containerView{
    
    float addY=0.0;
    if (isIOS7) {
        addY=20.0;
    }
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        
        NSString *path=[[NSBundle mainBundle] pathForResource:@"expression" ofType:@"plist"];
        NSDictionary *faceDic=[NSDictionary dictionaryWithContentsOfFile:path];
        
        NSMutableArray *temp=[[NSMutableArray alloc] init];
        for (int i = 0;i<105;i++){
            NSMutableString *mstr=[[NSMutableString alloc] initWithString:@"smiley_"];
            UIImage *face = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d.png",mstr,i]];
            NSMutableDictionary *dicFace = [NSMutableDictionary dictionary];
            NSString *key1=[NSString stringWithFormat:@"%@%d",mstr,i];
            NSString *key2=[NSString stringWithFormat:@"(%@)",[faceDic objectForKey:key1]];
            [dicFace setValue:face forKey:key2];
            [temp addObject:dicFace];
        }
        self.faces = temp;
        self.faceScroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.faceScroll.backgroundColor=[UIColor whiteColor];
        self.faceScroll.scrollEnabled=YES;
        self.faceScroll.showsHorizontalScrollIndicator=NO;
        self.faceScroll.showsVerticalScrollIndicator=NO;
        self.faceScroll.pagingEnabled=YES;
        self.faceScroll.delegate=self;
        [self addSubview:self.faceScroll];
        
        [self setupUIPageControl];
//        [self drawEmotionViews];
        
        self.editingTextView=editingTextView;
        
        //get swithButton.container
        self.swithButtonContainer=containerView;
        //set textview focused
        self.editingTextView.inputView=self;
        //添加键盘弹出-隐藏通知
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}


#pragma mark - changeKeyBoard
//- (void)changeKeyboardType:(InputViewType)type
//{
//    switch (type)
//    {
//        case KeyboardSystem:
//        {
//            self.internalTextView.inputView = nil;
//            break;
//        }
//        case KeyboardFunction:
//        {
//            self.internalTextView.inputView = self.functionKeyboard;
//            break;
//        }
//        case KeyboardEmotion:
//        {
//            self.internalTextView.inputView = self.faceKeyboard;
//            break;
//        }
//        default:
//            break;
//    }
//    //    [self.inputView removeFromSuperview];
//
//
//    if (self.isFirstResponder)
//    {
//        [self.internalTextView reloadInputViews];
//    }else
//    {
//        [self.internalTextView becomeFirstResponder];
//    }
//}


////draw the emotion views and add to srollview
//-(void)drawEmotionViews{
//    float width=  CGRectGetWidth(self.frame);
//    float height= CGRectGetHeight(self.frame);
//    float face_width=32;
//    float face_height=32;
//    //caculator out how many page shoulb be
//    int totalFaceCount= self.faces.count;
//    //how many face one row can contain
//    int eachRowFaceCount=(width-20)/face_width;
//    //how many  row can be
//    int totalRowCount=totalFaceCount/eachRowFaceCount+1;
//    //how many  rows can be in each view
//    int rowsInEachView=(height-20)/(face_height);
//    //
//    int pageCount=totalRowCount%rowsInEachView?totalRowCount/rowsInEachView+1:totalRowCount/rowsInEachView;
//    
//    int i=0;//rowIndex
//    int j=0;//faceIndex
//    //    //start to splite the faces into each view
//    for (int pageindex=0; pageindex<pageCount; pageindex++) {
//        UIView* page=[[UIView alloc]initWithFrame:CGRectMake(5+pageindex*(width),0, (width), height-30)];
//        for ( ; i<totalRowCount && i<(pageindex+1)*rowsInEachView; i++) {
//            for (int j=0; j<eachRowFaceCount && ((i*eachRowFaceCount)+j)<totalFaceCount; j++) {
//                //
//                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//                button.frame = CGRectMake(10 + j*32, 10 + (i%rowsInEachView)*32, 32.0f, 32.0f);
//                NSMutableDictionary *tempdic = [self.faces objectAtIndex:((i*eachRowFaceCount)+j)];
//                NSString *key=[[tempdic allKeys] objectAtIndex:0];
//                
//                UIImage *tempImage = [tempdic valueForKey:key];
//                [button setBackgroundImage:tempImage forState:UIControlStateNormal];
//                
//                button.tag = ((i*eachRowFaceCount)+j);
//                
//                [button addTarget:self action:@selector(didSelectAFace:)forControlEvents:UIControlEventTouchUpInside];
//                
//                [page addSubview:button];
//                
//            }//for (int j=0; j<eachRowFaceCount;
//            
//            
//        }//for (int i=0; i<rowsInEachView; i++)
//        
//        [self.faceScroll addSubview:page];
//        
//    }// for (int pageindex=0; pageindex<pageCount; pageCount++)
//    
//    
//    self.pageControl.numberOfPages=pageCount;
//    [self.faceScroll setContentSize:CGSizeMake(pageCount*width, height)];
//    
//}

#pragma mark scrollDelegate


//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    [self setPageNumOfPageControl:scrollView];
//}
//
//- (void)setPageNumOfPageControl:(UIScrollView *)scrollView{
//    //see which page should be
//    float scrollOffset=scrollView.contentOffset.x;
//    float curentPage=scrollOffset/scrollView.frame.size.width;
//    float mode=((int)scrollOffset)%((int)scrollView.frame.size.width);
//    //set numberpage
//    if (mode>0.5) {
//        self.pageControl.currentPage=curentPage+1;
//    }else{
//        self.pageControl.currentPage=curentPage;
//    }
//}






#pragma mark Keyboard
//-(void)keyboardWillChangeFrame:(NSNotification*)notif{
//    NSLog(@"keyboardChange:%@",[notif userInfo]);
//    float keyboadHeightBegin = 0;
//    float keyboadHeightEnd = 0;
//
//    float animationDuration = [[[notif userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    UIViewAnimationCurve animationCurve = [[[notif userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
//
//    CGRect keyboardBeginFrame = [[[notif userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    CGRect keyboardEndFrame = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    keyboadHeightBegin =[UIApplication sharedApplication].keyWindow.height - keyboardBeginFrame.origin.y;
//    keyboadHeightEnd = [UIApplication sharedApplication].keyWindow.height - keyboardEndFrame.origin.y;
//
//    NSLog(@"keyboardHeightChangeFrom:%.2f,To:%.2f",keyboadHeightBegin,keyboadHeightEnd);
//    if (keyboadHeightBegin>0) {
//        [UIView animateWithDuration:animationDuration delay:0.0 options:animationCurve<<16 animations:^{
//            self.swithButtonContainer.top=self.swithButtonContainer.top+keyboadHeightBegin;
//        } completion:^(BOOL finished) {
//        }];
//    }
//    else{
//        [UIView animateWithDuration:animationDuration delay:0.0 options:animationCurve<<16 animations:^{
//            self.swithButtonContainer.top=self.swithButtonContainer.top-keyboadHeightEnd;
//        } completion:^(BOOL finished) {
//        }];
//    }
//}
@end
