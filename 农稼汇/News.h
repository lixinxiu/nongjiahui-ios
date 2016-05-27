//
//  News.h
//  农稼汇
//
//  Created by Anna on 16/5/20.
//  Copyright © 2016年 li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *attention;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *image;

- (instancetype) initWithDict:(NSDictionary *)dict;
+ (instancetype) newsWithDict:(NSDictionary *)dict;

@end
