//
//  CollectViewController.m
//  News
//
//  Created by lanouhn on 16/3/12.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "CollectViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "NewsBase.h"
#import "CollectTableViewCell.h"
#import "AllHeaders.h"
@interface CollectViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    BOOL _isPush;
    BOOL _isAT;
}

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) AppDelegate *appDelegate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIView *playView;

@property (nonatomic, strong) UIToolbar *toolBar;

@end

@implementation CollectViewController




- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        self.dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}



- (UIView *)playView
{
    if (!_playView) {

        self.playView  = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 49)];

        self.playView.backgroundColor = [UIColor lightGrayColor];

//        [self.view addSubview:self.playView];

        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];

        backButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49);

        backButton.backgroundColor = [UIColor colorWithRed:120 green:0 blue:0 alpha:0.6];

        [backButton setImage:[UIImage imageNamed:@"回收"] forState:(UIControlStateNormal)];
        
        // [backButton setTitle:@"删除" forState:(UIControlStateNormal)];

        [backButton addTarget:self action:@selector(handledelect:) forControlEvents:(UIControlEventTouchUpInside)];

        [self.playView addSubview:backButton];


    }
    return _playView;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    


    
    self.appDelegate = [UIApplication sharedApplication].delegate;
    
    // 估算高度 (平均高度)
    self.tableView.estimatedRowHeight = 40;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.leftBarButtonItem = ({
        UIBarButtonItem *leftB = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
        leftB;
    });
//        self.navigationItem.rightBarButtonItem = ({
//            UIBarButtonItem *leftB = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction:)];
//            leftB;
//        });
//    
    self.navigationItem.rightBarButtonItem.title = @"删除";
//    
//    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 49)];
//    
//    self.toolBar.backgroundColor = [UIColor yellowColor];
//    
//    [self.view addSubview:self.toolBar];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Ecell"];
    
    self.navigationItem.title = @"收藏";
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.playView];
    
    
}




- (void)leftAction:(UIBarButtonItem *)sender {
    
    if ([self.navigationItem.leftBarButtonItem.title isEqualToString:@"返回"]) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    }else if ([self.navigationItem.leftBarButtonItem.title isEqualToString:@"取消"]){
        
        self.navigationItem.leftBarButtonItem.title = @"返回";
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
        
        self.navigationItem.rightBarButtonItem.title = @"删除";
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.navigationItem.title = @"收藏";
            
        }];
        
        [UIView animateWithDuration:0.7 animations:^{
    
        self.playView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 49);
    
        }];
            
        _isAT = !_isAT;
        
        [self.tableView setEditing:_isAT animated:YES];
        
        
    }
    
    
}





- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self allNews];
}





- (void)allNews
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"NewsBase" inManagedObjectContext:self.appDelegate.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"<#format string#>", <#arguments#>];
    //    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"aid"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    
    NSArray *fetchedObjects = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedObjects == nil) {
        
        NSLog(@"%@", error);
        
    }else{
        
        self.dataArray = [NSMutableArray arrayWithArray:fetchedObjects];
        
        [self.tableView reloadData];
        
    }
    
    
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
    CollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Ecell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    NewsBase *model = self.dataArray[indexPath.row];
    
    cell.label.text = model.title;
    
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"22"]];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.navigationItem.leftBarButtonItem.title isEqualToString:@"返回"]){
        
        [self performSegueWithIdentifier:@"MoreSuge" sender:indexPath];
        
    }
    
}





- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}





- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    
    [super setEditing:!_isAT animated:animated];
    
    [UIView animateWithDuration:0.7 animations:^{

        self.playView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 49, [UIScreen mainScreen].bounds.size.width, 49);
    }];
    
    self.navigationItem.title = @"请选择你要删除的内容";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:(UIBarButtonItemStylePlain) target:self action:@selector(handleRightButton:)];
    self.navigationItem.leftBarButtonItem.title = @"取消";
    
    [self.tableView setEditing:!_isAT animated:YES];
    
    _isAT = !_isAT;
    
}






- (void)handleRightButton:(UIBarButtonItem *)sender
{
    
    for (int i = 0; i < self.dataArray.count; i ++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
     
        
        
    }
    
    
    // 取消全选
/*
//    NSMutableArray *indexPathArray = [NSMutableArray arrayWithArray:self.tableView.indexPathsForSelectedRows];
//    
//    // ascending 升序排序 这里的key一定要是数组中的对象的属性
//    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"row" ascending:NO];
//    
//    [indexPathArray sortUsingDescriptors:@[sortDescriptor]];
//    
//    NSString *string = [NSString stringWithFormat:@"删除(%ld)", indexPathArray.count];
//    
//    [self.minVCView.deleteBt setTitle:string forState:(UIControlStateNormal)];
//    
//}
//
//} else {
//    
//    for (int i = (int)self.mineCollectionData.count - 1; i >= 0; i--) {
//        
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//        
//        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//        
//        [self.minVCView.deleteBt setTitle:@"删除" forState:(UIControlStateNormal)];
//        
//    }
//
*/    
    
    
    
    
}






- (void)handledelect:(UIButton *)sender
{
    
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.tableView.indexPathsForSelectedRows];
        
    // 这里面key一定要是对象的属性
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"row" ascending:NO];
    
    [array sortUsingDescriptors:@[sortDescriptor]];
    
    for (NSIndexPath *indexPath in array) {
        
        
        NewsBase *model = self.dataArray[indexPath.row];
        
        [self.appDelegate.managedObjectContext deleteObject:model];
        
        [self.appDelegate saveContext];
        
        // 再删除数据源数据
        [self.dataArray removeObjectAtIndex:indexPath.row];
        
        // 删除cell
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}






// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}


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
    
    NewsBase *base = self.dataArray[indexPath.row];
    
    [segue.destinationViewController setValue:base.aid forKey:@"aid"];
    
}



@end
