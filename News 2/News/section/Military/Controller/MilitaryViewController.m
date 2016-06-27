//
//  MilitaryViewController.m
//  News
//
//  Created by lanouhn on 16/3/9.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "MilitaryViewController.h"
#import "RootViewController.h"
#import "CenterTableViewController.h"
#import "AllHeaders.h"
#import "SCNavTabBarController.h"
#import "ChooseTableViewController.h"
#import "HotTableViewController.h"
#import "HistoryTableViewController.h"
#import "FrontTableViewController.h"
#import "WorldTableViewController.h"
@interface MilitaryViewController ()

@end

@implementation MilitaryViewController

- (IBAction)miAction:(UIBarButtonItem *)sender {
    
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
    // Do any additional setup after loading the view.
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ChooseTableViewController *chooseVC = [story instantiateViewControllerWithIdentifier:@"choose"];
    chooseVC.title = @"推荐";
    
    HotTableViewController *hotVC = [story instantiateViewControllerWithIdentifier:@"Hot"];
    hotVC.title = @"热点";
    
    HistoryTableViewController *historyVC = [story instantiateViewControllerWithIdentifier:@"history"];
    historyVC.title = @"历史";

    WorldTableViewController *worldVC = [story instantiateViewControllerWithIdentifier:@"world"];
    worldVC.title = @"环球";
    
    FrontTableViewController *frontVC = [story instantiateViewControllerWithIdentifier:@"front"];
    frontVC.title = @"前沿";
    


    SCNavTabBarController *SCNavTB = [[SCNavTabBarController alloc] initWithSubViewControllers:@[chooseVC, hotVC, historyVC, worldVC, frontVC]];
    
    SCNavTB.view.backgroundColor = [UIColor whiteColor];
    
    [SCNavTB addParentController:self];
        
   // });
    
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
