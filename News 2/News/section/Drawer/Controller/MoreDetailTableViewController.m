//
//  MoreDetailTableViewController.m
//  News
//
//  Created by lanouhn on 16/3/12.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "MoreDetailTableViewController.h"
#import "AllHeaders.h"
#import "MoreModel.h"
#import "DetailTableViewCell.h"
@interface MoreDetailTableViewController ()<UIWebViewDelegate>

@property (nonatomic, copy) NSString *authorNickName;

@property (nonatomic, copy) NSString *authorIconUrl;

@property (nonatomic, copy) NSString *publishTime;

@property (nonatomic, copy) NSString *webContent;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, copy) NSString *atitle;

@property (nonatomic, strong) UIWebView *headerView;

@end

@implementation MoreDetailTableViewController


-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (IBAction)popAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", self.aid);
    
    [self loadDataAndShow];
    
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Ecell"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}


- (void)loadDataAndShow
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *string = [NSString stringWithFormat:kDetail, self.aid];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    [manager GET:string parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        self.authorIconUrl = responseObject[@"authorIconUrl"];
        
        self.authorNickName = responseObject[@"authorNickName"];
        
        self.publishTime = responseObject[@"publishTime"];
        
        self.webContent = responseObject[@"webContent"];
        
        self.atitle = responseObject[@"title"];
        
        NSMutableArray *Array = responseObject[@"aboutNews"];
        
        [Array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            MoreModel *model = [MoreModel new];
            
            [model setValuesForKeysWithDictionary:obj];
            
            [self.dataSource addObject:model];
            
        }];
        
        [self make];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"失败");
        
    }];
    
}


- (void)make
{
    self.headerView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
    
    self.headerView.delegate = self;
    
    _headerView.scrollView.bounces = YES;
    
    _headerView.scrollView.showsHorizontalScrollIndicator = YES;
    
    _headerView.scrollView.scrollEnabled = YES;
    
    [_headerView sizeToFit];
    
    NSString *htmlcontent = [NSString stringWithFormat:@"<div id=\"webview_content_wrapper\">%@</div>", [self makeHeaderView]];
    
    [_headerView loadHTMLString:htmlcontent baseURL:nil];
    

}


- (NSString *)makeHeaderView
{
    
    NSDate *firstDate = [NSDate dateWithTimeIntervalSince1970:[self.publishTime integerValue]];
    
    /**
     *  NSDateFormatter 日期格式类 继承自NSFormatter 主要作用是将NSDate对象转为某种格式,然后以字符串的形式输出
     */
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    /**
     *  设置日期格式中用到的字母的作用 y 代表年 M代表月 d代表日 H代表小时 m代表分钟  s代表秒
     */
    [formatter setDateFormat:@"HH:mm"];
    /**
     *  将时间对象转为设定的格式  格式化的时候会自动加上距离零时区的间隔
     */
    NSString *datestring = [formatter stringFromDate:firstDate];
    
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\"style=\"color:black;text-align:center;font-size:20px;font-weight:bold;background-color:white\">%@</div>",self.atitle];
        
    [body appendFormat:@"<div class=\"time\"style=\"color:gray;font-size:14px;background-color:white\">%@ &nbsp;&nbsp %@</div>", self.authorNickName, datestring];
    
    [body appendFormat:@"<div><head><style>img{width:%fpx !important;}</style></head>%@</div>",[UIScreen mainScreen].bounds.size.width - 20 , self.webContent];
    
    return body;
    
    
}



- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //获取页面高度（像素）
    NSString * clientheight_str = [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    float clientheight = [clientheight_str floatValue];
    //设置到WebView上
    webView.frame = CGRectMake(0, 0, self.view.frame.size.width, clientheight);
    //获取WebView最佳尺寸（点）
    CGSize frame = [webView sizeThatFits:webView.frame.size];
    //获取内容实际高度（像素）
    NSString * height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('webview_content_wrapper').offsetHeight + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-top'))  + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-bottom'))"];
    float height = [height_str floatValue];
    //内容实际高度（像素）* 点和像素的比
    height = height * frame.height / clientheight;
    //再次设置WebView高度（点）
    webView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);

    self.tableView.tableHeaderView = self.headerView;

    [self.tableView reloadData];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Ecell" forIndexPath:indexPath];
    
    MoreModel *model = self.dataSource[indexPath.row];
    
    cell.alabel.text = model.title;
    
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.picOne] placeholderImage:[UIImage imageNamed:@"22"]];
    // Configure the cell...
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"TheLast" sender:indexPath];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    NSIndexPath *indexPath = sender;
    
    MoreModel *model = self.dataSource[indexPath.row];
    
    
    NSDate *firstDate = [NSDate dateWithTimeIntervalSince1970:[model.timestamp integerValue]];
    
    /**
     *  NSDateFormatter 日期格式类 继承自NSFormatter 主要作用是将NSDate对象转为某种格式,然后以字符串的形式输出
     */
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    /**
     *  设置日期格式中用到的字母的作用 y 代表年 M代表月 d代表日 H代表小时 m代表分钟  s代表秒
     */
    [formatter setDateFormat:@"MM-dd HH:mm"];
    /**
     *  将时间对象转为设定的格式  格式化的时候会自动加上距离零时区的间隔
     */
    NSString *datestring = [formatter stringFromDate:firstDate];
    
    [segue.destinationViewController setValue:datestring forKey:@"dateString"];
    
    NSLog(@"---------%@", model.aid);
    
    [segue.destinationViewController setValue:model.aid forKey:@"aid"];
    
    
    
    
}


@end
