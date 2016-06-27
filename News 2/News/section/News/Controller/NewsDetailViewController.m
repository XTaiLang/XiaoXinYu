//
//  NewsDetailViewController.m
//  News
//
//  Created by lanouhn on 16/3/8.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "AllHeaders.h"
@interface NewsDetailViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *contentView;
@property (nonatomic, copy) NSString *titleStr;

@property (nonatomic, copy) NSString *nameStr;

@property (nonatomic, copy) NSString *dateStr;

@property (nonatomic, copy) NSString *str;
@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"%@", self.aaid);
    
    // Do any additional setup after loading the view.
}


/**
 *  视图将要出现的时候
 */
- (void)viewWillAppear:(BOOL)animated
{
    // 解析数据
    [self loadDataFromeNet];
}




/**
 *  数据解析
 */
- (void)loadDataFromeNet
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *string = [NSString stringWithFormat:@"http://api.wallstreetcn.com/v2/posts/%@", self.aaid];
    
//    NSLog(@"%@", string);
    
    [manager GET:string parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.titleStr = responseObject[@"title"];

        // self.contentLabel
        
        NSDictionary *dic = responseObject[@"user"];
        
        self.nameStr = dic[@"screenName"];
        
  
        
        NSString *createdAt = responseObject[@"createdAt"];
        
        NSDate *firstDate = [NSDate dateWithTimeIntervalSince1970:[createdAt integerValue]];
        
        /**
         *  NSDateFormatter 日期格式类 继承自NSFormatter 主要作用是将NSDate对象转为某种格式,然后以字符串的形式输出
         */
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        /**
         *  设置日期格式中用到的字母的作用 y 代表年 M代表月 d代表日 H代表小时 m代表分钟  s代表秒
         */
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        /**
         *  将时间对象转为设定的格式  格式化的时候会自动加上距离零时区的间隔
         */
        NSString *datestring = [formatter stringFromDate:firstDate];
        
//        NSLog(@"%@", datestring);
        
        self.dateStr = datestring;
        
        
        self.str = responseObject[@"content"];
        // self.contentView.scalesPageToFit = YES;
        [self.contentView loadHTMLString:[self addBody] baseURL:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"失败");
        
        NSLog(@"%@", error);
        
    }];
    
    
    
    
    
}


- (NSString *)addBody
{

    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\"style=\"color:black;text-align:center;font-size:20px;font-weight:bold;background-color:white\">%@</div>",self.titleStr];

    //    [imgHtml appendString:@"<div class=\"img-parent\">"];

    [body appendFormat:@"<div class=\"time\"style=\"color:gray;font-size:14px;background-color:white\">%@ &nbsp;&nbsp %@</div>", self.nameStr, self.dateStr];
    
    
    [body appendFormat:@"<div><head><style>img{width:%fpx !important;}</style></head>%@</div>",[UIScreen mainScreen].bounds.size.width - 20 , self.str];
    
    return body;
}





- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webView.frame = frame;



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

@end
