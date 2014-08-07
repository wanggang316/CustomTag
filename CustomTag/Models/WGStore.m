//
//  WGStore.m
//  CustomTag
//
//  Created by 王刚 on 14/8/7.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import "WGStore.h"


@implementation WGStore

+ (NSArray *)customTags {
    
    WGTag *tag1 = [[WGTag alloc]initWithId:@"1" tagName:@"智能机器人"];
    WGTag *tag2 = [[WGTag alloc]initWithId:@"2" tagName:@"3D打印"];
    WGTag *tag3 = [[WGTag alloc]initWithId:@"3" tagName:@"大数据"];
    WGTag *tag4 = [[WGTag alloc]initWithId:@"4" tagName:@"智能手机"];
    WGTag *tag5 = [[WGTag alloc]initWithId:@"5" tagName:@"4G"];
    WGTag *tag6 = [[WGTag alloc]initWithId:@"6" tagName:@"智能电视"];
    WGTag *tag7 = [[WGTag alloc]initWithId:@"7" tagName:@"智能汽车"];
    WGTag *tag8 = [[WGTag alloc]initWithId:@"8" tagName:@"智慧城市"];
    
    return [NSArray arrayWithObjects:tag1, tag2, tag3, tag4, tag5, tag6, tag7, tag8, nil];
    
}


+(NSArray *)noCustomTags {
    WGTag *tag1 = [[WGTag alloc]initWithId:@"9" tagName:@"智能穿戴设备"];
    WGTag *tag2 = [[WGTag alloc]initWithId:@"10" tagName:@"云计算"];
    WGTag *tag3 = [[WGTag alloc]initWithId:@"11" tagName:@"移动互联网"];
    WGTag *tag4 = [[WGTag alloc]initWithId:@"12" tagName:@"可再生能源"];
    WGTag *tag5 = [[WGTag alloc]initWithId:@"13" tagName:@"智能制造"];
    WGTag *tag6 = [[WGTag alloc]initWithId:@"14" tagName:@"工业4.0"];
    WGTag *tag7 = [[WGTag alloc]initWithId:@"15" tagName:@"工业电网"];
    WGTag *tag8 = [[WGTag alloc]initWithId:@"16" tagName:@"电子商务"];
    
    return [NSArray arrayWithObjects:tag1, tag2, tag3, tag4, tag5, tag6, tag7, tag8, nil];
}

@end
