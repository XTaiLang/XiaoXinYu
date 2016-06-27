//
//  SpecialDetailViewController.m
//  News
//
//  Created by lanouhn on 16/3/7.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "SpecialDetailViewController.h"
#import "AllHeaders.h"
@interface SpecialDetailViewController ()

@end

@implementation SpecialDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   // [self loadDataFromeNet];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {

    [self loadDataFromeNet];
    
}


- (void)loadDataFromeNet
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString * str = [NSString stringWithFormat:kSpecailS, self.aaid];
    
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.titLabel.text = responseObject[@"title"];
        
        UIImageView *a = [[UIImageView alloc] init];
        
        [a sd_setImageWithURL:[NSURL URLWithString:responseObject[@"imageUrl"]] placeholderImage:[UIImage imageNamed:@"123"]];
        
        UIImage *lastImage = [a.image applyDarkEffect];
        
        self.backImage.image = lastImage;
        
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
        
        self.dateLabel.text = datestring;
        
        NSDictionary *dic = responseObject[@"user"];
        
        if ([dic[@"avatar"] isEqual:[NSNull null]]) {
            
            self.headImage.image = [UIImage imageNamed:@"123"];
            
        }else{
            
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:dic[@"avatar"]] placeholderImage:[UIImage imageNamed:@"123"]];
            
        }
        
        self.nameLabel.text = dic[@"screenName"];
        
        NSMutableString *body = [NSMutableString string];
        
        NSString *str = responseObject[@"content"];
        
        [body appendFormat:@"<div><head><style>img{width:%fpx !important;}</style></head>%@</div>",[UIScreen mainScreen].bounds.size.width - 30, str];

        [self.contactLabel loadHTMLString:body baseURL:nil];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
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
