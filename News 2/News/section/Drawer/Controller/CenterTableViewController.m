//
//  CenterTableViewController.m
//  News
//
//  Created by lanouhn on 16/3/3.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "CenterTableViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "RootViewController.h"
#import "SpecialViewController.h"
#import "AllHeaders.h"

@interface CenterTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) NSInteger page;

@end

@implementation CenterTableViewController

- (NSMutableArray *)dataSource {

    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSwipeGesture];
    
    // [self loadDataAndShow];
    
    [self regsetCell];
    
    // self.page = 1;

    
    
    
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
    
    
/* self.tableView.showsVerticalScrollIndicator = NO;
    
//    
//    
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        // 进入刷新状态后会自动调用这个block
//        self.page = 1;
//        
//    }];
//    
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDataAndShow)];
//    
//    
//    // 马上进入刷新状态
//
//    
//    
//    
//    
//    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
//        self.page++;
//    }];
//    
//    
//
//    
//    
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDataAndShow)];
*/
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

/**
 *  注册cell 估算cell的高度
 */
- (void)regsetCell
{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NowFirstViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NowSecTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"secondcell"];
    
    
    
    // 估算高度 (平均高度)
    self.tableView.estimatedRowHeight = 40;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
}






/**
 *  添加手势
 */
- (void)addSwipeGesture
{
    // 轻扫手势
    UISwipeGestureRecognizer *leftswipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftswipeGestureAction:)];
    
    // 设置清扫手势支持的方向
    leftswipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    
    // 添加手势
    [self.tableView addGestureRecognizer:leftswipeGesture];

    // 添加手势
    [self.view addGestureRecognizer:leftswipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightswipeGestureAction:)];
    
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:rightSwipeGesture];
    

    
    

}


/**
 *  左轻扫
 */
- (void)leftswipeGestureAction:(UISwipeGestureRecognizer *)sender {
    
    RootViewController *rootVC = (RootViewController *)self.navigationController.parentViewController;

    [UIView animateWithDuration:0.5 animations:^{
        
        if (rootVC.centerLeft.constant != 0) {
            
            rootVC.centerLeft.constant = 0;
            rootVC.centerRight.constant = 0;
            rootVC.rightRight.constant = 0;
            rootVC.rightLeft.constant = 0;
            rootVC.leftLeft.constant = 0;
            rootVC.leftRight.constant = 0;

            
        }else{
            rootVC.centerRight.constant = 220 * kWigth;
            rootVC.centerLeft.constant = -220 * kWigth;
            rootVC.leftRight.constant = 220 * kWigth;
            rootVC.rightLeft.constant = 100 * kWigth;
            
            /*
//    LeftViewController *leftVC = self.navigationController.parentViewController.childViewControllers[0];
//    RightViewController *rightVC = self.navigationController.parentViewController.childViewControllers[1];



//            leftVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//            rightVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            
//            rightVC.view.frame = CGRectMake(100, 0, 220, [UIScreen mainScreen].bounds.size.height);
//            leftVC.view.frame = CGRectMake(-220, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        */
            
        }
        
        [rootVC.view layoutIfNeeded];
    }];

    
}


/**
 *  右轻扫
 */
- (void)rightswipeGestureAction:(UISwipeGestureRecognizer *)sender {

    RootViewController *rootVC = (RootViewController *)self.navigationController.parentViewController;
    
    [UIView animateWithDuration:0.5 animations:^{
        
    if (rootVC.centerLeft.constant != 0) {
        
        rootVC.centerLeft.constant = 0;
        rootVC.centerRight.constant = 0;
        rootVC.rightRight.constant = 0;
        rootVC.rightLeft.constant = 0;
        rootVC.leftLeft.constant = 0;
        rootVC.leftRight.constant = 0;
       
    }else{
    
        rootVC.centerLeft.constant = 220 * kWigth;
        rootVC.centerRight.constant = -220 * kWigth;
        rootVC.rightLeft.constant = 220 * kWigth;
        rootVC.leftRight.constant = 100 * kWigth;
/*
//    LeftViewController *leftVC = self.navigationController.parentViewController.childViewControllers[0];
//    RightViewController *rightVC = self.navigationController.parentViewController.childViewControllers[1];
// leftVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
// rightVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);


//leftVC.view.frame = CGRectMake(0, 0, 220, [UIScreen mainScreen].bounds.size.height);
//rightVC.view.frame = CGRectMake(220, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
 
 */
 
    }
    
    [rootVC.view layoutIfNeeded];
        
    }];

}



/**
 *  左边的Item点击事件
 */
