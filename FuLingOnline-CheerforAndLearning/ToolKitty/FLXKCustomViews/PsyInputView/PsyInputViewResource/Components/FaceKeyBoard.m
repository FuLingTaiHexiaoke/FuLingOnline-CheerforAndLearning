//
//  FaceKeyBoardView.m
//  MyKeyboard
//
//  Created by 张鹏 on 15/12/29.
//  Copyright © 2015年 张鹏. All rights reserved.
//

#import "FaceKeyBoard.h"

@interface FaceKeyBoard ()

@property(nonatomic,strong) NSManagedObjectContext * managedObjectContext;
@property (nonatomic,strong) UIScrollView * faceScrollView;
@property (nonatomic,strong) UIScrollView * historyFaceScrollView;
@property (nonatomic,strong) UIScrollView * functionScrollView;
@property (nonatomic,strong) UIButton *deleteButton;//删除按钮

@end

@implementation FaceKeyBoard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupMoudle];
    }
    return self;
}
- (void)dealloc
{
    NSLog(@"%@ is dealloc",[self class]);
}
#pragma mark - 初始化界面
- (void)setupMoudle
{
    // 初始化表情界面
    self.faceScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-40)];
    self.faceScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.faceScrollView.pagingEnabled = YES;
    [self addSubview:self.faceScrollView];
    
    //初始化历史表情界面
    self.historyFaceScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-40)];
    self.historyFaceScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.historyFaceScrollView.pagingEnabled = YES;
    [self addSubview:self.historyFaceScrollView];
    //历史界面默认隐藏
    self.historyFaceScrollView.hidden = YES;
    
    //初始化工具条
    self.functionScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-40, self.bounds.size.width, 40)];
    self.functionScrollView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.functionScrollView];
    
