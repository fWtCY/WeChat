//
//  LogInViewController.m
//  WeChat
//
//  Created by Fuwentao on 2017/5/17.
//  Copyright © 2017年 Fuwentao. All rights reserved.
//

#import "LogInViewController.h"
#import "TabBarViewController.h"

@interface LogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logInAction:(id)sender {
    if ([_userName.text isEqualToString:@"admin"] && [_passWord.text isEqualToString:@"123"]) {
            TabBarViewController *tabBarVC =[[TabBarViewController alloc]init];
       [UIView transitionWithView:self.view.window duration:.5 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            self.view.window.rootViewController = tabBarVC;
       } completion:^(BOOL finished) {
           
       }];
    }

}
- (IBAction)testAction:(id)sender {
     TabBarViewController *tabBarVC =[[TabBarViewController alloc]init];
    [UIView transitionWithView:self.view.window duration:.5 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        self.view.window.rootViewController = tabBarVC;
    } completion:^(BOOL finished) {
        
    }];

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
