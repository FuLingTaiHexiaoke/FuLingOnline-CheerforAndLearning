//
//  FLXKtestTableViewController.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by xiaoke on 17/5/6.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKtestTableViewController.h"
#import "FLXKtestTableViewCell.h"

#import "FLXKHttpRequestModelHelper.h"

#import "FLXKSharingCellModel.h"

@interface FLXKtestTableViewController ()
//@property(nonatomic)NSArray* model;
@property (strong, nonatomic)NSArray<FLXKSharingCellModel *> *  model;
@end

@implementation FLXKtestTableViewController{
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
    UIFont *_font;
    UIFont *_subFont;

    NSTimeInterval _llll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight=100;

//    [self.tableView registerNib:[UINib nibWithNibName:@"FLXKtestTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FLXKtestTableViewCell"];

    [self.tableView registerClass:NSClassFromString(@"FLXKtestTableViewCell") forCellReuseIdentifier:@"FLXKtestTableViewCell"];

    [self setupFLXKSharingCellModel];

    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];

//    self.model=@[@"Dispose of any resources that can be recreated Dispose of any resources that can be recreatedDispose of any resources that can be recreatedDispose of any resources that can be recreatedDispose of any resources that can be recreated",
//                    @"Dispose oecreatedDispose of any resources that can be recreatedDispose of any resources that can be recreated",
//                    @"Dispose oecreatedDispose of any resources that can be recreatedDispose of any resources that can be recreated",
//                    @"Dispose oecreatedDispose of any resources that can be recreatedDispose of any resources that can be recreated",
//                    @"Dispose oecreatedDispose of any resources that can be recreatedDispose of any resources that can be recreated",
//                    @"Dispose oecreatedDispose of any resources that can be recreatedDispose of any resources that can be recreated",
//                    @"Dispose oecreatedDispose of any resources that can be recreatedDispose of any resources that can be recreated",
//                    @"Dispose oecreatedDispose of any resources that can be recreatedDispose of any resources that can be recreated",
//                 @"Dispose of any resources that can",
//@"Dispose of any resources that can be recreated Dispose of any resources that can be re",
//@"Dispose of any resourcesources that can be recreatedDispose of any resources that can be recreatedDispose of any resources that can be recreated",
//                 @"Dispose oecreatedDispose of any resources that can be recreatedDispose of any resources that can be recreated",
//                 @"Dispose of any resources that can be recreated Dispose of any resources that can be recreatedDispose of any resources that can be recreatedDispose of any resources that can be recreatedDispose of any resources that can be recreated",
//                 @"Dispose of any resources that can be recreated Dispose of any resources that can be recreatedDispose of any resources that can be recreatedDispose of any resources that can be recreatedDispose of any resources that can be recreated",
//                 @"Dispose of any resources that can be recreated Dispose of any resources that can be recreatedDispose of any resources that can be recreatedDispose of any resources that can be recreatedDispose of any resources that can be recreated"
//                 @"Dispose of any resources that can be recreated Dispose of any resources that can be Dispose of any resources that can be recreated Dispose of any resources that can be recreatedDispose of any resources that can be recreatedDispose  Dispose of any resources that can be recreated Dispose of any resources that can be recreatedDispose of any resources that can be recreatedDispose recreatedDispose of any resources that can be recreatedDispose of any resources that can be recreatedDispose of any resources that can be recreated"
//                 @"Dispose of any resources that can be recreated Dispose of any resources that can be recreatedDispose of any resources that can be recreatedDispose Dispose of any resources that can be recreated Dispose of any resources that can be recreatedDispose of any resources that can be recreatedDispose  of any resources that can be recreatedDispose of any resources that can be recreated"
//
//                 ];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.model.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FLXKtestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FLXKtestTableViewCell" forIndexPath:indexPath];
    if (!cell) {
          NSLog(@"cell 生成了");
        cell = [[FLXKtestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FLXKtestTableViewCell"];
    }
    else{
//        NSLog(@"cell 重用了");
        //        cell.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    }
//    cell.bounds = CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 10000);
    [cell setModel:self.model[indexPath.row]];
//    [cell layoutIfNeeded];
    
    return cell;
}



-(void)setupFLXKSharingCellModel{

    [[FLXKHttpRequestModelHelper registerSuccessCallback:^(id obj) {
        if (obj) {
            _model=(NSArray<FLXKSharingCellModel *> *)obj;
            [self.tableView reloadData];
        }
    } failureCallback:^(NSError *err) {
        //        NSAssert(!err, err.description);
    }] getFriendSharingModelWithCondition:@{@"page":@1,@"userID":[FLXKSharedAppSingleton sharedSingleton].sharedUser.login_name?:@"test"}];

}
- (void)tick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }

    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;

    CGFloat progress = fps / 60.0;
//    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
//
//    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];

    NSString* fps1=  [NSString stringWithFormat:@"%d FPS",(int)round(fps)];
//    NSLog(@"FPS %@", fps1);
//    [text yy_setColor:color range:NSMakeRange(0, text.length - 3)];
//    [text yy_setColor:[UIColor whiteColor] range:NSMakeRange(text.length - 3, 3)];
//    text.yy_font = _font;
//    [text yy_setFont:_subFont range:NSMakeRange(text.length - 4, 1)];
//
//    self.attributedText = text;
}
@end
