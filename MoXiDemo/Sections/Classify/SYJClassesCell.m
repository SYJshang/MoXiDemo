//
//  SYJClassesCell.m
//  MoXiDemo
//
//  Created by 尚勇杰 on 2017/6/1.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJClassesCell.h"

@implementation SYJClassesCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.cornerRadius = 5;
        self.contentView.layer.borderColor =  [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0].CGColor;
        self.contentView.layer.borderWidth = 2;
        
        self.picImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"horse"]];
        [self.contentView addSubview:self.picImg];
        self.picImg.contentMode = UIViewContentModeScaleAspectFill;
        self.picImg.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0);
        
    }
    
    return self;
}

- (void)setModel:(SYJClassesModel *)model{
    
    _model = model;
    [self.picImg sd_setImageWithURL:[NSURL URLWithString:model.middleURL] placeholderImage:[UIImage imageNamed:@""]];
}

@end
