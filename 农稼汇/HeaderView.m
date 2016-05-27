//
//  HeaderView.m
//  农稼汇
//
//  Created by Anna on 16/5/20.
//  Copyright © 2016年 li. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()< UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *timer;


@end

@implementation HeaderView

- (void)awakeFromNib{
    
}

+ (instancetype)headerView{
    HeaderView *headerView = [[[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:nil options:nil]firstObject];
    
    return headerView;
}

- (void) setScrollView:(UIScrollView *)scrollView{
    _scrollView = scrollView;
    CGFloat imgW = 280;
    CGFloat imgH = 120;
    CGFloat imgY = 0;
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imgView = [[UIImageView alloc]init];
        NSString *imgName = [NSString stringWithFormat:@"%d.png",i];
        imgView.image = [UIImage imageNamed:imgName];
        
        CGFloat imgX = i * imgW;
        imgView.frame = CGRectMake(imgX, imgY, imgW, imgH);
        
        [self.scrollView addSubview:imgView];
    }
    
    CGFloat maxW = self.scrollView.frame.size.width * 3;
    self.scrollView.contentSize = CGSizeMake(maxW, 0);
    
    self.scrollView.pagingEnabled = YES;
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.pageControl.numberOfPages = 3;
    
    self.pageControl.currentPage = 0;
    
    //创建计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    
    //修改NSTimer优先级
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//UIScrollView的滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    offsetX  = offsetX + (scrollView.frame.size.width * 0.5);
    int page = offsetX / scrollView.frame.size.width;
    self.pageControl.currentPage = page;
}

//即将开始拖曳
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    self.timer = nil;
}

//拖曳完毕
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:nil];
}

- (void)scrollImage{
    NSInteger page = self.pageControl.currentPage;
    if (page == self.pageControl.numberOfPages-1) {
        page=0;
    }
    else{
        page++;
    }
    CGFloat offsetX = page * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
