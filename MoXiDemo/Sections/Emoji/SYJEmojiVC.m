//
//  SYJArtController.m
//  MoXiDemo
//
//  Created by 尚勇杰 on 2017/6/1.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJEmojiVC.h"
#import "SYJCollectionFlowLayout.h"
#import "SYJEmojiModel.h"
#import "SYJEmojiCell.h"

@interface SYJEmojiVC ()<UICollectionViewDataSource,SYJCollectionFlowLayoutDelegate>{
    int a;
}

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, strong) NSMutableArray *listArr;

@property (nonatomic, weak) UICollectionView *collectionView; /**< <#注释#> */

@end

@implementation SYJEmojiVC


- (NSMutableArray *)listArr{
    
    if (_listArr == nil) {
        _listArr = [NSMutableArray array];
    }
    
    return _listArr;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    SYJCollectionFlowLayout *layout = [[SYJCollectionFlowLayout alloc]init];
    layout.delegate = self;
    
    a = 0;
    
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:    CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [self.collectionView registerClass:[SYJEmojiCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self setupRefresh];
    
    // Do any additional setup after loading the view.
}

- (void)setupRefresh
{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getHttpPic];
    }];
    
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (self.listArr.count >= 500) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self getHttpPic];
        }
        
        
    }];
}

- (void)getHttpPic{
    
    
    NSString *str = @"表情包";
    NSString *dataUTF8 = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    a = a + 30;
    
    [SYJHttpHelper GET:[NSString stringWithFormat:@"http://so.picasso.adesk.com/v1/search/vertical/resource/%@?adult=0&first=1&limit=30&order=new&skip=%d",dataUTF8,a] parameters:nil success:^(id responseObject) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *list = [SYJEmojiModel mj_objectArrayWithKeyValuesArray:json[@"res"][@"vertical"]];
        for (SYJEmojiModel *model in list) {
            [self.listArr addObject:model];
            if (NULLString(model.img)) {
                [self.listArr removeObject:model.img];
            }
            
        }
        
        if (self.listArr.count == self.num) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.collectionView.mj_footer endRefreshing];
            [self.collectionView.mj_header endRefreshing];
        }
        
        
        
        [self.collectionView reloadData];
        
        
    } failure:^(NSError *error) {
        
        
        
    }];
    
}



#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.listArr.count;
    SYJLog(@"%ld",self.listArr.count);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SYJEmojiCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    SYJEmojiModel *model = self.listArr[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - <CYXWaterFlowLayoutDelegate>
- (CGFloat)waterflowLayout:(SYJCollectionFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    return 60 + arc4random_uniform(100);
}

- (CGFloat)rowMarginInWaterflowLayout:(SYJCollectionFlowLayout *)waterflowLayout
{
    return 5;
}

- (CGFloat)columnCountInWaterflowLayout:(SYJCollectionFlowLayout *)waterflowLayout
{
    return 3;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(SYJCollectionFlowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
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
