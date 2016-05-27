//
//  NewsCell.h
//  农稼汇
//
//  Created by Anna on 16/5/20.
//  Copyright © 2016年 li. All rights reserved.
//

#import <UIKit/UIKit.h>

@class News;

@interface NewsCell : UITableViewCell

@property (nonatomic, strong) News *news;

+ (instancetype)newsCellWithTableView:(UITableView *)tableView;

@end
