//
//  ViewController.m
//  农稼汇
//
//  Created by Anna on 16/5/20.
//  Copyright © 2016年 zqq. All rights reserved.
//

#import "ViewController.h"
#import "News.h"
#import "NewsCell.h"
#import "FooterView.h"
#import "HeaderView.h"
#import "MBProgressHUD+NJ.h"

@interface ViewController ()<UITableViewDataSource, FooterViewDelegate, NSURLConnectionDelegate>

@property (nonatomic, strong)NSMutableArray *news;

@property (nonatomic,assign)BOOL *loginSign;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)clickRightBtn:(id)sender;

- (IBAction)clickLeftBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong)NSMutableData * receiveData;


@end

@implementation ViewController

- (NSMutableArray *)news{
    if (_news == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"news.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict in arrayDict) {
            News *model= [News newsWithDict:dict];
            [arrayModels addObject:model];
        }
        _news = arrayModels;
    }
    return _news;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.news.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取模型数据
    News *model = self.news[indexPath.row];
    
    //创建单元格
    NewsCell *cell = [NewsCell newsCellWithTableView:tableView];
    
    //把模型数据设置给单元格
    cell.news = model;
    
    //返回单元格
    return cell;
}

////隐藏状态栏
//- (BOOL) prefersStatusBarHidden{
//    return YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSURL *url = [NSURL URLWithString:@"http://139.129.19.203:8080/"];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    
//    [request setHTTPMethod:@"GET"];
//    
//    [request setTimeoutInterval:120];
//    
//    [request setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
//    
//    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
//    
//    NSURLSession *session = [NSURLSession sharedSession];
//    
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
//        if (error == nil) {
//            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"data: %@",dataStr);
//        }
//    }];
//    
//    [task resume];
//
    
    //第一步，创建url
    NSURL *url = [NSURL URLWithString:@"http://139.129.19.203:8080/news/newstype"];
    //第二步，创建请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //第三步，连接服务器
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    
    self.tableView.rowHeight = 100;
    
    self.loginSign = false;
    
    FooterView *footerView = [FooterView footerView];
    
    //设置footerView代理
    footerView.delegate = self;
    
    self.tableView.tableFooterView = footerView;
    
    //创建HeaderView
    HeaderView *headerView = [HeaderView headerView];
    self.tableView.tableHeaderView = headerView;
    
    //self.loginSign = 1;
    
    CGFloat btnW = 50;
    CGFloat btnH = 40;
    CGFloat btnY = 0;
    
    for (int i = 0; i < 12; i++) {
        UIButton *btn = [[UIButton alloc]init];
        
//        NSString *imgName = [NSString stringWithFormat:@"%d.jpg",i];
//        [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];

        
        NSArray *class = [NSArray arrayWithObjects:@"精选",@"本地",@"农资",@"农机",@"新闻",@"行情",@"社会",@"健康",@"娱乐",@"科技",@"农民日报",@"家庭农场",@"农产品",nil];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:class[i] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(ClickClassBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.enabled = YES;
        
        CGFloat btnX = i *btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [self.scrollView addSubview:btn];
    }

    CGFloat maxW = 50 * 12;
    self.scrollView.contentSize = CGSizeMake(maxW, 0);
    
    self.scrollView.pagingEnabled = YES;
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    //实现scrollView上的Button可以点击的同时也可以拖动
    self.scrollView.panGestureRecognizer.delaysTouchesBegan = YES;
    
    [self particularClick];
    
    [self SwipeGesture];

}

//接收到服务器回应的时候调用此方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    NSLog(@"%@",[res allHeaderFields]);
    self.receiveData = [NSMutableData data];
    
}

//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //json文件中的[]表示一个数据。
    //反序列化json数据
    
    //第二个参数是解析方式，一般用NSJSONReadingAllowFragments
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSLog(@"%@", array);  //json解析以后是nsarray格式的数据。
    [self.receiveData appendData:data];
}

//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *receiveStr = [[NSString alloc]initWithData:self.receiveData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",receiveStr);
}

//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}


- (void) ClickClassBtn:(id)sender{
    NSLog(@"点击分类");
}

//CZFooterView的代理方法
- (void)footerViewUpdateData:(FooterView *)footerView{
    //增加一条数据
    
    //创建一个模型对象
    News *model = [[News alloc]init];
    model.title = @"敦煌科学种田";
    model.attention = @"围观0";
    model.source = @"中国农机网";
    model.time = @"21分钟前";
    model.image = @"4.png";
    
    //把模型对象添加到控制器的goods集合当中
    [self.news addObject:model];
    
    //刷新UITableView
    [self.tableView reloadData];
    
    //向上滚动数据
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:self.news.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickRightBtn:(id)sender{
    if (self.loginSign) {
        [self performSegueWithIdentifier:@"MainToOwn" sender:nil];
        
    }else{
        [self performSegueWithIdentifier:@"MainToLogin" sender:nil];
    }
}

- (IBAction)clickLeftBtn:(id)sender {
}


#pragma mark - Tap 点击
-(void) particularClick{
    /*一个手指单击*/
    //初始化
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
    //点击次数
    tap.numberOfTapsRequired = 1;
    //使用手指数
    tap.numberOfTouchesRequired = 1;
    //添加手势
    [self.view addGestureRecognizer:tap];
}

//一个手指单击回调函数
-(void)SingleTap:(UITapGestureRecognizer *)tap{
    NSLog(@"进入详情界面");
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *detail=[story instantiateViewControllerWithIdentifier:@"Detail"];
    [self presentModalViewController:detail animated:YES];
    
}

#pragma mark - swipe 轻扫
-(void) SwipeGesture{
    //初始化
    UISwipeGestureRecognizer *swipe1 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeActionLeft:)];
    //设置轻扫的方向
    swipe1.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipe1];
    
    //初始化
    UISwipeGestureRecognizer *swipe2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeActionRight:)];
    //设置轻扫的方向
    swipe2.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe2];
}

-(void) SwipeActionLeft:(UISwipeGestureRecognizer *)swipe{
    [MBProgressHUD showError:@"网络请求异常"];
}

-(void) SwipeActionRight:(UISwipeGestureRecognizer *)swipe{
    [MBProgressHUD showError:@"网络请求异常"];
}


@end
