//
//  SYJArtController.m
//  MoXiDemo
//
//  Created by 尚勇杰 on 2017/6/1.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJPlayController.h"
#import "SYJCollectionFlowLayout.h"
#import "SYJClassesCell.h"
#import "SYJClassesModel.h"

@interface SYJPlayController ()<UICollectionViewDataSource,SYJCollectionFlowLayoutDelegate>{
    int a;
}

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, strong) NSMutableArray *listArr;

@property (nonatomic, weak) UICollectionView *collectionView; /**< <#注释#> */

@end

@implementation SYJPlayController


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
    
    [self.collectionView registerClass:[SYJClassesCell class] forCellWithReuseIdentifier:@"cell"];
    
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
        
        if (self.listArr.count >= self.num) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self getHttpPic];
        }
        
        
    }];
}

- (void)getHttpPic{
    
    
    NSString *str = @"体育壁纸";
    NSString *dataUTF8 = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *abc = @"体育壁纸";
    NSString *data = [abc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    SYJLog(@"%@",dataUTF8);
    SYJLog(@"%@",dataUTF8);
    
    
    a = a + 20;
    
    [SYJHttpHelper Post:[NSString stringWithFormat:@"http://image.baidu.com/search/acjson?tn=resultjson_com&ipn=rj&ct=201326592&is=&fp=result&cl=2&lm=-1&ie=utf-8&oe=utf-8&adpicid=&st=-1&z=&ic=0&s=&se=&tab=&width=0&height=0&face=0&istype=2&qc=&nc=1&fr=&pn=%d&rn=60&gsm=b4&queryWord=%@&word=%@",a,dataUTF8,data] parameters:nil success:^(id responseObject) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        self.listArr = [SYJClassesModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
        
        SYJLog(@"%@",json);
        NSString *str = json[@"listNum"];
        self.num = [str integerValue];
        
        NSArray *list = [SYJClassesModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
        for (SYJClassesModel *model in list) {
            [self.listArr addObject:model];
            if (NULLString(model.middleURL)) {
                [self.listArr removeObject:model.middleURL];
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
    SYJClassesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    SYJClassesModel *model = self.listArr[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - <CYXWaterFlowLayoutDelegate>
- (CGFloat)waterflowLayout:(SYJCollectionFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    return 100 + arc4random_uniform(150);
}

- (CGFloat)rowMarginInWaterflowLayout:(SYJCollectionFlowLayout *)waterflowLayout
{
    return 10;
}

- (CGFloat)columnCountInWaterflowLayout:(SYJCollectionFlowLayout *)waterflowLayout
{
    return 2;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(SYJCollectionFlowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
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
