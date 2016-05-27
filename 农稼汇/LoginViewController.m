//
//  LoginViewController.m
//  农稼汇
//
//  Created by Anna on 16/5/24.
//  Copyright © 2016年 li. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

- (IBAction)backToMain;


@end

@implementation LoginViewController

////隐藏状态栏
//- (BOOL) prefersStatusBarHidden{
//    return YES;
//}

- (IBAction)backToMain {
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *main=[story instantiateViewControllerWithIdentifier:@"zhuye"];
    [self presentModalViewController:main animated:YES];
}
@end
