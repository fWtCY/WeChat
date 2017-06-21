//
//  ChatInformationTableViewController.m
//  WeChat
//
//  Created by Fuwentao on 2017/5/6.
//  Copyright © 2017年 Fuwentao. All rights reserved.
//

#import "ChatInformationTableViewController.h"
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
static NSString *cellID = @"cellID";

@interface ChatInformationTableViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_chatInformationArr;
    UITableView *_chatInformationTableView;
}

@end

@implementation ChatInformationTableViewController

- (void)viewDidLoad {
    [self createChatInformationData];
    [self createChatInformationTableView];
    [self createprintView];
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
-(void)createChatInformationData{
    _chatInformationArr = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil]];
}
-(void)createChatInformationTableView{
    _chatInformationTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-120) style:UITableViewStylePlain];
    _chatInformationTableView.dataSource = self;
    _chatInformationTableView.delegate = self;
    _chatInformationTableView.rowHeight = 100;
//    _chatInformationTableView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_chatInformationTableView];
}
-(void)createprintView{
    UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-120, ScreenWidth, 60)];
    buttonView.backgroundColor = [UIColor redColor];
    [self.view addSubview:buttonView];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"%ld",_chatInformationArr.count);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _chatInformationArr.count;
}


//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.textLabel.text = _chatInformationArr[indexPath.row][@"content"];
    }
    NSLog(@"%ld",indexPath.row);
    
    return cell;
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
