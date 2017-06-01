//
//  SYJForgetController.m
//  MoXiDemo
//
//  Created by 尚勇杰 on 2017/6/1.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJForgetController.h"

@interface SYJForgetController ()
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *setup;

@end

@implementation SYJForgetController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.codeBtn.layer.masksToBounds = YES;
    self.codeBtn.layer.cornerRadius = 8;
    self.codeBtn.layer.borderColor = Gray.CGColor;
    self.codeBtn.layer.borderWidth = 0.5;
    self.codeBtn.backgroundColor = TextColor;
    [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.setup.layer.masksToBounds = YES;
    self.setup.layer.cornerRadius = 5;
    self.setup.layer.borderColor = Gray.CGColor;
    self.setup.layer.borderWidth = 0.5;
    self.setup.backgroundColor = TextColor;
    [self.setup setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    

    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)setUpBtn:(UIButton *)sender {
}
- (IBAction)gologin:(UIButton *)sender {
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
