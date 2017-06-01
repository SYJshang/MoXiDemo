//
//  SYJRegisterController.m
//  MoXiDemo
//
//  Created by 尚勇杰 on 2017/6/1.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJRegisterController.h"
#import "SYJLoginController.h"

@interface SYJRegisterController ()
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation SYJRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.codeBtn.layer.masksToBounds = YES;
    self.codeBtn.layer.cornerRadius = 8;
    self.codeBtn.layer.borderColor = Gray.CGColor;
    self.codeBtn.layer.borderWidth = 0.5;
    self.codeBtn.backgroundColor = TextColor;
    [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.registerBtn.layer.masksToBounds = YES;
    self.registerBtn.layer.cornerRadius = 5;
    self.registerBtn.layer.borderColor = Gray.CGColor;
    self.registerBtn.layer.borderWidth = 0.5;
    self.registerBtn.backgroundColor = TextColor;
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)code:(UIButton *)sender {
    
    
}
- (IBAction)regi:(UIButton *)sender {
    
}

- (IBAction)goLogin:(UIButton *)sender {
    
    [self.navigationController pushViewController:[SYJLoginController new] animated:YES];
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
