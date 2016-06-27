//
//  FrontTableViewController.m
//  News
//
//  Created by lanouhn on 16/3/10.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "FrontTableViewController.h"
#import "AllHeaders.h"
#import "ZeroTableViewCell.h"
#import "OneTableViewCell.h"
#import "TwoTableViewCell.h"
@interface FrontTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) NSInteger page;

@end

@implementation FrontTableViewController


-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerCell];
    
    [self tableViewRefreshUI];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)registerCell{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZeroTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"123"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"1234"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"12345"];
    
    // 估算高度 (平均高度)
    self.tableView.estimatedRowHeight = 40;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
}


- (void)tableViewRefreshUI
{
    __weak typeof(self)weakself = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.page = 0;
        
        [weakself loadDataFromeNet];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        self.page ++;
        
        [weakself loadDataFromeNet];
    }];
    
}




- (void)loadDataFromeNet
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    NSString *string = [NSString stringWithFormat:kfront, self.page];
    
    [manager GET:string parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *array = responseObject[@"newsList"];
        
        if (self.page == 0) {
            
            [self.dataSource removeAllObjects];
        }
        
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            ChooseModel *model = [[ChooseModel alloc] init];
            
            [model modelSetValueWithDictionary:obj];
            
            [self.dataSource addObject:model];
            
            
        }];
        if (self.page == 0) {
            
            [self.tableView.mj_header endRefreshing];
            
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        
        [self.tableView reloadData];

        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"失败");
        
    }];
    
    
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"frontS" sender:indexPath];
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
    
    ChooseModel *model = self.dataSource[indexPath.row];
    
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
    
    NSIndexPath *indexPath = sender;
    
    ChooseModel *model = self.dataSource[indexPath.row];
    
    [segue.destinationViewController setValue:model.aid forKey:@"aid"];
    
    [segue.destinationViewController setValue:model.timeAgo forKey:@"dateString"];
}


@end
