//
//  SYJPicTableCell.h
//  MoXiDemo
//
//  Created by 尚勇杰 on 2017/5/31.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYJPicRecommendModel.h"

@interface SYJPicTableCell : UITableViewCell

@property (nonatomic, strong) UIImageView *img;

@property (nonatomic, strong) SYJPicRecommendModel *model;

@end
