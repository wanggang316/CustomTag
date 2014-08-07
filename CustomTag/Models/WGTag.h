//
//  WGTag.h
//  CustomTag
//
//  Created by 王刚 on 14/8/7.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGTag : NSObject

@property (nonatomic, copy) NSString *tagId;
@property (nonatomic, copy) NSString *tagName;


- (id)initWithId:(NSString *)tagId
         tagName:(NSString *)tagName;

@end
