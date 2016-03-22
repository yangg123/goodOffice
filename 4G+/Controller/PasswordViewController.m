//
//  PasswordViewController.m
//  4G
//
//  Created by 赵祥 on 16/2/16.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "PasswordViewController.h"
#import "AppDelegate.h"
#import "LoginService.h"

@interface PasswordViewController ()
{
    __weak IBOutlet UILabel *_titleLb;

    
    __weak IBOutlet UIImageView *_pwdIconImgv1;
    __weak IBOutlet UIImageView *_pwdIconImgv2;
    
    __weak IBOutlet UITextField *_pwdTF;
    __weak IBOutlet UITextField *_nextPwdTF;
    
    __weak IBOutlet UIButton *_completeBtn;
    
    
}


@property (nonatomic,weak)  IBOutlet NSLayoutConstraint *topLayout;
@end

@implementation PasswordViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showNavTransparent];
    
}

- (void)cancelBtnClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.navigationItem setBackButtonWithTarget:self andColor:GrayColor title:@"返回" action:@selector(cancelBtnClick:)];
    
    if (_pwdType == registerPwd) {
        _titleLb.text = @"填写登陆密码";

    }else{
        _titleLb.text = @"忘记密码验证";
        
    }
    
    
    if (Main_Screen_Height == 568) {
        self.topLayout.constant = 70;
    } else if (Main_Screen_Height == 480) {
        self.topLayout.constant = 40;
    }
    _completeBtn.layer.cornerRadius = 6;
    
    if (NSStringIsValid(_pwdTF.text)) {
        [_pwdIconImgv1 setImage:[UIImage imageNamed:@"pwdIcon_on"]];
    }else if (!NSStringIsValid(_pwdTF.text)){
        [_pwdIconImgv1 setImage:[UIImage imageNamed:@"pwdIcon"]];
    }
    
    if (NSStringIsValid(_nextPwdTF.text)) {
        [_pwdIconImgv2 setImage:[UIImage imageNamed:@"pwdIcon_on"]];
    }else if (!NSStringIsValid(_nextPwdTF.text)){
        [_pwdIconImgv2 setImage:[UIImage imageNamed:@"pwdIcon"]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardChange)
                                                 name:UITextFieldTextDidChangeNotification object:nil];
    
}

-(void)keyboardChange
{
    if (NSStringIsValid(_pwdTF.text)) {
        [_pwdIconImgv1 setImage:[UIImage imageNamed:@"pwdIcon_on"]];
    }else if (!NSStringIsValid(_pwdTF.text)){
        [_pwdIconImgv1 setImage:[UIImage imageNamed:@"pwdIcon"]];
    }
    
    if (NSStringIsValid(_nextPwdTF.text)) {
        [_pwdIconImgv2 setImage:[UIImage imageNamed:@"pwdIcon_on"]];
    }else if (!NSStringIsValid(_nextPwdTF.text)){
        [_pwdIconImgv2 setImage:[UIImage imageNamed:@"pwdIcon"]];
    }
}

- (IBAction)completeClick:(id)sender {
    if (!NSStringIsValid(_pwdTF.text)) {
         [YKToast showWithText:@"请填写密码"];
        return;
    }
    if (!NSStringIsValid(_nextPwdTF.text)) {
        [YKToast showWithText:@"请再次输入密码"];
        return;
    }
    if (![_pwdTF.text isEqualToString:_nextPwdTF.text]) {
        [YKToast showWithText:@"两次输入密码不一致，请重新输入"];
        return;
    }
    if (_pwdType == registerPwd) {
        [self registerWithParamWithTel:_tel andWithpassWord:_pwdTF.text];
    }else{
        [self modifyWithPhoneWithTel:_tel andWithpassWord:_pwdTF.text];
    }
    
}



-(void)registerWithParamWithTel:(NSString *)tel andWithpassWord:(NSString *)password{
    NSArray *valueArr = [NSArray arrayWithObjects:tel,password, nil];
    NSArray *keyArr = [NSArray arrayWithObjects:@"tel",@"password", nil];
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:valueArr forKeys:keyArr];
    [LoginService registerWithParam:dic andSuccessBlock:^(id data){
        
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate enterLoginViewController];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOT_LOGINCHANGE object:@YES];
        
    }andFailedBlock:^(NSString *error){
        [YKToast showWithText:error];
    }];
}

-(void)modifyWithPhoneWithTel:(NSString *)tel andWithpassWord:(NSString *)password{
    [LoginService modifyWithPhone:tel password:password andSuccessBlock:^(id data){
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate enterLoginViewController];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOT_LOGINCHANGE object:@YES];
    }andFailedBlock:^(NSString *error){
         [YKToast showWithText:error];
    }];
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
