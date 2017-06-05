//
//  SYJMainViewController.m
//  MoXiDemo
//
//  Created by 尚勇杰 on 2017/5/26.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJMainViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "SYJPicRecommendModel.h"
#import "SYJPicTableCell.h"

//#define NSLog(FORMAT, ...) fprintf(stderr,"%s",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

@interface SYJMainViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,SDPhotoBrowserDelegate>{
    int a;
    SDPhotoBrowser *photoBrowser;

}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *img;

@property (nonatomic, strong) CLLocationManager *locationManager;

/**
 图片列表
 */
@property (nonatomic, strong) NSMutableArray *listArr;


/**
 定位城市
 */
@property (nonatomic, strong) NSString *city;

/**
 天气
 */
@property (nonatomic, strong) UILabel *weather;

/**
 温度
 */
@property (nonatomic, strong) UILabel *temperature;

/**
 城市
 */
@property (nonatomic, strong) UILabel *cityName;

/**
 当前时间
 */
@property (nonatomic, strong) UILabel *timeCurrent;

/**
 风级
 */
@property (nonatomic, strong) UILabel *wind;

@property (nonatomic, assign) NSInteger num;


@end

@implementation SYJMainViewController

- (NSMutableArray *)listArr{
    
    if (_listArr == nil) {
        _listArr = [NSMutableArray array];
    }
    
    return _listArr;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    a = 0;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getHttpPic];
    }];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (self.listArr.count >= self.num) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self getHttpPic];
        }
        
        
    }];

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [UILabel titleWithColor:TextColor title:@"Recommend" font:18.0];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KSceenW, KSceenH - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[SYJPicTableCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,KSceenW, 0.01f)];
    
    [self getCityName];
    
}


- (void)getHttpPic{
    
    
    NSString *str = @"摄影";
    NSString *dataUTF8 = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *abc = @"创意摄影";
    NSString *data = [abc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    SYJLog(@"%@",dataUTF8);
    
    a = a + 10;
    
    [SYJHttpHelper Post:[NSString stringWithFormat:@"http://image.baidu.com/channel/listjson?pn=11&rn=%d&tag1=%@&tag2=%@",a,dataUTF8,data] parameters:nil success:^(id responseObject) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        self.listArr = [SYJPicRecommendModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
        
        SYJLog(@"%@",json);
        NSString *str = json[@"totalNum"];
        self.num = [str integerValue];
        
        NSArray *list = [SYJPicRecommendModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
        for (SYJPicRecommendModel *model in list) {
            [self.listArr addObject:model];
            if (NULLString(model.image_url)) {
                [self.listArr removeObject:model.image_url];
            }
        }
        
        if (self.listArr.count == self.num) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];
        }

        
        
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}



- (BOOL)validateUrl:(NSString *)candidate {
    NSString *urlRegEx = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}


//初始化定位信息
- (void)getCityName{
    
    //检测定位功能是否开启
    if([CLLocationManager locationServicesEnabled]){
        
        if(!_locationManager){
            
            self.locationManager = [[CLLocationManager alloc] init];
            
            if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
                [self.locationManager requestWhenInUseAuthorization];
                [self.locationManager requestAlwaysAuthorization];
                
            }
            
            //设置代理
            [self.locationManager setDelegate:self];
            //设置定位精度
            [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
            //设置距离筛选
            [self.locationManager setDistanceFilter:100];
            //开始定位
            [self.locationManager startUpdatingLocation];
            //设置开始识别方向
            [self.locationManager startUpdatingHeading];
            
        }
        
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                             message:@"you not the location"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil,nil];
        [alertView show];  
    }
    
}


#pragma mark - CLLocationManangerDelegate
//定位成功以后调用
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    //当前所在城市的坐标值
    CLLocation *currLocation = [locations lastObject];
    
    //根据经纬度反向地理编译出地址信息
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    
    [geoCoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        for (CLPlacemark * placemark in placemarks) {
            
            NSDictionary *address = [placemark addressDictionary];
            

            
            self.city = [address objectForKey:@"City"];
            
            self.cityName.text = [NSString stringWithFormat:@"%@  %@",[address objectForKey:@"Country"],[address objectForKey:@"City"]];
            
            if ([[address objectForKey:@"Country"] isEqualToString:@"中国"]) {
                [self getWeatherData];

            }
            
            
        }
        
    }];
    
}

#pragma mark Geocoder



//反地理编码
- (void)reverseGeocoder:(CLLocation *)currentLocation {
    
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if(error || placemarks.count == 0){
        }else{
            
            CLPlacemark* placemark = placemarks.firstObject;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your Localtion" message:[[placemark addressDictionary] objectForKey:@"City"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            
            [alert show];  
            
        }
    }];

}

#pragma mark - table view dataSource And Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 160.0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    
    self.img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timg"]];
    self.img.contentMode = UIViewContentModeScaleToFill;
    [self.img sd_setImageWithURL:[NSURL URLWithString:@"http://img1.imgtn.bdimg.com/it/u=1248660256,3129357967&fm=23&gp=0.jpg"] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        SYJLog(@"%@",error);
    }];
    
