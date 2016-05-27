//
//  News.m
//  农稼汇
//
//  Created by Anna on 16/5/20.
//  Copyright © 2016年 li. All rights reserved.
//

#import "News.h"

@implementation News

- (instancetype) initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype) newsWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
