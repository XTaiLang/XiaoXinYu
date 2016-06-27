//
//  ChooseTableViewController.m
//  News
//
//  Created by lanouhn on 16/3/9.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "ChooseTableViewController.h"
#import <SDCycleScrollView.h>
#import "AllHeaders.h"

#import "ZeroTableViewCell.h"
#import "OneTableViewCell.h"
#import "TwoTableViewCell.h"

@interface ChooseTableViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy) NSString *atitle;

@property (nonatomic, copy) NSString *aid;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) NSMutableArray *idArray;

@property (nonatomic, assign) NSInteger page;

@end
@implementation ChooseTableViewController


- (NSMutableArray *)idArray
{
    if (!_idArray) {
        self.idArray = [NSMutableArray array];
    }
    return _idArray;
}


- (NSMutableArray *)titleArray
{
    if (!_titleArray) {
        self.titleArray = [NSMutableArray array];
    }
    return _titleArray;
}



- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        self.imageArray = [NSMutableArray array];
    }
    return _imageArray;
}



- (NSMutableArray *)dataArray {

    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}





- (void)viewDidLoad {
    [super viewDidLoad];

    [self refreshUI];
    
    // 注册cell
    [self registerCell];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



/**
 *  刷新界面
 */

- (void)refreshUI
{
    
    __weak typeof(self)weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.page = 0;
        
        [weakSelf loadDataFromeNet];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.page ++;
        
        [weakSelf loadDataFromeNet];
        
    }];
    
    
    
}






/**
 *  注册cell
 */
- (void)registerCell {

    [self.tableView registerNib:[UINib nibWithNibName:@"ZeroTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"123"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"1234"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"12345"];
    
    // 估算高度 (平均高度)
    self.tableView.estimatedRowHeight = 40;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}




/**
 *  解析数据
 */
- (void) loadDataFromeNet
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *string = [NSString stringWithFormat:kMilitary, self.page];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    [manager GET:string parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSArray *dicArray = responseObject[@"picsList"];
        
        if (self.page == 0) {
            
            [self.dataArray removeAllObjects];
        }
        
        
        [dicArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.titleArray addObject:obj[@"title"]];
            
            [self.imageArray addObject:obj[@"img"]];
            
            ChooseModel *model1 = [[ChooseModel alloc] init];
            
            model1.aid = obj[@"id"];
            
            model1.publishTime = obj[@"publishTime"];
            
            [self.idArray addObject:model1];
            
            
        }];
        
        
        NSMutableArray *array = responseObject[@"newsList"];
        
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            ChooseModel *model = [[ChooseModel alloc] init];
            
            [model modelSetValueWithDictionary:obj];
            
            [self.dataArray addObject:model];
            
        }];
        
        
        if (self.page == 0) {
            
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


/**
 *  做轮播图
 */
- (void)makeHeaderView
{
    SDCycleScrollView *view = [[SDCycleScrollView alloc] initWithFrame:(CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, 150 * kHeight))];
    
    view.delegate = self;
    
    view.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    view.titlesGroup = self.titleArray;
    
    view.currentPageDotColor = [UIColor whiteColor];
    
    self.tableView.tableHeaderView = view;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        view.imageURLStringsGroup = self.imageArray;
    });
    
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{

    // ChooseModel *model = self.idArray[index];
    
    [self performSegueWithIdentifier:@"PicID" sender:@(index)];


    
}






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
   
    
    ChooseModel *model = self.dataArray[indexPath.row];
    
     if ([model.picOne isEqualToString:@"0"]) {
        
        ZeroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123" forIndexPath:indexPath];
        
        cell.titlelabel.text = model.title;
         
         
         
         
        cell.datelabel.text = model.timeAgo;
         
        return cell;
        
     }else if([model.picTwo isEqualToString:@"1"]) {
     
         TwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1234" forIndexPath:indexPath];
         
         cell.titlelabel.text = model.title;
         
         [cell.firstImage sd_setImageWithURL:[NSURL URLWithString:model.picOne] placeholderImage:[UIImage imageNamed:@"123"]];
         
         cell.datelabel.text = model.timeAgo;
         
         return cell;
 
     }else{
     
         OneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"12345"];
         
         cell.titlelabel.text = model.title;
         
         cell.dataLabel.text = model.timeAgo;
         
         [cell.firstImage sd_setImageWithURL:[NSURL URLWithString:model.picOne] placeholderImage:[UIImage imageNamed:@"123"]];
 
         [cell.secImage sd_setImageWithURL:[NSURL URLWithString:model.picTwo] placeholderImage:[UIImage imageNamed:@"123"]];
 
         [cell.thrImage sd_setImageWithURL:[NSURL URLWithString:model.picThr] placeholderImage:[UIImage imageNamed:@"123"]];
 
         return cell;
     }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"detail1" sender:indexPath];
}




- (void) aibvua{

//    
//    else if ([model.picTwo isEqualToString:@"1"] ||[model.picTwo isEqualToString:@"1"]){
//        
//        NSLog(@"一张图片");
//        
//        TwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1234" forIndexPath:indexPath];
//        cell.titlelabel.text = model.title;
//        [cell.firstImage sd_setImageWithURL:[NSURL URLWithString:model.picOne] placeholderImage:[UIImage imageNamed:@"123"]];
//        return cell;
//    }else
//    {
//        OneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"12345"];
//        cell.titlelabel.text = model.title;
//        [cell.firstImage sd_setImageWithURL:[NSURL URLWithString:model.picOne] placeholderImage:[UIImage imageNamed:@"123"]];
//        
//        [cell.secImage sd_setImageWithURL:[NSURL URLWithString:model.picTwo] placeholderImage:[UIImage imageNamed:@"123"]];
//        
//        [cell.thrImage sd_setImageWithURL:[NSURL URLWithString:model.picThr] placeholderImage:[UIImage imageNamed:@"123"]];
//        
//        NSLog(@"三张图片");
//        return cell;
//    }

    
    
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
    if ([segue.identifier isEqualToString:@"PicID"]) {
//        
        NSString *str = sender;
//
        NSInteger index = [str integerValue];
        
        ChooseModel *model = self.idArray[index];
        
        NSDate *firstDate = [NSDate dateWithTimeIntervalSince1970:[model.publishTime integerValue]];
        
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
        NSString *adatestring = [formatter stringFromDate:firstDate];
        
        
        
        [segue.destinationViewController setValue:model.aid forKey:@"aid"];
        
        
        [segue.destinationViewController setValue:adatestring forKey:@"dateString"];
        
        // [segue.destinationViewController setValue:str forKey:@"aid"];
        
    }else if ([segue.identifier isEqualToString:@"detail1"]){
        
    NSIndexPath *indexPath = sender;
    
    ChooseModel *model = self.dataArray[indexPath.row];
        
    [segue.destinationViewController setValue:model.aid forKey:@"aid"];
    
    [segue.destinationViewController setValue:model.timeAgo forKey:@"dateString"];
    }
    
}

@end
