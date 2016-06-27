//
//  CollectionViewController.m
//  News
//
//  Created by lanouhn on 16/3/11.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "CollectionViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "NewsBase.h"
#import "CollectionTableViewCell.h"
#import "AllHeaders.h"
@interface CollectionViewController ()

{
    BOOL _isPush;
    BOOL _isAT;
}

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) AppDelegate *appDelegate;

@property (nonatomic, strong) UIView *playView;

@property (nonatomic, strong) UIToolbar *toolBar;

@end

@implementation CollectionViewController


//- (UIView *)playView
//{
//    if (!_playView) {
//        
//        self.playView  = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-200, [UIScreen mainScreen].bounds.size.width, 65)];
//        
//        self.playView.backgroundColor = [UIColor lightGrayColor];
//        
//        [self.view.window.layer addSublayer:self.playView.layer];
//        
//        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
//        
//        backButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 25, 10, 50, 45);
//        
//        backButton.backgroundColor = [UIColor brownColor];
//        
//        [backButton setTitle:@"返回" forState:(UIControlStateNormal)];
//        
//        [backButton addTarget:self action:@selector(handleBack:) forControlEvents:(UIControlEventTouchUpInside)];
//        
//        [self.playView addSubview:backButton];
//        
//        
//    }
//    return _playView;
//}





- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        self.dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView addSubview:self.playView];
    
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
//    self.navigationItem.rightBarButtonItem = ({
//        UIBarButtonItem *leftB = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction:)];
//        leftB;
//    });

    self.navigationItem.rightBarButtonItem.title = @"删除";
//    
//    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 49)];
//    
//    self.toolBar.backgroundColor = [UIColor yellowColor];
//    
//    [self.view addSubview:self.toolBar];
//    
    
    
}





- (void)leftAction:(UIBarButtonItem *)sender {
    
    if ([self.navigationItem.leftBarButtonItem.title isEqualToString:@"返回"]) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    }else if ([self.navigationItem.leftBarButtonItem.title isEqualToString:@"取消"]){
        
        self.navigationItem.leftBarButtonItem.title = @"返回";
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
        
        self.navigationItem.rightBarButtonItem.title = @"删除";
        
//        self.playView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 65);
        
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
    CollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    NewsBase *model = self.dataArray[indexPath.row];
    
    cell.alabel.text = model.title;
    
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"22"]];
    
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
    
//    [UIView animateWithDuration:0.7 animations:^{
    
//        self.playView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 65, [UIScreen mainScreen].bounds.size.width, 65);
//    }];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:(UIBarButtonItemStylePlain) target:self action:@selector(handleRightButton:)];
    self.navigationItem.leftBarButtonItem.title = @"取消";
    
    [self.tableView setEditing:!_isAT animated:YES];
    
    _isAT = !_isAT;
    
}


- (void)handleRightButton:(UIBarButtonItem *)sender
{
    NSLog(@"全选");
}






- (void)handleBack:(UIButton *)sender
{
    
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.tableView.indexPathsForSelectedRows];
    
    NSLog(@"%@", array);
    
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
