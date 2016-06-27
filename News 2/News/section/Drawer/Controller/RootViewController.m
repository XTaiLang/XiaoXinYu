//
//  RootViewController.m
//  News
//
//  Created by lanouhn on 16/3/3.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "RootViewController.h"
#import "AllHeaders.h"
@interface RootViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *Image;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getImage];
    
    
}



- (void)getImage
{
    
    UIImage *sourceImage = [UIImage imageNamed:@"123"];
    
    
    
    UIImage *lastImage = [sourceImage applyDarkEffect];
    
    
    
    self.Image.image = lastImage;
    
    
    
    
    
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
