//
//  SpecailTableViewController.m
//  News
//
//  Created by lanouhn on 16/3/7.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "SpecailTableViewController.h"
#import "AllHeaders.h"
@interface SpecailTableViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger page;


@property (nonatomic, strong) UIWebView *webView;

@end

@implementation SpecailTableViewController


- (NSMutableArray *)dataArray {

    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.page = 1;
    
    self.webView.delegate = self;
    
    [self regestCell];

    [self LoadDataFromeNet];
    
   
   
    
    

    
 /*
//    dispatch_queue_t queue = dispatch_queue_create("lanou.henan", DISPATCH_QUEUE_CONCURRENT);
//    
//    dispatch_group_t group = dispatch_group_create();
//    
//    __block typeof(self)weakself = self;
//    dispatch_group_async(group, queue, ^{
//        
    
    
        
        
//        
//    });
//    
//    
//    dispatch_group_async(group, queue, ^{
//        
//        [weakself LoadDataFromeNet];
//        
//    });
//    
    
    
    // 当分组中所有任务都完成的时候触发
//    dispatch_group_notify(group, queue, ^{
//        
//        // 刷新UI的操作推回主线程完成
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            [weakself.tableView reloadData];
//            
//        });
//        
//    });
*/
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
//    
//    
//   NSString *str = @"<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 汽车已经成为了人们生活当中的一部分，不过由于用车习惯的不同，很容易让大家忽略一些“违法用车”的细节，甚至还不太清楚是什么，自己的车已经违法了。<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;所以并不是交警不可以查你，而是人家不想查你，或者不是时候。如果真要追究你，也是照罚不误的。<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>1.乘客超载</strong><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;估计大家都有过这样的经历，当需要载着亲朋好友出行时，发现人太多坐不下。不过一些车主可能会说，“大家挤一挤，能坐下”，因此可能一个5座的车里，会装下六、七个大活人。<br/><br/>";
//    label.numberOfLines = 0;
//    label.font = [UIFont systemFontOfSize:14];
//    NSAttributedString *att = [[NSAttributedString alloc] initWithData:[htmlcontent dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//    
//    
//    label.attributedText = att;
//    
    
    



    
    
}


- (void)makeHeaderView
{
    _webView = [[UIWebView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 0)];
    
    self.webView.delegate = self;
    
    _webView.scrollView.bounces = NO;
    
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    
    _webView.scrollView.scrollEnabled = NO;
    
    [_webView sizeToFit];
    
    NSString * htmlcontent = [NSString stringWithFormat:@"<div id=\"webview_content_wrapper\">%@</div>", [self addBody]];
    
    [_webView loadHTMLString:htmlcontent baseURL:nil];
}



- (NSString *)addBody
{
    
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\"style=\"color:black;text-align:center;font-size:20px;font-weight:bold;background-color:white\">%@</div>",self.titleL];
    
    [body appendFormat:@"<div><head><style>img{width:%fpx !important;}</style></head>%@</div>",[UIScreen mainScreen].bounds.size.width - 20 , self.summary];
    
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
    
    self.tableView.tableHeaderView = _webView;
    
    [self.tableView reloadData];
}




/**
 *  创建表头视图
 */
/*
 //    self.hView = [[HeaderView alloc] init];
 //
 //    self.hView.textaLabel.text = self.titleL;
 //
 //    [self.hView.awebView loadHTMLString:self.summary baseURL:nil];
 //
 //    UIScrollView *tempView=(UIScrollView *)[self.hView.awebView.subviews objectAtIndex:0];
 //
 //    tempView.scrollEnabled=NO;
 //
 //    [self webViewDidFinishLoad:self.hView.awebView];
 //
 //    // [(UIScrollView *)[[self.hView.awebView subviews] objectAtIndex:0] setBounces:NO];
 //
 //    self.tableView.tableHeaderView = self.hView;
 //
 
 */
