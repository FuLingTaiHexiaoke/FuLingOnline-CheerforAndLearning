//
//  HomeNewsViewController.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 16/11/23.
//  Copyright © 2016年 com.FuLing. All rights reserved.
//

#import "HomeNewsViewController.h"

//views
#import "HomeHeaderView.h"

#define HEADER_HEIGHT 200.0f
#define HEADER_INIT_FRAME CGRectMake(0, 0, self.view.frame.size.width, HEADER_HEIGHT)
#define CELL_HEIGHT 45.0f

@interface HomeNewsViewController()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic)UITableView* tableView;
@end
@implementation HomeNewsViewController

#pragma mark - ViewController LifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];

   self.tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];
    [self createHeaderView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Header View
- (void)createHeaderView
{
//    NSArray *nib= [[NSBundle mainBundle]loadNibNamed:@"HomeHeaderView" owner:self options:nil];
    HomeHeaderView* _headerView  = [HomeHeaderView newInstance];
    
//   HomeHeaderView* _headerView = [[HomeHeaderView alloc]initWithFrame:HEADER_INIT_FRAME];
//    _headerView.backgroundColor=[UIColor yellowColor];
    [_tableView setTableHeaderView:_headerView];
}

#pragma mark -
#pragma mark Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 12;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifier"];
    
    UITableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setBackgroundColor:[UIColor clearColor]];
        
        if (indexPath.row == 0)
        {
            UIView *lineTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.5f)];
            [lineTop setBackgroundColor:[UIColor blackColor]];
            [cell addSubview:lineTop];
        }
        
        UIView *lineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, CELL_HEIGHT - 0.5f, self.view.frame.size.width, 0.5f)];
        [lineBottom setBackgroundColor:[UIColor blackColor]];
        [cell addSubview:lineBottom];
        
        [cell.textLabel setText:[NSString stringWithFormat:@"Cell %ld",indexPath.row+1]];
    }
    
    
    
    return cell;
}


@end
