//
//  CYloginRegisterViewController.m
//  聪颖不聪颖
//
//  Created by 葛聪颖 on 15/9/27.
//  Copyright © 2015年 gecongying. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CYloginRegisterViewController.h"

@interface CYloginRegisterViewController ()<UITextFieldDelegate, UIGestureRecognizerDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingSpace;


@property (nonatomic, weak) IBOutlet UITextField *accountField;
@property (nonatomic, weak) IBOutlet UITextField *passwordField;
@property (nonatomic, weak) IBOutlet UIButton *loginButton;

@property (nonatomic, weak) IBOutlet UITextField *accountRegistField;
@property (nonatomic, weak) IBOutlet UITextField *passwordRegistField;
@property (nonatomic, weak) IBOutlet UIButton *registButton;

@property (nonatomic, weak) IBOutlet UIButton *qqButton;
@property (nonatomic, weak) IBOutlet UIButton *wechatButton;
@property (nonatomic, weak) IBOutlet UIButton *weiboButton;


@property (nonatomic, weak) IBOutlet UIButton *tipButton;

@property (nonatomic, weak) IBOutlet UIButton *forgetButton;
@end

@implementation CYloginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.loginButton.layer.cornerRadius = 5;
    //    self.loginButton.layer.masksToBounds = YES;
    //    [self.loginButton setValue:@5 forKeyPath:@"layer.cornerRadius"];
    //    [self.loginButton setValue:@YES forKeyPath:@"layer.masksToBounds"];
    //    self.loginButton.clipsToBounds = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)loginOrRegister:(UIButton *)button
{
    // 修改约束
    if (self.leadingSpace.constant == 0) {
       self.leadingSpace.constant = - [UIScreen mainScreen].bounds.size.width;
        [button setTitle:@"已有账号？" forState:UIControlStateSelected];
   

        button.selected = YES;
    }else
    {
     

        
        self.leadingSpace.constant = 0;
        [button setTitle:@"注册账号" forState:UIControlStateNormal];
        button.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(IBAction)forgetPassWord:(UIButton *)button
{
    if (self.leadingSpace.constant == 0) {
    self.leadingSpace.constant = - [UIScreen mainScreen].bounds.size.width*2;
    [self.tipButton setTitle:@"返回登录" forState:UIControlStateSelected];
     self.tipButton.selected = YES;
    }else
    {
        self.leadingSpace.constant = 0;
        [self.tipButton setTitle:@"返回登录" forState:UIControlStateSelected];
        self.tipButton.selected = NO;
    }
}
- (IBAction)login:(UIButton *)button
{
    NSLog(@"%@",self.accountField.text);
    NSLog(@"%@",self.passwordField.text);
}


-(IBAction)regist:(UIButton *)button
{
    NSLog(@"%@",self.accountRegistField.text);
    NSLog(@"%@",self.passwordRegistField.text);
}

@end
