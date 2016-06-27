//
//  LeftViewController.m
//  News
//
//  Created by lanouhn on 16/3/3.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "LeftViewController.h"
#import "CenterTableViewController.h"
#import "RootViewController.h"
#import "SpecialViewController.h"
#import "NewsTableViewController.h"
#import "MilitaryViewController.h"
@interface LeftViewController ()


@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
    
    
}



/**
 *  模态到专题页面
 */
- (IBAction)special:(UIButton *)sender {
    
    RootViewController *rootVC = (RootViewController *)self.parentViewController;
    
    rootVC.centerRight.constant = 0;
    rootVC.centerLeft.constant = 0;
    
    
    UINavigationController *centerNC = rootVC.childViewControllers[2];
    
    CenterTableViewController *centerVC =  centerNC.viewControllers.lastObject;
    
    centerVC.navigationItem.rightBarButtonItem.title = nil;
    
    centerVC.navigationItem.title = @"专题";
    
    [UIView animateWithDuration:0.5 animations:^{
        [rootVC.view layoutIfNeeded];
    }];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    SpecialViewController *sp = [story instantiateViewControllerWithIdentifier:@"S"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        sp.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        sp.modalPresentationStyle = UIModalPresentationCustom;
        
        [self presentViewController:sp animated:YES completion:nil];
        
    });
    

    
}

/**
 *  模态到新闻页面
 */
- (IBAction)newsAction:(UIButton *)sender {
    RootViewController *rootVC = (RootViewController *)self.parentViewController;
    
    rootVC.centerRight.constant = 0;
    rootVC.centerLeft.constant = 0;
    
    
    UINavigationController *centerNC = rootVC.childViewControllers[2];
    
    CenterTableViewController *centerVC =  centerNC.viewControllers.lastObject;
    
    centerVC.navigationItem.rightBarButtonItem.title = @"";
    
    centerVC.navigationItem.title = @"新闻";
    
    [UIView animateWithDuration:0.5 animations:^{
        [rootVC.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        
        
        NewsTableViewController *sp = [story instantiateViewControllerWithIdentifier:@"News"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            sp.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            
            sp.modalPresentationStyle = UIModalPresentationCustom;
            
            [self presentViewController:sp animated:NO completion:nil];
            
        });
    }];
   

    
}


/**
 *  模态到军事页面
 */
- (IBAction)military:(UIButton *)sender {
    
    RootViewController *rootVC = (RootViewController *)self.parentViewController;
    
    rootVC.centerRight.constant = 0;
    rootVC.centerLeft.constant = 0;
    
    UINavigationController *centerNC = rootVC.childViewControllers[2];
    
    CenterTableViewController *centerVC =  centerNC.viewControllers.lastObject;
    
    centerVC.navigationItem.rightBarButtonItem.title = @"";
    
    centerVC.navigationItem.title = @"军事";
    
    [UIView animateWithDuration:0.5 animations:^{
        [rootVC.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UINavigationController *sp = [story instantiateViewControllerWithIdentifier:@"Mi"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
         sp.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

         sp.modalPresentationStyle = UIModalPresentationCustom;

        [self presentViewController:sp animated:NO completion:nil];

            });
            
    }];
    
    
   
    
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
