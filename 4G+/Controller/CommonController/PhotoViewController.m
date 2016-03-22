//
//  PhotoViewController.m
//  Yeke
//
//  Created by 赵祥 on 15/7/28.
//  Copyright (c) 2015年 西米网络科技. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()
{

    __weak IBOutlet UILabel *label1;
}
@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"照片";
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem.customView.hidden=YES;
    label1.tintColor=[UIColor colorFromHexRGB:@"8F9395"];
    [self setRightItemBar];
}


- (void)setRightItemBar
{
    [self.navigationItem setRightBarButtonItemWithTitle:@"取消" andColor:WhiteColor addTarget:self action:@selector(backTap)];
}

-(void)backTap
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
