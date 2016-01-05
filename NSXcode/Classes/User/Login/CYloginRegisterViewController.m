//
//  CYloginRegisterViewController.m
//  聪颖不聪颖
//
//  Created by 葛聪颖 on 15/9/27.
//  Copyright © 2015年 gecongying. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CYloginRegisterViewController.h"
#import "NSXAccount.h"
#import "NSXAccountParam.h"
#import "NSXAccountResult.h"
#import "NSXAccount+Provider.h"
#import "NSXUser.h"
#import "NSXUserParam.h"
#import "NSXUserResult.h"
#import "NSXUser+Provider.h"
#import "Utils.h"
#import "Config.h"
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


@property (nonatomic, strong) MBProgressHUD *hud;

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
    if ([Config getOwnAccountAndPassword]!=nil) {
         [[NSNotificationCenter defaultCenter] postNotificationName:CYLOGINSUCCESSNotification object:nil];
    }
    
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
    
    _hud = [Utils createHUD];
    _hud.labelText = @"正在登录";
    _hud.userInteractionEnabled = NO;
    
    NSXAccountParam *accountParam = [[NSXAccountParam alloc] init];
    accountParam.accountName = _accountField.text;
    accountParam.password = _passwordField.text;;
    NSArray *accountAndPassword;
    if ([Config getOwnAccountAndPassword]!=nil) {
        accountAndPassword = [Config getOwnAccountAndPassword];
    }
//    _accountField.text = accountAndPassword? accountAndPassword[0] : _accountField.text;
//    _passwordField.text = accountAndPassword? accountAndPassword[1] : _passwordField.text;
//    NSLog(@"%@",_accountField.text);
//    NSLog(@"%@",_passwordField.text);
    if (accountAndPassword!=nil) {
        NSXUser *user = [Config getOwnUser];
        NSLog(@"%@",user.userId);
        NSLog(@"%@-----------",user.name);
        _hud.mode = MBProgressHUDModeCustomView;
        _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
        _hud.labelText = [NSString stringWithFormat:@"登录成功"];
        [_hud hide:YES afterDelay:1];
        [self close];
    }else
    {
        [NSXAccount accountWithParam:accountParam success:^(NSXAccountResult *result) {
            NSXAccount *account = result.accountArray[0];
            if (account.accountName!=nil&&account.password!=nil) {
                NSXUserParam *userParam = [[NSXUserParam alloc] init];
                userParam.userId = account.userId;
                [NSXUser userWithParam:userParam success:^(NSXUserResult *result) {
                   
                    NSXUser *user = result.userArray[0];
                    NSLog(@"%@",user);
                    [Config saveOwnUser:user];
                    [Config saveOwnAccount:_accountField.text andPassword:_passwordField.text];
                    [self close];
                } failure:^(NSError *error) {
                    
                }];
            }
            if (![result.code isEqualToString:@"0"]) {
                _hud.mode = MBProgressHUDModeCustomView;
                _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
                _hud.labelText = [NSString stringWithFormat:@"%@", result.message];
                [_hud hide:YES afterDelay:1];
                
                return;
            }else
            {
                _hud.mode = MBProgressHUDModeCustomView;
                _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
                _hud.labelText = [NSString stringWithFormat:@"%@",result.message];
                [_hud hide:YES afterDelay:1];
                return;
            }
        } failure:^(NSError *error) {
            _hud.mode = MBProgressHUDModeCustomView;
            _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
            _hud.labelText = [NSString stringWithFormat:@"%@",error];
            _hud.detailsLabelText = error.userInfo[NSLocalizedDescriptionKey];
            
            [_hud hide:YES afterDelay:1];
        }];
    }
    

    
    
    
//
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager OSCManager];
//    
//    [manager POST:[NSString stringWithFormat:@"%@%@", OSCAPI_HTTPS_PREFIX, OSCAPI_LOGIN_VALIDATE]
//       parameters:@{@"username" : _accountField.text, @"pwd" : _passwordField.text, @"keep_login" : @(1)}
//          success:^(AFHTTPRequestOperation *operation, ONOXMLDocument *responseObject) {
//              ONOXMLElement *result = [responseObject.rootElement firstChildWithTag:@"result"];
//              
//              NSInteger errorCode = [[[result firstChildWithTag:@"errorCode"] numberValue] integerValue];
//              if (!errorCode) {
//                  NSString *errorMessage = [[result firstChildWithTag:@"errorMessage"] stringValue];
//                  
//                  _hud.mode = MBProgressHUDModeCustomView;
//                  _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
//                  _hud.labelText = [NSString stringWithFormat:@"错误：%@", errorMessage];
//                  [_hud hide:YES afterDelay:1];
//                  
//                  return;
//              }
//              
//              [Config saveOwnAccount:_accountField.text andPassword:_passwordField.text];
//              ONOXMLElement *userXML = [responseObject.rootElement firstChildWithTag:@"user"];
//              
//              [self renewUserWithXML:userXML];
//          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//              _hud.mode = MBProgressHUDModeCustomView;
//              _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
//              _hud.labelText = [@(operation.response.statusCode) stringValue];
//              _hud.detailsLabelText = error.userInfo[NSLocalizedDescriptionKey];
//              
//              [_hud hide:YES afterDelay:1];
//          }
//     ];
}


-(IBAction)regist:(UIButton *)button
{
    NSLog(@"%@",self.accountRegistField.text);
    NSLog(@"%@",self.passwordRegistField.text);
    _hud = [Utils createHUD];
    _hud.labelText = @"正在登录";
    _hud.userInteractionEnabled = NO;
    
    if (self.accountRegistField.text!=nil&&self.passwordRegistField.text!=nil) {
        NSXAccountParam *accountParam = [[NSXAccountParam alloc] init];
        accountParam.accountName = self.accountRegistField.text;
        accountParam.password = self.passwordRegistField.text;
    [NSXAccount accountInsertWithParam:accountParam success:^(NSXAccountResult *result){
        if (![result.code isEqualToString:@"0"]) {
            NSString *errorMessage = result.message;
            //[[result firstChildWithTag:@"errorMessage"] stringValue];
            
            _hud.mode = MBProgressHUDModeCustomView;
            _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
            _hud.labelText = [NSString stringWithFormat:@"错误：%@", errorMessage];
            [_hud hide:YES afterDelay:1];
            
            return;
        }else
        {
            _hud.mode = MBProgressHUDModeCustomView;
            _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
            _hud.labelText = [NSString stringWithFormat:@"%@",result.message];
            [_hud hide:YES afterDelay:1];
//            [self close];
            return;
        }
        } failure:^(NSError *error) {
            _hud.mode = MBProgressHUDModeCustomView;
            _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
            _hud.labelText = [NSString stringWithFormat:@"%登录失败"];
            [_hud hide:YES afterDelay:1];
//            [self close];
            return;
        }];
    }    
}

@end
