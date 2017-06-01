//
//  YJMineNewVC.m
//  全球向导
//
//  Created by SYJ on 2017/4/16.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJMineController.h"
#import "SYJLoginController.h"



#define KMargin 0   // 间距
#define KStatusBarHeight 0  // 状态栏高度

@interface SYJMineController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *arr;

}


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *icon;


// 顶部的照片
@property (strong, nonatomic) UIImageView *topImageView;
// 毛玻璃
@property (strong, nonatomic) UIVisualEffectView *effectView;

@end

@implementation SYJMineController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSceenW, KSceenH) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO; //默认是YES
    self.tableView.tableFooterView = [UIView new];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    self.tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,KSceenW, 0.01f)];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];


    
    
    arr = @[@"登录",@"修改密码",@"找回密码",@"清空缓存"];

    
    [self setImage];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 向下的话 为负数
    CGFloat off_y = scrollView.contentOffset.y;
    CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
    // 下拉超过照片的高度的时候
    if (off_y < - 200)
    {
        CGRect frame = self.topImageView.frame;
        // 这里的思路就是改变 顶部的照片的 frame
        self.topImageView.frame = CGRectMake(0, off_y, frame.size.width, -off_y);
        self.effectView.frame = self.topImageView.frame;
        // 对应调整毛玻璃的效果
        self.effectView.alpha = 1 + (off_y + 200) / kHeight ;
    }
}

- (void)setImage{
    
    self.topImageView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, -200, KSceenW, 200))];
    _topImageView.image = [UIImage imageNamed:@"timg"];
    
    _topImageView.contentMode = UIViewContentModeScaleAspectFill;
    _topImageView.clipsToBounds = YES;
    self.topImageView.userInteractionEnabled = YES;
    [self.tableView addSubview:self.topImageView];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectView.frame = _topImageView.frame;
    _effectView = effectView;
    [self.topImageView addSubview:_effectView];
    
    
    self.icon = [[UIImageView alloc]init];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"head"]];
    [self.topImageView addSubview:self.icon];
    self.icon.sd_layout.centerXEqualToView(self.topImageView).centerYEqualToView(self.topImageView).heightIs(80).widthIs(80);
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius = self.icon.width / 2;
    self.icon.layer.borderColor = Gray.CGColor;
    self.icon.layer.borderWidth = 1.0;
    self.icon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self.icon addGestureRecognizer:tapGest];
    
}





//点击头像进入编辑
- (void)tapClick{
    
}

#pragma mark - table view dataSource table view delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section

{
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    cell.textLabel.text = arr[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        [self.navigationController pushViewController:[SYJLoginController new] animated:YES];
    }
    
}




//隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}



@end
