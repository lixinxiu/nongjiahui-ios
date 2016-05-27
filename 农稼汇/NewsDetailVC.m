//
//  NewsDetailVC.m
//  Nongjiahui
//
//  Created by 袁David on 16/5/26.
//  Copyright © 2016年 Yuan. All rights reserved.
//

#import "NewsDetailVC.h"
#import "MBProgressHUD+NJ.h"

@interface NewsDetailVC ()
@property (weak, nonatomic) IBOutlet UITextField *commentField;
@property (weak, nonatomic) IBOutlet UIButton *LikeBtn;
@property (weak, nonatomic) IBOutlet UIButton *CollectBtn;
@property (nonatomic,assign) BOOL isLikeBtnOpen;
- (IBAction)clickLikeBtn;
@property (nonatomic,assign) BOOL isCollectBtnOpen;
- (IBAction)clickCollectBtn;
- (IBAction)clickSendBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *detailWebView;
- (IBAction)backAction;

@end

@implementation NewsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *storeURL;
    storeURL=[[NSURL alloc]initWithString:@"http://www.bing.com"];
    [self.detailWebView  loadRequest:[NSURLRequest requestWithURL:storeURL]];
    // 加载网页
    self.detailWebView.delegate=self;
    
    self.isLikeBtnOpen = NO;
    self.isCollectBtnOpen = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)clickLikeBtn {
    NSLog(@"click LikeBtn");
    if(!self.isLikeBtnOpen){
        [MBProgressHUD showMessage:@"您已点赞"];
        self.isLikeBtnOpen = YES;
        [self.LikeBtn setImage:[UIImage imageNamed:@"ic_good_press.png"] forState:UIControlStateNormal];
    }
    
  
  else{        [MBProgressHUD showMessage:@"您已取消"];
        self.isLikeBtnOpen = NO;
        [self.LikeBtn setImage:[UIImage imageNamed:@"ic_good.png"] forState:UIControlStateNormal];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUD];
    });
}

- (IBAction)clickCollectBtn {
    NSLog(@"click CollectBtn");
    if(!self.isCollectBtnOpen){
        [MBProgressHUD showMessage:@"您已收藏"];
        self.isCollectBtnOpen = YES;
        [self.CollectBtn setImage:[UIImage imageNamed:@"ic_star_press.png"] forState:UIControlStateNormal];
    }
    
    else{
        [MBProgressHUD showMessage:@"您已取消"];
        self.isCollectBtnOpen = NO;
        [self.CollectBtn setImage:[UIImage imageNamed:@"ic_uc_star.png"] forState:UIControlStateNormal];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUD];
    });

}

- (IBAction)clickSendBtn:(id)sender {
    NSLog(@"click SendBtn");
    if(self.commentField.text.length == 0)[MBProgressHUD showMessage:@"请输入评论内容"];
    else{
        [MBProgressHUD showMessage:@"评论成功！"];
        [self.commentField setText:nil];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUD];
    });
}
- (IBAction)backAction {
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *main=[story instantiateViewControllerWithIdentifier:@"zhuye"];
    [self presentModalViewController:main animated:YES];
}
@end
