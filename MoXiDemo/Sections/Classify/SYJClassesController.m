//
//  SYJClassesController.m
//  MoXiDemo
//
//  Created by 尚勇杰 on 2017/5/27.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJClassesController.h"
#import "SGPageView.h"
#import "SYJNavigationBar.h"
#import "SYJArtController.h"
#import "SYJFashionController.h"
#import "SYJDewController.h"
#import "SYJPlayController.h"
#import "SYJChineseController.h"
#import "SYJEvodutionController.h"
#import "SYJGeographyController.h"
#import "SYJTravelController.h"
#import "SYJLolitaController.h"


@interface SYJClassesController ()<SGPageTitleViewDelegate, SGPageContentViewDelegare>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;


@end

@implementation SYJClassesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    SYJArtController *oneVC = [[SYJArtController alloc] init];
    SYJFashionController *twoVC = [[SYJFashionController alloc] init];
    SYJDewController *threeVC = [[SYJDewController alloc] init];
    SYJPlayController *fourVC = [[SYJPlayController alloc] init];
    SYJChineseController *fiveVC = [[SYJChineseController alloc] init];
    SYJEvodutionController *sixVC = [[SYJEvodutionController alloc] init];
    SYJGeographyController *sevenVC = [[SYJGeographyController alloc] init];
    SYJTravelController *eightVC = [[SYJTravelController alloc] init];
    SYJLolitaController *nineVC = [[SYJLolitaController alloc] init];
    
    NSArray *childArr = @[oneVC, twoVC, threeVC, fourVC, fiveVC, sixVC, sevenVC, eightVC, nineVC];
    /// pageContentView
    CGFloat contentViewHeight = self.view.frame.size.height - 64;
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
    
    NSArray *titleArr = @[@"Art", @"Fashion", @"Dew", @"Play", @"Chinaese", @"Evolution", @"Geography", @"Travel", @"Lolita"];
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) delegate:self titleNames:titleArr];
    _pageTitleView.isShowIndicator = NO;
    _pageTitleView.selectedIndex = 3;
    _pageTitleView.titleColorStateSelected = TextColor;
    _pageTitleView.titleColorStateNormal = [UIColor grayColor];
    // 对 navigationItem.titleView 的包装，为的是 让View 占据整个视图宽度
    SYJNavigationBar *view = [[SYJNavigationBar alloc] init];
    self.navigationItem.titleView = view;
    [view addSubview:_pageTitleView];
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
