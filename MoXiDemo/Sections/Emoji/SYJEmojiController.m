//
//  SYJEmojiController.m
//  MoXiDemo
//
//  Created by 尚勇杰 on 2017/5/27.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJEmojiController.h"
#import "SGPageView.h"
#import "SYJThemeController.h"
#import "SYJTemplateController.h"
#import "SYJLockScreenController.h"
#import "SYJEmojiVC.h"
#import "YJCache.h"

@interface SYJEmojiController ()<SGPageTitleViewDelegate, SGPageContentViewDelegare>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@end

@implementation SYJEmojiController

- (void)cache{
    
    float cache = [YJCache filePath];
    NSString *str = [NSString stringWithFormat:@"%.2f Mb",cache];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"clear cache" message:[NSString stringWithFormat:@"Remove the %@ MB cache",str] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
    [YJCache clearFile];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"clear cache" style:UIBarButtonItemStyleDone target:self action:@selector(cache)];

    self.navigationItem.titleView = [UILabel titleWithColor:TextColor title:@"Blog Themes" font:18.0];

//    self.title = @"Blog Themes";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    SYJThemeController *oneVC = [[SYJThemeController alloc] init];
    SYJTemplateController *twoVC = [[SYJTemplateController alloc] init];
    SYJLockScreenController *threeVC = [[SYJLockScreenController alloc] init];
    SYJEmojiVC *fourVC = [[SYJEmojiVC alloc] init];
    
    NSArray *childArr = @[oneVC, twoVC, threeVC, fourVC];
    /// pageContentView
    CGFloat contentViewHeight = self.view.frame.size.height - 108;
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 108, self.view.frame.size.width, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
    
    
    NSArray *titleArr = @[@"Theme", @"Template", @"LockScreen", @"Emoji"];
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44) delegate:self titleNames:titleArr];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = 1;
    _pageTitleView.titleColorStateNormal = [UIColor lightGrayColor];
    _pageTitleView.titleColorStateSelected = TextColor;
    _pageTitleView.indicatorColor = TextColor;
//    _pageTitleView.isOpenTitleTextZoom = YES;
//    _pageTitleView.indicatorLengthStyle = SGIndicatorLengthTypeEqual;
}

- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
}

- (void)SGPageContentView:(SGPageContentView *)SGPageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
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
