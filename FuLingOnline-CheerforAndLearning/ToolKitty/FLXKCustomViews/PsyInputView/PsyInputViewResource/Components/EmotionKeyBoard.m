//
//  FaceViewController.m
//  psylife
//
//  Created by 肖科 on 16/9/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "EmotionKeyBoard.h"

@interface EmotionKeyBoard ()<UIScrollViewDelegate>
@property(nonatomic)UIPageControl* pageControl;

@end

@implementation EmotionKeyBoard
@synthesize faces=_faces;
@synthesize faceScroll=_faceScroll;

-(id)initWithFrame:(CGRect)frame{
    
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
    [self drawEmotionViews];
          }
    return self;
}

-(void)didSelectAFace:(id)sender
{
    UIButton *tempbtn = (UIButton *)sender;
    NSMutableDictionary *tempdic = [self.faces objectAtIndex:tempbtn.tag];
    NSArray *temparray = [tempdic allKeys];
    NSString *faceStr= [NSString stringWithFormat:@"%@",[temparray objectAtIndex:0]];
//    self.clickEmotionBlock(faceStr);
        self.clickEmotionBlock(faceStr,[NSString stringWithFormat:@"smiley_%ld.png",(long)tempbtn.tag]);
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    if  (interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown||interfaceOrientation==UIInterfaceOrientationPortrait){
//        return YES;
//    }
//    
//    return NO;
//}
-(void)setupUIPageControl{
    //setup the pagecontroller
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-20, self.frame.size.width,20)];
    //    pageControl.numberOfPages = 6; // 一共显示多少个圆点（多少页）
    // 设置非选中页的圆点颜色
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    // 设置选中页的圆点颜色
    pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    // 禁止默认的点击功能
    pageControl.enabled = YES;
    [self addSubview:pageControl];
    _pageControl = pageControl;
    
}

//draw the emotion views and add to srollview
-(void)drawEmotionViews{
    float width=  CGRectGetWidth(self.frame);
    float height= CGRectGetHeight(self.frame);
    float face_width=32;
    float face_height=32;
    //caculator out how many page shoulb be
    int totalFaceCount= self.faces.count;
    //how many face one row can contain
    int eachRowFaceCount=(width-20)/face_width;
    //how many  row can be
    int totalRowCount=totalFaceCount/eachRowFaceCount+1;
    //how many  rows can be in each view
    int rowsInEachView=(height-20)/(face_height);
    //
    int pageCount=totalRowCount%rowsInEachView?totalRowCount/rowsInEachView+1:totalRowCount/rowsInEachView;
    
    int i=0;//rowIndex
    int j=0;//faceIndex
    //    //start to splite the faces into each view
    for (int pageindex=0; pageindex<pageCount; pageindex++) {
        UIView* page=[[UIView alloc]initWithFrame:CGRectMake(5+pageindex*(width),0, (width), height-30)];
//        NSLog(@"faceScrollFrame:%@",NSStringFromCGRect(self.faceScroll.frame));
//        NSLog(@"pageFrame:%@",NSStringFromCGRect(page.frame));
        for ( ; i<totalRowCount && i<(pageindex+1)*rowsInEachView; i++) {
            for (int j=0; j<eachRowFaceCount && ((i*eachRowFaceCount)+j)<totalFaceCount; j++) {
                //
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(10 + j*32, 10 + (i%rowsInEachView)*32, 32.0f, 32.0f);
                NSMutableDictionary *tempdic = [self.faces objectAtIndex:((i*eachRowFaceCount)+j)];
                NSString *key=[[tempdic allKeys] objectAtIndex:0];
                
                UIImage *tempImage = [tempdic valueForKey:key];
                [button setBackgroundImage:tempImage forState:UIControlStateNormal];
                
                button.tag = ((i*eachRowFaceCount)+j);
                
                [button addTarget:self action:@selector(didSelectAFace:)forControlEvents:UIControlEventTouchUpInside];
                
                [page addSubview:button];
                //                NSLog(@"i:%d j:%d",i,j);
                //
            }//for (int j=0; j<eachRowFaceCount;
            
            
        }//for (int i=0; i<rowsInEachView; i++)
        
        [self.faceScroll addSubview:page];
        
    }// for (int pageindex=0; pageindex<pageCount; pageCount++)
    
    
    self.pageControl.numberOfPages=pageCount;
    [self.faceScroll setContentSize:CGSizeMake(pageCount*width, height)];
    
}

#pragma mark scrollDelegate


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self setPageNumOfPageControl:scrollView];
}



- (void)setPageNumOfPageControl:(UIScrollView *)scrollView{
    //see which page should be
    float scrollOffset=scrollView.contentOffset.x;
    float curentPage=scrollOffset/scrollView.frame.size.width;
    float mode=((int)scrollOffset)%((int)scrollView.frame.size.width);
    //set numberpage
    if (mode>0.5) {
        self.pageControl.currentPage=curentPage+1;
    }else{
        self.pageControl.currentPage=curentPage;
    }
}

@end
