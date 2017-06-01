
//
//  SYJPicTableCell.m
//  MoXiDemo
//
//  Created by 尚勇杰 on 2017/5/31.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJPicTableCell.h"

@implementation SYJPicTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.img = [[UIImageView alloc]init];
        [self.contentView addSubview:self.img];
        self.img.sd_layout.leftSpaceToView(self.contentView, 5).rightSpaceToView(self.contentView, 5).topSpaceToView(self.contentView, 5).bottomSpaceToView(self.contentView, 5);
        self.img.layer.masksToBounds = YES;
        self.img.layer.cornerRadius = 5;
        self.img.layer.borderColor = Gray.CGColor;
        self.img.layer.borderWidth = 1.0;
        self.img.contentMode = UIViewContentModeScaleAspectFill;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    
    return self;
}

- (void)setModel:(SYJPicRecommendModel *)model{
    
    _model = model;
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@""]];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
