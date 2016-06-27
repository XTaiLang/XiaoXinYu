//
//  SpecialViewController.m
//  News
//
//  Created by lanouhn on 16/3/4.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "SpecialViewController.h"
#import "RootViewController.h"
#import "CenterTableViewController.h"
#import "SpecailTableViewController.h"
#import "AllHeaders.h"
@interface SpecialViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) NSInteger page;

@end

@implementation SpecialViewController


- (NSMutableArray *)dataSource {

    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (void)viewWillAppear:(BOOL)animated {
    
    
    
    
}

- (IBAction)back:(UIBarButtonItem *)sender {
    
    
    
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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerCell];
    
    [self tableViewRefresh];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/**
 *  注册cell
 */
- (void)registerCell
{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SpecialTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SPcell"];
    
    // 估算高度 (平均高度)
    self.tableView.estimatedRowHeight = 40;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}

/**
 *  上拉刷新, 下拉加载
 */
- (void)tableViewRefresh
{
    
    __weak typeof(self) weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.page = 1;
        
        [weakSelf loadDataFromeNet];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.page ++ ;
        
        [weakSelf loadDataFromeNet];
        
    }];
    
}




/**
 *  解析数据
 */
- (void)loadDataFromeNet {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *str = [NSString stringWithFormat:kSpecialURL, self.page];
        
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        for (NSDictionary *dic in responseObject[@"results"]) {
            
            SpecialModel *model = [SpecialModel new];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.dataSource addObject:model];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
            if (self.page == 1) {
                
                [self.tableView.mj_header endRefreshing];
                
            }else{
                
                [self.tableView.mj_footer endRefreshing];
                
            }
            
            [self.tableView reloadData];
        });
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // NSLog(@"%@", error);
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
   
    SpecialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SPcell" forIndexPath:indexPath];
    
    SpecialModel *model = self.dataSource[indexPath.row];
    
    NSDate *firstDate = [NSDate dateWithTimeIntervalSince1970:[model.createdAt integerValue]];
    
    /**
     *  NSDateFormatter 日期格式类 继承自NSFormatter 主要作用是将NSDate对象转为某种格式,然后以字符串的形式输出
     */
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    /**
     *  设置日期格式中用到的字母的作用 y 代表年 M代表月 d代表日 H代表小时 m代表分钟  s代表秒
     */
    [formatter setDateFormat:@" MM-dd HH:mm"];
    /**
     *  将时间对象转为设定的格式  格式化的时候会自动加上距离零时区的间隔
     */
    NSString *datestring = [formatter stringFromDate:firstDate];
    
    cell.timeLabel.text = datestring;
    
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"123"]];
    
    cell.textLabe.text = model.title;
    
   
    
    return cell;
}


/**
 *  cell的点击事件
 */
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
/*
//    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    
//    SpecailTableViewController *SpecailVC = [story instantiateViewControllerWithIdentifier:@"SpecailD"];
//
    
   
//    SpecialModel *model = self.dataSource[indexPath.row];
//    
//     NSLog(@"%@", model.aid);
//
//    SpecailVC.aaid = model.aid;
//
//    [self.navigationController pushViewController:SpecailVC animated:YES];*/
    
    [self performSegueWithIdentifier:@"SpecialS" sender:indexPath];
    
    
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
    if ([segue.identifier isEqualToString:@"SpecialS"]) {
        
        NSIndexPath *indexPath = sender;
        
        SpecialModel *model = self.dataSource[indexPath.row];
        
        [segue.destinationViewController setValue:model.aid forKey:@"aaid"];
        
        [segue.destinationViewController setValue:model.title forKey:@"titleL"];
        
        [segue.destinationViewController setValue:model.summary forKey:@"summary"];
    }
    
}


@end
