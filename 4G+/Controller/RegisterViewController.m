//
//  RegisterViewController.m
//  4G
//
//  Created by 赵祥 on 16/2/15.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "RegisterViewController.h"
#import "IQKeyboardManager.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "PasswordViewController.h"
#import "LoginService.h"

@interface RegisterViewController ()
{
    int TimeInterval;
    NSTimer     *_myTimer;
    
    __weak IBOutlet UILabel *_titleLb;
    __weak IBOutlet UILabel *_detailLb;
    __weak IBOutlet UITextField *_accountTf;
    __weak IBOutlet UITextField *_codeTf;
    __weak IBOutlet UIButton *_nextBtn;
    __weak IBOutlet UIButton *_protocolBtn;
    __weak IBOutlet UILabel *_protocolLb;
    __weak IBOutlet UIButton *_getCodeBtn;
    __weak IBOutlet UIImageView *_loginTelImgv;
    __weak IBOutlet UIImageView *_codeImgv;
    __weak IBOutlet UIView *_bgView;
}

@property (nonatomic,weak)  IBOutlet NSLayoutConstraint *topLayout;
@property (nonatomic,weak)  IBOutlet NSLayoutConstraint *widthLayout;

@end

@implementation RegisterViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showNavTransparent];
    _getCodeBtn.enabled = YES;
    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [_myTimer invalidate];
    _myTimer = nil;
}


- (void)cancelBtnClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setBackButtonWithTarget:self andColor:GrayColor title:@"登录" action:@selector(cancelBtnClick:)];
      TimeInterval = 60;
    _getCodeBtn.layer.cornerRadius = 4;
    _nextBtn.layer.cornerRadius = 4;
    _nextBtn.alpha = 0.5;
    _nextBtn.enabled = NO;
    [_codeTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    if (Main_Screen_Height == 568) {
        self.topLayout.constant = 70;
        self.widthLayout.constant = 90;
    } else if (Main_Screen_Height == 480) {
        self.topLayout.constant = 40;
        self.widthLayout.constant = 80;
    }
    
    
    if (_pwdType == registerPwd) {
        _titleLb.text = @"填写注册信息";
        _detailLb.text = @"注册即可获得100分钟免费花费";
    } else {
        _titleLb.text = @"忘记密码验证";
        _detailLb.text = @"";
        _protocolBtn.hidden = YES;
        _protocolLb.hidden = YES;
    }
    
    
    if (NSStringIsValid(_accountTf.text)) {
        [_loginTelImgv setImage:[UIImage imageNamed:@"loginTel_on"]];
    } else if (!NSStringIsValid(_accountTf.text)){
        [_loginTelImgv setImage:[UIImage imageNamed:@"loginTel"]];
    }
    
    if (NSStringIsValid(_codeTf.text)) {
        [_codeImgv setImage:[UIImage imageNamed:@"login_code_on"]];
    } else if (!NSStringIsValid(_codeTf.text)){
        [_codeImgv setImage:[UIImage imageNamed:@"login_code"]];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardChange)
                                                 name:UITextFieldTextDidChangeNotification object:nil];
    
    
}

-(void)keyboardChange
{
    if (NSStringIsValid(_accountTf.text)) {
        [_loginTelImgv setImage:[UIImage imageNamed:@"loginTel_on"]];
    }else if (!NSStringIsValid(_accountTf.text)){
        [_loginTelImgv setImage:[UIImage imageNamed:@"loginTel"]];
    }
    
    if (NSStringIsValid(_codeTf.text)) {
        [_codeImgv setImage:[UIImage imageNamed:@"login_code_on"]];
    }else if (!NSStringIsValid(_codeTf.text)){
        [_codeImgv setImage:[UIImage imageNamed:@"login_code"]];
    }
}


- (IBAction)getCodeClick:(id)sender {
    
    if(!NSStringIsValid(_accountTf.text)) {
        [YKToast showWithText:@"请输入手机号码"];
        return;
    }
    
    if(![Publish isValidPhone:_accountTf.text])  {
        [YKToast showWithText:@"手机号码格式不正确"];
        return;
    }
    
     [_accountTf resignFirstResponder];
     [_getCodeBtn resignFirstResponder];
    
    [LoginService getSmsWithMobile:_accountTf.text andSuccessBlock:^(id data){
        _detailLb.text = [NSString stringWithFormat:@"验证码已发送至：%@",_accountTf.text];
        [_getCodeBtn setTitle:@"重发验证码" forState:UIControlStateNormal];
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                    target:self
                                                  selector:@selector(changeButtonName)
                                                  userInfo:nil
                                                   repeats:YES];
        [_myTimer fire];
    }andFailedBlock:^(NSString *error){
        
    }];
    
   
}


- (void)changeButtonName
{
    NSLog(@"come here");
    if (TimeInterval > 0)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            _getCodeBtn.enabled = NO;
            NSString * string = [NSString stringWithFormat:@"%d秒",TimeInterval];
            NSLog(@"%@===",string);
            [_getCodeBtn setTitle:string forState:UIControlStateNormal];
            TimeInterval--;
        });
    } else
    {
        _getCodeBtn.enabled = YES;
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_myTimer invalidate];
        TimeInterval = 60;
    }
}

- (void)textFieldDidChange:(id)sender
{
    if (NSStringIsValid(_accountTf.text)  && NSStringIsValid(_codeTf.text)) {
        _nextBtn.enabled = YES;
        _nextBtn.alpha = 1;
    } else {
        _nextBtn.enabled = NO;
        _nextBtn.alpha = 0.5;
    }
}

- (IBAction)nextBtnClick:(id)sender {
    if(!NSStringIsValid(_codeTf.text)) {
        [YKToast showWithText:@"请输入验证码"];
        return;
    }
    [LoginService checkSmsCodeWithMobile:_accountTf.text checkCode:_codeTf.text andSuccessBlock:^(id data){
        PasswordViewController *vc = [PasswordViewController new];
        vc.tel = _accountTf.text;
        vc.pwdType = _pwdType;
        [self.navigationController pushViewController:vc animated:YES];
    }andFailedBlock:^(NSString *error){
        [YKToast showWithText:error];
    }];
   
}

- (IBAction)protocolClick:(id)sender {
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