/*
//- (void)creatAHeaderView
//{
//    
//    UIView *aview = [[UIView alloc] init];
//
////    UIScrollView *tempView=(UIScrollView *)[self.Bview.subviews objectAtIndex:0];
////
////    tempView.scrollEnabled=NO;
//
//    
//    [aview addSubview:self.Bview];
//    
//    NSLog(@"---------------------------%f", self.Bview.bounds.size.height);
//    
//    
//    
//    
//    aview.frame = self.Bview.bounds;
//    
//    self.tableView.tableHeaderView = aview;
//    
//}
*/





/*
- (void)webViewDidFinishLoad:(UIWebView *)theWebView
{
    CGFloat offsetHeight = [[theWebView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    CGFloat scrollHeight = [[theWebView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    NSLog(@"The height of offsetHeight is %f", offsetHeight);
    NSLog(@"The height of scrollHeight is %f", scrollHeight);
}

*/

/*
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    //获取页面高度（像素）
//    NSString * clientheight_str = [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
//    float clientheight = [clientheight_str floatValue];
//    //设置到WebView上
//    webView.frame = CGRectMake(0, 0, self.view.frame.size.width, clientheight);
//    //获取WebView最佳尺寸（点）
//    CGSize frame = [webView sizeThatFits:webView.frame.size];
//    //获取内容实际高度（像素）
//    NSString * height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('webview_content_wrapper').offsetHeight + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-top'))  + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-bottom'))"];
//    float height = [height_str floatValue];
//    //内容实际高度（像素）* 点和像素的比
//    height = height * frame.height / clientheight;
//    //再次设置WebView高度（点）
//    webView.frame = CGRectMake(0, 0, self.view.frame.size.width, height + 100 + 100+ 40);
//    
//    self.Bview.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
//    
//    
//    self.tableView.tableHeaderView = webView;
//    
//    
//    
//}
*/

// 已经自适应了

/*
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    int height = [height_str intValue];
    webView.frame = CGRectMake(0,0,320,height);
    NSLog(@"height: %@", [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"]);
    [self.tableView reloadData];
    
}
*/




/**
 *  注册cell
 */
- (void)regestCell
{
    [self.tableView registerNib:[UINib nibWithNibName:@"SpecialDetailViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    // 估算高度 (平均高度)
    self.tableView.estimatedRowHeight = 40;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}





/**
 *  获取数据
 */
- (void)LoadDataFromeNet
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *str = [NSString stringWithFormat:kSpecialDetailURL,self.aaid , self.page];
        
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic= responseObject[@"results"];
        
        
        self.atitle = dic[@"title"];
        
        self.asummary = dic[@"summary"];
        
        NSArray *postsArray = dic[@"posts"];
        
        for (NSDictionary *dic in postsArray) {
            
            SpecialDetailModel *model = [SpecialDetailModel new];
            
            [model setValuesForKeysWithDictionary:dic];

            [self.dataArray addObject:model];
        }
        
            // [self.tableView reloadData];
        [self makeHeaderView];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    
}


// http://api.wallstreetcn.com/v2/posts/230988


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SpecialDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    SpecialDetailModel *model = self.dataArray[indexPath.row];
    
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"22"]];
    
    cell.titLabel.text = model.title;
    
    
    NSDate *firstDate = [NSDate dateWithTimeIntervalSince1970:[model.createdAt integerValue]];
    
    /**
     *  NSDateFormatter 日期格式类 继承自NSFormatter 主要作用是将NSDate对象转为某种格式,然后以字符串的形式输出
     */
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    /**
     *  设置日期格式中用到的字母的作用 y 代表年 M代表月 d代表日 H代表小时 m代表分钟  s代表秒
     */
    [formatter setDateFormat:@"MM-dd"];
    /**
     *  将时间对象转为设定的格式  格式化的时候会自动加上距离零时区的间隔
     */
    NSString *datestring = [formatter stringFromDate:firstDate];
    
    cell.dateLabel.text = datestring;
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"sectSuge" sender:indexPath];
    
    
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"sectSuge"]) {
        
        NSIndexPath *indexPath = sender;
        
        SpecialDetailModel *model = self.dataArray[indexPath.row];
        
        [segue.destinationViewController setValue:model.aid forKey:@"aaid"];

    }
    
    
}




@end