//    //初始化工具条sc上的按钮
    UIButton * historyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    historyButton.frame = CGRectMake(0, 0, self.bounds.size.width/3, 40);
    historyButton.backgroundColor = [UIColor redColor];
    [historyButton setTitle:@"历史" forState:UIControlStateNormal];
    [historyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    historyButton.tag = 1;
    [self.functionScrollView addSubview:historyButton];
//    [historyButton addTarget:self action:@selector(tapFunctionSCButton:) forControlEvents:UIControlEventTouchUpInside];
//    
    UIButton * systemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    systemButton.frame = CGRectMake(self.bounds.size.width/3, 0, self.bounds.size.width/3, 40);
    systemButton.backgroundColor = [UIColor yellowColor];
    [systemButton setTitle:@"默认" forState:UIControlStateNormal];
    [systemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    systemButton.tag = 2;
    [self.functionScrollView addSubview:systemButton];
//    [systemButton addTarget:self action:@selector(tapFunctionSCButton:) forControlEvents:UIControlEventTouchUpInside];
//    
    UIButton * sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(self.bounds.size.width/3 * 2, 0, self.bounds.size.width/3, 40);
    sendButton.backgroundColor = [UIColor greenColor];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sendButton.tag = 3;
    [self.functionScrollView addSubview:sendButton];
//    [sendButton addTarget:self action:@selector(tapFunctionSCButton:) forControlEvents:UIControlEventTouchUpInside];
//    


    //    [self addObserver:self forKeyPath:@"faceKeyboadDataSource" options:NSKeyValueObservingOptionNew context:nil];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    // 获取需要展示的表情的个数
//    NSInteger count = [self.faceKeyboadDataSource numberOfFaceItemsInFaceKeyboard:self];
//    // 计算所需页数
//    int pages = ceil(count/31.0);
//    self.faceScrollView.contentSize = CGSizeMake(self.bounds.size.width * pages, self.bounds.size.height);
//    
//    for (int i = 0; i < count; i++)
//    {
//        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.tag = i;
//        //确定button位置
//        //1.在哪一页
//        int section = (int)button.tag / 31;
//        //2.在哪一页第几个
//        int index = button.tag % 31;
//        //3.在第几行
//        int row = index / 8;
//        //4.在第几列
//        int cloumn = index % 8;
//        
//        CGFloat w = self.bounds.size.width;
//        CGFloat buttonW = w / 8.0;
//        CGFloat x = w * section + buttonW * cloumn;
//        CGFloat y = buttonW * row;
//        
//        button.frame = CGRectMake(x, y, buttonW, buttonW);
//        
//        [button addTarget:self action:@selector(tapFaceButton:) forControlEvents:UIControlEventTouchUpInside];
//        
//        UIImage * image = [self.faceKeyboadDataSource faceKeyBoard:self faceImageWithIndex:button.tag];
//        
//        [button setImage:image forState:UIControlStateNormal];
//        
//        [self.faceScrollView addSubview:button];
//        
//        //添加删除按钮
//        CGFloat deleteButtonX = self.bounds.size.width * section + 7 * buttonW+5;
//        self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(deleteButtonX, 3*buttonW+5, buttonW-15, buttonW-15)];
//        [self.deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
//        //button圆角
//        [self.deleteButton.layer setMasksToBounds:YES];
//        [self.deleteButton.layer setCornerRadius:8];
//        
//        [self.deleteButton addTarget:self action:@selector(tapDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [self.faceScrollView addSubview:self.deleteButton];
//    }
//}

#pragma mark 点击表情的方法
//- (void)tapFaceButton:(UIButton *)sender
//{
//    if ([self.faceKeyboadDelegate respondsToSelector:@selector(faceKeyBoard:didTapFaceItemsAtIndex:)])
//    {
//        [self.faceKeyboadDelegate faceKeyBoard:self didTapFaceItemsAtIndex:sender.tag];
//    }
//}

#pragma mark - 删除button的方法
-(void)tapDeleteButton:(UIButton *)button
{
    if ([self.faceKeyboadDelegate respondsToSelector:@selector(faceKeyBoard:didTapDeleteButton:)])
    {
        [self.faceKeyboadDelegate faceKeyBoard:self didTapDeleteButton:button];
    }
}


#pragma mark 点击工具条上按钮的方法
- (void)tapFunctionSCButton:(UIButton *)sender
{
    NSLog(@"===========%ld",sender.tag);
    switch (sender.tag)
    {
//        case 1://历史表情
//        {
//            self.faceScrollView.hidden = YES;
//            self.historyFaceScrollView.hidden = NO;
//            
//            // 从数据库中获取保存的表情
//            UIApplication * app = [UIApplication sharedApplication];
//            id delegate = app.delegate;
//            self.managedObjectContext = [delegate managedObjectContext];
//            
//            NSFetchRequest * request = [[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([RecentFaces class])];
//            NSSortDescriptor * sortD = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
//            [request setSortDescriptors:@[sortD]];
//            NSArray * results = [self.managedObjectContext executeFetchRequest:request error:nil];
//            // 重新战士新的历史表情时需要把之前的表情从其父视图中移除（historyFaceScrollView）
//            NSArray * subViews = self.historyFaceScrollView.subviews;
//                        for (UIView * tempView in subViews)
//                        {
//                            [tempView removeFromSuperview];
//                        }
//            // 移除所有子视图
////            [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//            
//            for (int j = 0; j < results.count; j++)
//            {
//                UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//                RecentFaces * rencent;
//                rencent = results[j];
//                button.tag = [rencent.faceIndex intValue];
//                //确定当前button的位置
//                //1.在哪一页
//                int section = j / 31;
//                //2.在哪一页第几个
//                int index = j % 31;
//                //3.在第几行
//                int row = index / 8;
//                //4.在第几列
//                int cloumn = index % 8;
//                
//                CGFloat w = self.bounds.size.width;
//                CGFloat buttonW = w / 8.0;
//                CGFloat x = w * section + buttonW * cloumn;
//                CGFloat y = buttonW * row;
//                
//                button.frame = CGRectMake(x, y, buttonW, buttonW);
//                
//                [button addTarget:self action:@selector(tapFaceButton:) forControlEvents:UIControlEventTouchUpInside];
//                
//                UIImage * image = [self.faceKeyboadDataSource faceKeyBoard:self faceImageWithIndex:button.tag];
//                
//                [button setImage:image forState:UIControlStateNormal];
//                
//                [self.historyFaceScrollView addSubview:button];
//                
//                //添加删除按钮
//                CGFloat deleteButtonX = self.bounds.size.width * section + 7 * buttonW+5;
//                self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(deleteButtonX, 3*buttonW+5, buttonW-15, buttonW-15)];
//                [self.deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
//                //button圆角
//                [self.deleteButton.layer setMasksToBounds:YES];
//                [self.deleteButton.layer setCornerRadius:8];
//                
//                [self.deleteButton addTarget:self action:@selector(tapDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
//                
//                [self.historyFaceScrollView addSubview:self.deleteButton];
//
//            }
//            break;
//        }
//            
//        case 2:
//        {
//            self.faceScrollView.hidden = NO;
//            self.historyFaceScrollView.hidden = YES;
//            break;
//        }
//            
//        case 3:
//        {
//            
//            if (self.faceKeyboardBlock) {
//                self.faceKeyboardBlock(sender.tag);
//            }
//            break;
//        }
//        default:
//            break;
    }
}




@end
