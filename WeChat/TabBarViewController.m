//
//  TabBarViewController.m
//  WeChat
//
//  Created by Fuwentao on 2017/5/5.
//  Copyright © 2017年 Fuwentao. All rights reserved.
//

#import "TabBarViewController.h"
#import "InformationTableViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    self.tabBar.hidden = YES;
    [self createViewcontrollers];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createViewcontrollers{
    UINavigationController *information = [[UINavigationController alloc]initWithRootViewController:[[InformationTableViewController alloc]initWithStyle:UITableViewStylePlain ]];
    UINavigationController *adressBook = [[UINavigationController alloc]init];
    UINavigationController *discover = [[UINavigationController alloc]init];
    UINavigationController *MyInformation = [[UINavigationController alloc]init];
    self.viewControllers = @[information,adressBook,discover,MyInformation];
}
-(void)createTabBar{
//    UITabBarItem  *information = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemSearch tag:1100];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