//    NSURL *URL = [NSURL URLWithString:@"http://img1.imgtn.bdimg.com/it/u=1248660256,3129357967&fm=23&gp=0.jpg"];
//    
//    NSData *data = [NSData dataWithContentsOfURL:URL];
//    
//    self.img.image = [UIImage imageWithData:data];
    
    self.cityName = [[UILabel alloc]init];
    [self.img addSubview:self.cityName];
    self.cityName.textAlignment = NSTextAlignmentCenter;
    self.cityName.font = [UIFont boldSystemFontOfSize:19.0];
    self.cityName.textColor = [UIColor whiteColor];
    self.cityName.sd_layout.centerXEqualToView(self.img).topSpaceToView(self.img, 10).heightIs(20).widthIs(150);
    
    self.weather = [[UILabel alloc]init];
    [self.img addSubview:self.weather];
    self.weather.textAlignment = NSTextAlignmentCenter;
    self.weather.font = [UIFont boldSystemFontOfSize:14.0];
    self.weather.textColor = [UIColor whiteColor];
    self.weather.sd_layout.leftSpaceToView(self.img, 20).topSpaceToView(self.img, 50).heightIs(20).widthIs(130);
    
    self.temperature = [[UILabel alloc]init];
    [self.img addSubview:self.temperature];
    self.temperature.textAlignment = NSTextAlignmentCenter;
    self.temperature.font = [UIFont boldSystemFontOfSize:14.0];
    self.temperature.textColor = [UIColor whiteColor];
    self.temperature.sd_layout.rightSpaceToView(self.img, 20).topSpaceToView(self.img, 50).heightIs(20).widthIs(130);
    
    self.timeCurrent = [[UILabel alloc]init];
    [self.img addSubview:self.timeCurrent];
    self.timeCurrent.textAlignment = NSTextAlignmentCenter;
    self.timeCurrent.font = [UIFont boldSystemFontOfSize:14.0];
    self.timeCurrent.textColor = [UIColor whiteColor];
    self.timeCurrent.sd_layout.leftSpaceToView(self.img, 20).topSpaceToView(self.weather, 10).heightIs(20).widthIs(130);
    
    self.wind = [[UILabel alloc]init];
    [self.img addSubview:self.wind];
    self.wind.textAlignment = NSTextAlignmentCenter;
    self.wind.font = [UIFont boldSystemFontOfSize:14.0];
    self.wind.textColor = [UIColor whiteColor];
    self.wind.sd_layout.rightSpaceToView(self.img, 20).topSpaceToView(self.temperature, 10).heightIs(20).widthIs(130);
    
    
    return self.img;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SYJPicTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    SYJPicRecommendModel *model = self.listArr[indexPath.row];
    cell.model = model;
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    SYJPicTableCell *cell = (SYJPicTableCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    SYJPicRecommendModel *model = self.listArr[indexPath.row];
    
    if (!NULLString(model.image_url)) {
        
        photoBrowser = [SDPhotoBrowser new];
        photoBrowser.delegate = self;
        photoBrowser.currentImageIndex = 0;
        photoBrowser.imageCount = 1;
        photoBrowser.sourceImagesContainerView = self.tableView;
        [photoBrowser show];
    }
    
   

}

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    // 不建议用此种方式获取小图，这里只是为了简单实现展示而已
    SYJPicTableCell *cell = (SYJPicTableCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    return cell.img.image;
    
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    // 不建议用此种方式获取小图，这里只是为了简单实现展示而已
    SYJPicRecommendModel *model = self.listArr[indexPath.row];
    return [NSURL URLWithString:model.image_url];
}


//cell动画

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation((90.0*M_PI/180), 0.0, 0.7, 0.4);
    rotation.m44 = 1.0/-600;
    //阴影
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    //阴影偏移
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    //透明度
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    
    //锚点
    cell.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    [UIView beginAnimations:@"rotaion" context:NULL];
    
    [UIView setAnimationDuration:0.8];
    
    cell.layer.transform = CATransform3DIdentity;
    
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    
    [UIView commitAnimations];
}


//获取定位城市天气信息
- (void)getWeatherData{
    
    
    if (self.city) {
//        self.city = @"北京";
        NSString *weather = [self.city stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        SYJLog(@"%@",weather);
        
        [SYJHttpHelper GET:[NSString stringWithFormat:@"http://v.juhe.cn/weather/index?format=2&cityname=%@&key=a63fb31266cab6e8e42992f56645b3d1",weather] parameters:nil success:^(id responseObject) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            SYJLog(@"%@",dict);
            
            self.weather.text = [NSString stringWithFormat:@"%@",dict[@"result"][@"today"][@"weather"]];
            self.wind.text = [NSString stringWithFormat:@"%@",dict[@"result"][@"today"][@"wind"]];
            self.temperature.text = [NSString stringWithFormat:@"%@",dict[@"result"][@"today"][@"temperature"]];
            self.timeCurrent.text = [NSString stringWithFormat:@"%@",dict[@"result"][@"today"][@"date_y"]];
        
            
        } failure:^(NSError *error) {
            
        }];
        
    }
        
    
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
