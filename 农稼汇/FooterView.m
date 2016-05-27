//
//  FooterView.m
//  农稼汇
//
//  Created by Anna on 16/5/20.
//  Copyright © 2016年 li. All rights reserved.
//

#import "FooterView.h"

@interface FooterView ()

@property (weak, nonatomic) IBOutlet UIButton *btnLoadMore;

@property (weak, nonatomic) IBOutlet UIView *waitingView;

- (IBAction)btnLoadMoreClick;

@end

@implementation FooterView

+ (instancetype)footerView{
    FooterView *footerView = [[[NSBundle mainBundle]loadNibNamed:@"FooterView" owner:nil options:nil] lastObject];
    return footerView;
}

- (IBAction)btnLoadMoreClick {
    
    self.btnLoadMore.hidden = YES;
    
    self.waitingView.hidden = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(footerViewUpdateData:)]) {
            [self.delegate footerViewUpdateData:self];
        }
        self.btnLoadMore.hidden = NO;
        
        self.waitingView.hidden = YES;
    });
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
