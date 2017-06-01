//
//  SYJEmojiModel.h
//  MoXiDemo
//
//  Created by 尚勇杰 on 2017/6/1.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYJEmojiModel : NSObject

@property (nonatomic , assign) NSInteger              rank;
@property (nonatomic , strong) NSArray             * url;
@property (nonatomic , copy) NSString              * preview;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , assign) NSInteger              favs;
@property (nonatomic , copy) NSString              * store;
@property (nonatomic , copy) NSString              * tag;
@property (nonatomic , strong) NSArray             * cid;
@property (nonatomic , strong) NSDictionary                * user;
@property (nonatomic , copy) NSString              * ID;
@property (nonatomic , strong) NSDictionary              * fsize;
@property (nonatomic , copy) NSString              * thumb;
@property (nonatomic , copy) NSString              * ver;
@property (nonatomic , assign) NSInteger              atime;
@property (nonatomic , strong) NSDictionary              * from;
@property (nonatomic , strong) NSDictionary              * ratio;
@property (nonatomic , copy) NSString              * rule;
@property (nonatomic , copy) NSString              * wp;
@property (nonatomic , assign) NSInteger             view;
@property (nonatomic , copy) NSString              * desc;

@end
