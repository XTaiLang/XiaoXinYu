//
//  DetailViewController.h
//  News
//
//  Created by lanouhn on 16/3/10.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, copy) NSString *aid;

@property (weak, nonatomic) IBOutlet UILabel *titlelabel;

@property (weak, nonatomic) IBOutlet UIWebView *DetailView;

@property (nonatomic, copy) NSString *dateString;

@property (weak, nonatomic) IBOutlet UILabel *namelabel;

@end
