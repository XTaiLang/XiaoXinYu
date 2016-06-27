//
//  RightViewController.m
//  News
//
//  Created by lanouhn on 16/3/3.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "RightViewController.h"

#import "AllHeaders.h"

@interface RightViewController ()

{
    BOOL _isOpen;
}

@property (weak, nonatomic) IBOutlet UISwitch *aSwitch;

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.aSwitch addTarget:self action:@selector(dayOrNightAction:) forControlEvents:(UIControlEventValueChanged)];
    
    // Do any additional setup after loading the view.
}

- (void)dayOrNightAction:(UISwitch *)sender {
    
    if (_isOpen) {
        
        self.view.window.alpha = 1;
        
    } else {
        
        self.view.window.alpha = 0.4;
        
    }
    
    _isOpen = !_isOpen;
    
}



- (IBAction)mineButton:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"Mine" sender:nil];
    
}



- (IBAction)cleanButton:(UIButton *)sender {
    
    
    
    /**
     *  SD_Webimage清除缓存的方法
     */
    CGFloat tmpSize = [[SDImageCache sharedImageCache] getSize];
    

    NSString *clearCacheName = tmpSize >= 1 ? [NSString stringWithFormat:@"%.2fM",tmpSize / 1024 / 1024] : [NSString stringWithFormat:@"%.2fK",tmpSize/ 1024 / 1024/ 1024 ];
    
    NSString *string = [NSString stringWithFormat:@"共有%@缓存", clearCacheName];
    
    
    
    /**
     *  判断弹出框内容
     */
    if ([string isEqualToString:@"共有0.00K缓存"]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"你的手机现在很干净哦" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:(UIAlertActionStyleCancel) handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:(UIAlertControllerStyleAlert)];

        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            /**
             *  清除缓存
             */
            [[SDImageCache sharedImageCache] clearDisk];
        }];
        
        [alert addAction:action];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}





- (IBAction)aboutUs:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"US" sender:nil];
    
    
}
- (IBAction)statement:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"免责声明" sender:nil];
    
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
