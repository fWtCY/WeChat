//
//  InformationTableViewController.m
//  WeChat
//
//  Created by Fuwentao on 2017/5/5.
//  Copyright © 2017年 Fuwentao. All rights reserved.
//

#import "InformationTableViewController.h"
#import "ChatInformationViewController.h"
#import "LogInViewController.h"
#import "User.h"
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
static NSString *cellID = @"cellID";
static NSString *headerID = @"headerID";
@interface InformationTableViewController (){
    NSMutableDictionary *_dic;
    BOOL _isOpen[2];
}

@end

@implementation InformationTableViewController

- (void)viewDidLoad {
    self.tableView.rowHeight = 80;
    [self createDic];
    [self createNavigationBarButtonItem];
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dic.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isOpen[section]) {
        return 0;
    }
    NSArray *arr = _dic[_dic.allKeys[section]];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    User *user = _dic[_dic.allKeys[indexPath.section]][indexPath.row];
    cell.textLabel.text =  user.userName;
    cell.detailTextLabel.text = user.ID;
    cell.imageView.image = [UIImage imageNamed:@"defaultPerson.png"];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSLog(@"%@",_dic[_dic.allKeys[indexPath.section]][indexPath.row]);
    return cell;
}


-(void)createNavigationBarButtonItem{
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [cancelButton setTitle:@"注销" forState:UIControlStateNormal];
    [cancelButton sizeToFit];
    [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithCustomView:cancelButton];
    self.navigationItem.rightBarButtonItem = cancel;
}
-(void)cancelButtonAction:(UIButton *)button{
    self.view.window.rootViewController = [[LogInViewController alloc]init];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[[ChatInformationViewController alloc]init] animated:YES];
}
-(void)createDic{
    _dic = [NSMutableDictionary dictionary];
    NSMutableArray *friend = [[NSMutableArray alloc]init];
    NSMutableArray *brother = [[NSMutableArray alloc]init];
    [_dic setObject:friend forKey:@"我的好友"];
    [_dic setObject:brother forKey:@"铁锅"];
    
    for (int i = 0; i<20; i++) {
        User *user = [[User alloc]init];
        user.userName = [NSString stringWithFormat:@"%d",i];
        user.ID = [NSString stringWithFormat:@"%d",i];
        if (i%2==0) {
            [friend addObject:user];
        }else{
            [brother addObject:user];
        }
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerID];
    }
    NSArray *arr =_dic[_dic.allKeys[section]];
    headerView.textLabel.text = [NSString stringWithFormat:@"%@(%ld/%ld)",_dic.allKeys[section],arr.count,arr.count];
    UITapGestureRecognizer *TGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tgrAction:)];
    [headerView addGestureRecognizer:TGR];
    headerView.tag = 1000+section;
    return headerView;
}
-(void)tgrAction:(UITapGestureRecognizer *)tgr{
    _isOpen[tgr.view.tag-1000]= !_isOpen[tgr.view.tag-1000];
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:tgr.view.tag-1000];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationTop];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }else{
        return 20;
    
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
