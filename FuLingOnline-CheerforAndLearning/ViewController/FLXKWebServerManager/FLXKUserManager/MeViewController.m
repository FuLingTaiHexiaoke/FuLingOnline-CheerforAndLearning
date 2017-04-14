

//
//  MeViewController.m
//  WeChat
//
//  Created by zhengwenming on 16/6/5.
//  Copyright © 2016年 zhengwenming. All rights reserved.
//

#import "MeViewController.h"
#import "PersonCenterHeaderCell.h"
#import "PersonCenterCell.h"

//#import "FLXKPersonInfoViewController.h"
#import "EditPersonInfoViewController.h"

@interface MeViewController (){
    CGRect oldFrame;
    UIImageView *fullScreenIV;
}

@property(nonatomic,retain)NSMutableArray  *dataArray;
@end

@implementation MeViewController
-(NSMutableArray *)dataArray{
    if (_dataArray==nil) {
        _dataArray = [NSMutableArray arrayWithObjects:
                      @[@{@"title":@"文明",@"icon":@"MoreExpressionShops"}],
                      @[@{@"title":@"相册",@"icon":@"ff_IconShowAlbum"},@{@"title":@"收藏",@"icon":@"MoreMyFavorites"},@{@"title":@"钱包",@"icon":@"MoreMyBankCard"},@{@"title":@"卡券",@"icon":@"MyCardPackageIcon"}],
                      @[@{@"title":@"表情",@"icon":@"MoreExpressionShops"}],
                      @[@{@"title":@"设置",@"icon":@"MoreSetting"}], nil];
    }
    return _dataArray;
}
-(void)initUI{
    //    self.tableView.separatorInset=UIEdgeInsetsZero;
    [self.tableView registerNib:[UINib nibWithNibName:@"PersonCenterHeaderCell" bundle:nil] forCellReuseIdentifier:@"PersonCenterHeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PersonCenterCell" bundle:nil] forCellReuseIdentifier:@"PersonCenterCell"];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark 取得当前操作状态，根据不同的状态左侧出现不同的操作按钮
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (1) {
        return UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}

//#pragma mark 排序
////只要实现这个方法在编辑状态右侧就有排序图标
//-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
//
//}

#pragma mark
#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    //    [self.tableView setEditing:YES];
}
#pragma mark
#pragma mark numberOfSections
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count+1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section) {
        NSArray *rowArray = self.dataArray[section-1];
        return rowArray.count;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section) {
        return 42;
    }
    return 82;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section) {
        return 2;
    }
    return 0.01;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        PersonCenterHeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"PersonCenterHeaderCell"];
        //        headerCell.selectionStyle  = UITableViewCellSelectionStyleNone;
        headerCell.avatarIV.userInteractionEnabled = YES;
        //        UITapGestureRecognizer *fullScreenTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapForFullScreen:)];
        //        [headerCell.avatarIV addGestureRecognizer:fullScreenTap];
        headerCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return headerCell;
    }else{
        
        PersonCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCenterCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.section==2) {//我的好友
            switch (indexPath.row) {
                case 0:
                    cell.titleIV.image = [UIImage imageNamed:@"MoreMyFavorites"];
                    cell.titleLabel.text = @"相册";
                    break;
                case 1:
                    cell.titleIV.image = [UIImage imageNamed:@"MoreMyFavorites"];
                    cell.titleLabel.text = @"收藏";
                    break;
                case 2:
                    cell.titleIV.image = [UIImage imageNamed:@"MoreMyBankCard"];
                    cell.titleLabel.text = @"钱包";
                    break;
                case 3:
                    cell.titleIV.image = [UIImage imageNamed:@"MyCardPackageIcon"];
                    cell.titleLabel.text = @"卡券";
                    break;
                default:
                    break;
            }
            
        }else if (indexPath.section==3){//设置
            cell.titleIV.image = [UIImage imageNamed:@"MoreExpressionShops"];
            cell.titleLabel.text = @"表情";
            
        }else if(indexPath.section==4){
            cell.titleIV.image = [UIImage imageNamed:@"MoreSetting"];
            cell.titleLabel.text = @"设置";
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        switch (indexPath.section) {
            case 0:{
                EditPersonInfoViewController *personInfoVC =[[UIStoryboard storyboardWithName:@"FLXKUserManager" bundle:nil] instantiateInitialViewController];
                [self.navigationController pushViewController:personInfoVC animated:YES];
            }
                break;
//            case 1:
//                if (indexPath.row==0) {
//                    MyAccountViewController *myAccountVC = [[MyAccountViewController alloc]init];
//                    [self.navigationController pushViewController:myAccountVC animated:YES];
//                }else if (indexPath.row==1){
//                    AddressBookViewController *addressBookVC = [[AddressBookViewController alloc]init];
//                    [self.navigationController pushViewController:addressBookVC animated:YES];
//                }else if (indexPath.row==2){
//    
//                }else if (indexPath.row==3){
//    
//                }
//                break;
//            case 2:{
//                if (indexPath.row==0) {
//    
//                    FeedBackViewController *feedBackVC = [[FeedBackViewController alloc]init];
//                    [self.navigationController pushViewController:feedBackVC animated:YES];
//                }else if(indexPath.row==1){
//                    SettingViewController *settingVC = [[SettingViewController alloc]init];
//                    [self.navigationController pushViewController:settingVC animated:YES];
//                }
//            }
//                break;
            default:
                break;
        }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc{
    fullScreenIV = nil;
    self.tableView = nil;
}

@end