- (IBAction)menu:(UIBarButtonItem *)sender {
    
    
    RootViewController *rootVC = (RootViewController *)self.navigationController.parentViewController;
    
    [UIView animateWithDuration:0.5 animations:^{
        
    if (rootVC.centerLeft.constant != 0) {
        
        rootVC.centerLeft.constant = 0;
        rootVC.centerRight.constant = 0;
        rootVC.rightRight.constant = 0;
        rootVC.rightLeft.constant = 0;
        rootVC.leftLeft.constant = 0;
        rootVC.leftRight.constant = 0;
        
    }else{
        
        rootVC.centerLeft.constant = 220 * kWigth;
        rootVC.centerRight.constant = - 220 * kWigth;
        rootVC.rightLeft.constant = 220 *kWigth;
        rootVC.leftRight.constant = 100 * kWigth;
                /*
//    RightViewController *rightVC = self.navigationController.parentViewController.childViewControllers[1];
//
//    LeftViewController *leftVC = self.navigationController.parentViewController.childViewControllers[0];
//    leftVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height);
//    rightVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);


// leftVC.view.frame = CGRectMake(0, 0, 220, [UIScreen mainScreen].bounds.size.height);
// rightVC.view.frame = CGRectMake(220, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                 
                 */
    }
    
        [rootVC.view layoutIfNeeded];
    }];
    
/*
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        if (centerNC.view.center.x != rootVC.view.center.x){
//            
//            
//           rightVC.view.frame = CGRectMake(0, 0, rightVC.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//            
//            centerNC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//            
//            
//        }else{
//            
//            
//            centerNC.view.frame = CGRectMake(leftVC.view.bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//            
//           rightVC.view.frame = CGRectMake(leftVC.view.bounds.size.width, 0, rightVC.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//            
//        }
////        [rootVC.view layoutIfNeeded];
//    }];
//    
*/
    
}



/**
 *  左边的Item点击事件
 */
- (IBAction)set:(UIBarButtonItem *)sender {
    
    
    RootViewController *rootVC = (RootViewController *)self.navigationController.parentViewController;
    
    [UIView animateWithDuration:0.5 animations:^{
        
    if (rootVC.centerRight.constant != 0) {
        
        
        rootVC.centerLeft.constant = 0;
        rootVC.centerRight.constant = 0;
        rootVC.rightRight.constant = 0;
        rootVC.rightLeft.constant = 0;
        rootVC.leftLeft.constant = 0;
        rootVC.leftRight.constant = 0;
        
        
    }else{
                
                
        rootVC.centerRight.constant = 220 * kWigth;
        rootVC.centerLeft.constant = -220 * kWigth;
        rootVC.leftRight.constant = 220 * kWigth;
        rootVC.rightLeft.constant = 100 * kWigth;
                /*
//      LeftViewController *leftVC = self.navigationController.parentViewController.childViewControllers[0];
//      RightViewController *rightVC = self.navigationController.parentViewController.childViewControllers[1];
//      rightVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//      leftVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);

        
//      rightVC.view.frame = CGRectMake(100, 0, 220, [UIScreen mainScreen].bounds.size.height);
//      leftVC.view.frame = CGRectMake(-220, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        */
    
    }
    
        [rootVC.view layoutIfNeeded];
    }];
    
}




- (void)loadDataAndShow
{
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:KnowNewsString, self.page]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                        
            NSMutableArray *resultsArray = dic[@"results"];
            
            for (NSDictionary *dic in resultsArray) {
                
                // NSLog(@"%@", dic);
                
                NowModel *model = [[NowModel alloc] init];
                
                [model setValueFromeDictionary:dic];
                
                [self.dataSource addObject:model];
                                
            }
            
        }
        
        
            __weak typeof(self)weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                if (weakSelf.page == 1) {
                    [weakSelf.tableView.mj_header endRefreshing];
                }else{
                
                    
                
                    [weakSelf.tableView.mj_footer endRefreshing];
                    
                }
                
                [self.tableView reloadData];
            });
        // [self.tableView.header endRefreshing];
        

    }];
    
    [dataTask resume];
    
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
    
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // Configure the cell...
    
    NowModel *model = self.dataSource[indexPath.row];
    
    
    //将时间戳转换为时间对象
    
    NSDate *firstDate = [NSDate dateWithTimeIntervalSince1970:[model.createdAt integerValue]];
    
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
    
    if ([model.detailPost isEqualToString:@"null"]) {
        
        /**
         *  练习:将Date4以2015年份11月份24号 11点43分20秒
         */
        /*NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        [formatter1 setDateFormat:@"yyyy年MM月dd日"];
        
        NSString *dates = [formatter1 stringFromDate:SecDate];
        NSLog(@"%@", dates);
         */
        
        NowFirstViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        cell.timeLabel.text = datestring;
        
        cell.titleLabel.text = model.title;
        
        return cell;
        
    }else {
        
        NowSecTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secondcell" forIndexPath:indexPath];
        
        cell.timeLabel.text = datestring;
        
        cell.titleLabel.text = model.title;
        
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"123"]];
        
        return cell;
        
    }
    
    
    
}
/*
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
////    UIStoryboard *s = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
////    
////    NDetailViewController *sb = [s instantiateViewControllerWithIdentifier:@"C"];
////    
////    [self.navigationController pushViewController:sb animated:YES];
//
//    NowModel *model = self.dataSource[indexPath.row];
//    
//    if ([model.detailPost isEqualToString:@"null"]) {
//        
//    
//        
//        
//    }else {
//        
//        [self performSegueWithIdentifier:@"segue2" sender:nil];
//    }
//}
*/
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
}

@end
