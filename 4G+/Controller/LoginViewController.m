//
//  LoginViewController.m
//  Yeke
//
//  Created by cgf yangg on 14-7-4.
//  Copyright (c) 2014年 cgf. All rights reserved.
//
//  开发版本: v1.0
//  开发者: yangg
//  编写时间: 14-7-4
//  功能描述: 登录视图控制器
//  修改记录:(仅记录功能修改)
//              yangg  14-12-20  创建该类
//              <#ModifyHistory#>


#import "LoginViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "RegisterViewController.h"
#import "IQKeyboardManager.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "LoginService.h"


@interface LoginViewController () <UITextFieldDelegate>
{
    double animationDuration;
    CGRect keyboardRect;
    
    __weak IBOutlet UIImageView *_accountImgV;
    __weak IBOutlet UIImageView *_passwdImgV;
    __weak IBOutlet UIView *_bgView;
    __weak IBOutlet NSLayoutConstraint *topBargin;
}

@property (weak, nonatomic) IBOutlet UILabel *line1;
@property (weak, nonatomic) IBOutlet UILabel *line2;

@property (weak, nonatomic) IBOutlet UIImageView *loginBgImg;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton    *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton    *registerBtn;
@property (nonatomic,weak)  IBOutlet NSLayoutConstraint *topLayout;

@property (nonatomic, strong) IQKeyboardReturnKeyHandler    *returnKeyHandler;

@end

@implementation LoginViewController

- (IBAction)bgClick:(id)sender {
    
    [_accountTF resignFirstResponder];
    [_pwdTF resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enableAutoToolbar  = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enableAutoToolbar  = YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect rect = _line1.frame;
    rect.size.height = 0.5;
    _line1.frame = rect;
    
    rect = _line2.frame;
    rect.size.height = 0.5;
    _line2.frame = rect;
    
    
    UILabel *aleft = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 5, 15)];
    _accountTF.leftViewMode = UITextFieldViewModeAlways;
    _accountTF.leftView = aleft;
    _accountTF.delegate = self;
    _accountTF.backgroundColor = [UIColor clearColor];
    
    
    UILabel *bleft = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 5, 15)];
    _pwdTF.leftViewMode = UITextFieldViewModeAlways;
    _pwdTF.leftView = bleft;
    _pwdTF.backgroundColor = [UIColor clearColor];
    
    _loginBtn.layer.cornerRadius = 4;
    
    [_accountTF setValue:[UIColor colorFromHexRGB:@"7E8B9D"] forKeyPath:@"_placeholderLabel.textColor"];
    [_pwdTF setValue:[UIColor colorFromHexRGB:@"7E8B9D"] forKeyPath:@"_placeholderLabel.textColor"];
    
    if (Main_Screen_Height == 568) {
        self.topLayout.constant = 200;
    } else if (Main_Screen_Height == 480) {
        self.topLayout.constant = 170;
        self.loginBgImg.image = [UIImage imageNamed:@"login_Bg_480"];
    }
        
    if (NSStringIsValid(_accountTF.text)) {
        [_accountImgV setImage:[UIImage imageNamed:@"loginTel_on"]];
    }else if (!NSStringIsValid(_accountTF.text)){
        [_accountImgV setImage:[UIImage imageNamed:@"loginTel"]];
    }
    
    if (NSStringIsValid(_pwdTF.text)) {
        [_passwdImgV setImage:[UIImage imageNamed:@"pwdIcon_on"]];
    }else if (!NSStringIsValid(_pwdTF.text)){
        [_passwdImgV setImage:[UIImage imageNamed:@"pwdIcon"]];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardChange)
                                                 name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)keyboardChange
{
    if (NSStringIsValid(_accountTF.text)) {
        [_accountImgV setImage:[UIImage imageNamed:@"loginTel_on"]];
    } else if (!NSStringIsValid(_accountTF.text)){
        [_accountImgV setImage:[UIImage imageNamed:@"loginTel"]];
    }
    
    if (NSStringIsValid(_pwdTF.text)) {
        [_passwdImgV setImage:[UIImage imageNamed:@"pwdIcon_on"]];
    } else if (!NSStringIsValid(_pwdTF.text)){
        [_passwdImgV setImage:[UIImage imageNamed:@"pwdIcon"]];
    }
}


- (void)autoLoginAction:(NSNotification *)notification
{
    [Publish sharePublish].isLogin = NO;
    
    NSDictionary *dictionary = [notification userInfo];
    
    self.accountTF.text = dictionary[@"account"];
    self.pwdTF.text = dictionary[@"pwd"];
    [self loginRequest];
}


- (IBAction)loginBtnAction:(id)sender
{
    if (!NSStringIsValid(self.accountTF.text) || !NSStringIsValid(self.pwdTF.text)) {
        [YKToast showWithText:@"账号或密码不能为空"];
        return;
    }
    
    [self loginRequest];
}


#pragma mark - 注册跳转
- (IBAction)registerAction:(id)sender
{
    RegisterViewController *reflectVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    reflectVC.pwdType = registerPwd;
    [self.navigationController pushViewController:reflectVC animated:YES];
    
}


#pragma mark - 找回密码
- (IBAction)forgetAction:(id)sender
{
    RegisterViewController *reflectVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
     reflectVC.pwdType = forgetPwd;
    [self.navigationController pushViewController:reflectVC animated:YES];
}

#pragma mark -- 登录请求
- (void)loginRequest
{
    if ([Publish checkNetUsable] == NO) {
        return;
    }
    
    [_accountTF resignFirstResponder];
    [_pwdTF resignFirstResponder];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [DataCenter setLastLoginAccount:self.accountTF.text];
    [DataCenter setLastLoginAccountPwd:self.pwdTF.text];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOT_LOGINCHANGE object:@YES];
    
//    [LoginService loginWithUserAccountStr:[self.accountTF.text removeSideSpace]
//                       andUserPasswordStr:[self.pwdTF.text removeSideSpace]
//                          andSuccessBlock:^(id data) {
//                              [MBProgressHUD hideHUDForView:self.view animated:YES];
//                              [DataCenter setLastLoginAccount:self.accountTF.text];
//                              [DataCenter setLastLoginAccountPwd:self.pwdTF.text];
//                              [[NSNotificationCenter defaultCenter] postNotificationName:KNOT_LOGINCHANGE object:@YES];
//                          } andFailedBlock:^(NSString *error) {
//                              [MBProgressHUD hideHUDForView:self.view animated:YES];
//                              [YKToast showWithText:error];
//                          }];
}


- (void)dealloc{
    NSLog(@"loginview dealloc");
}

@end
