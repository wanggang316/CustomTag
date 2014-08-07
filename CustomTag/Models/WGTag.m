//
//  WGTag.m
//  CustomTag
//
//  Created by 王刚 on 14/8/7.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import "WGTag.h"

@implementation WGTag

- (id)initWithId:(NSString *)tagId tagName:(NSString *)tagName {
    if (self = [super init]) {
        self.tagId = [tagId copy];
        self.tagName = [tagName copy];
    }
    return self;
}


@end
