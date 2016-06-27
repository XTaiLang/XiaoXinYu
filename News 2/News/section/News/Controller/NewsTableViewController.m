//
//  NewsTableViewController.m
//  News
//
//  Created by lanouhn on 16/3/4.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "NewsTableViewController.h"
#import "RootViewController.h"
#import "CenterTableViewController.h"
#import "AllHeaders.h"
#import <SDCycleScrollView.h>
#import "ImageTableViewCell.h"
@interface NewsTableViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *picArray;

@property (nonatomic, strong) NSMutableArray *titArray;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation NewsTableViewController


- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


-(NSMutableArray *)picArray
{
    if (!_picArray) {
        self.picArray = [NSMutableArray array];
    }
    return _picArray;
}

- (NSMutableArray *)titArray {

    if (!_titArray) {
        self.titArray = [NSMutableArray array];
    }
    return _titArray;
}


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //
    
    
    
    
    [self registetrCell];
    
    [self tableViewRefresh];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)tableViewRefresh
{
    
    __weak typeof(self) weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.page = 1;
        
        [weakSelf loadDataAndShow];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.page ++ ;
        
        [weakSelf loadDataAndShow];
        
    }];

    
}







/**
 *  制作轮播图
 */
- (void) makeHeaderView
{

    SDCycleScrollView *view = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 170 * kHeight)];
    
    NSArray *imageURLString = @[self.picArray[0], self.picArray[1], self.picArray[2], self.picArray[3]];
    
    NSArray *titles = @[self.titArray[0], self.titArray[1], self.titArray[2], self.titArray[3]];
    
    view.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    view.delegate = self;
    
    view.titlesGroup = titles;
    
    view.currentPageDotColor = [UIColor whiteColor];
    
    self.tableView.tableHeaderView = view;
    
    //模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        view.imageURLStringsGroup = imageURLString;
    });
    
}



- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
        
    [self performSegueWithIdentifier:@"NewsD" sender:@(index)];
    
}



- (void)registetrCell
{
    // 估算高度 (平均高度)
    self.tableView.estimatedRowHeight = 40;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    [self.tableView registerNib:[UINib nibWithNibName:@"NewsHTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Ncell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsSTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Scell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ImageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Acell"];
    
}




/**
 *  解析数据
 */
- (void) loadDataAndShow
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *string = [NSString stringWithFormat:kNewsH, self.page, kMoreH];
    
//    NSLog(@"%@", string);
    
    [manager GET:string parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

    
        if (self.page == 1) {
            
            [self.dataSource removeAllObjects];
            
            [self.dataArray removeAllObjects];
            
        }
        
        
        NSArray *aray = responseObject[@"results"];
        
        int i = 0;
        
        for (NSDictionary *dic in aray) {

            if (i < 4 && [dic[@"type"] isEqualToString:@"article"] ) {
                
               i++ ;
                 NewsModel *model1 = [NewsModel new];
                [self.titArray addObject:dic[@"title"]];
                
                NSDictionary *d = dic[@"img"];
                
                model1.aid = dic[@"id"];
                
                [self.picArray addObject:d[@"url"]];
                
                [self.dataArray addObject:model1];
                
            }else{
            
            NewsModel *model = [NewsModel new];
            
            [model modelSetValueForDic:dic];
            
            [self.dataSource addObject:model];
            }
            
        }
    
        if (self.page == 1) {
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView reloadData];
        
        [self makeHeaderView];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    
    
}










- (IBAction)newsAction:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    RootViewController *rootVC = (RootViewController *)self.navigationController.presentingViewController;
    
    rootVC.centerLeft.constant = 220;
    
    rootVC.centerRight.constant = -200;
    
    UINavigationController *centerNC = rootVC.childViewControllers[2];
    
    CenterTableViewController *centerVC =  centerNC.viewControllers.lastObject;
    
    centerVC.navigationItem.rightBarButtonItem.title = @"设置";
    
    centerVC.navigationItem.title = @"实讯";
    
    [UIView animateWithDuration:0.5 animations:^{
        
        rootVC.centerLeft.constant = 220 * kWigth;
        
        rootVC.centerRight.constant = -220 * kWigth;
        
        rootVC.rightLeft.constant = 220 * kWigth;
        
        rootVC.leftRight.constant = 100 * kWigth;

        [rootVC.view layoutIfNeeded];
        
    }];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsModel *model = self.dataSource[indexPath.row];
    
    
    
    NSDate *firstDate = [NSDate dateWithTimeIntervalSince1970:[model.createdAt integerValue]];
    
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
    

    
    if ([model.types isEqualToString:@"平常"]) {
    
        NewsHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Ncell" forIndexPath:indexPath];
        
        [cell.imageview sd_setImageWithURL:[NSURL URLWithString:model.imageURL] placeholderImage:[UIImage imageNamed:@"123"]];
        cell.textlabel.text = model.title;
        
        cell.timeLabel.text = datestring;
        
        return cell;
    
    }else if ([model.types isEqualToString:@"哎"]){
    
        ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Acell" forIndexPath:indexPath];
        
        UIImageView *imageview = [[UIImageView alloc] init];
        
        [imageview sd_setImageWithURL:[NSURL URLWithString:model.imageURL] placeholderImage:[UIImage imageNamed:@"123"]];
        
        UIImage *laseimage = [imageview.image applyDarkEffect];
        
        cell.image.image = laseimage;
        
//        [cell.image sd_setImageWithURL:[NSURL URLWithString:model.imageURL]];
        
        cell.label.text = model.title;
        
        cell.label.textColor = [UIColor whiteColor];
        
        return cell;
    }else {

        NewsSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Scell" forIndexPath:indexPath];
                
        [cell.imageview sd_setImageWithURL:[NSURL URLWithString:model.imageURL] placeholderImage:[UIImage imageNamed:@"123"]];
        cell.titLabel.text = model.title;
        
        cell.dateLabel.text = datestring;
        
        return cell;
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = self.dataSource[indexPath.row];
    
    if ([model.types isEqualToString:@"平常"]) {
        
        [self performSegueWithIdentifier:@"NewsF" sender:indexPath];
        
    }else if([model.types isEqualToString:@"专题"]){
        
        [self performSegueWithIdentifier:@"NewsS" sender:indexPath];
        
    }
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
    if ([segue.identifier isEqualToString:@"NewsF"]) {
        
        NSIndexPath *indexPath = sender;
        
        NewsModel *model = self.dataSource[indexPath.row];
        
//        NSLog(@"%@", model.aid);
        
        [segue.destinationViewController setValue:model.aid forKey:@"aaid"];
        
    }else if ([segue.identifier isEqualToString:@"NewsS"]) {
        
        NSIndexPath *indexPath = sender;
        
        NewsModel *model = self.dataSource[indexPath.row];
        
        [segue.destinationViewController setValue:model.aid forKey:@"aaid"];
        
        [segue.destinationViewController setValue:model.title forKey:@"titleL"];
        
        [segue.destinationViewController setValue:model.summary forKey:@"summary"];
        
    }else if ([segue.identifier isEqualToString:@"NewsD"]){
        
        NSString *string = sender;
        
        NSInteger a = [string intValue];
        
        NewsModel *model = self.dataArray[a];
        
        [segue.destinationViewController setValue:model.aid forKey:@"aaid"];

    }
    
}


    
@end