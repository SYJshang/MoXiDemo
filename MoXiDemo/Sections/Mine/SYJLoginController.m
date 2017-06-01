//
//  SYJLoginController.m
//  MoXiDemo
//
//  Created by 尚勇杰 on 2017/6/1.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJLoginController.h"
#import "SYJRegisterController.h"
#import "SYJForgetController.h"

@interface SYJLoginController ()
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIButton *goRegister;

@end

@implementation SYJLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.login.layer.masksToBounds = YES;
    self.login.layer.cornerRadius = 5;
    self.login.layer.borderColor = Gray.CGColor;
    self.login.layer.borderWidth = 0.5;
    self.login.backgroundColor = TextColor;
    [self.login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)login:(UIButton *)sender {
    
    
    
}
- (IBAction)register:(UIButton *)sender {
    
    [self.navigationController pushViewController:[SYJRegisterController new] animated:YES];
}
- (IBAction)forgetPassword:(id)sender {
    
    [self.navigationController pushViewController:[SYJForgetController new] animated:YES];
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
