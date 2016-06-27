//
//  SpecialDetailViewController.h
//  News
//
//  Created by lanouhn on 16/3/7.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@property (weak, nonatomic) IBOutlet UILabel *titLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIWebView *contactLabel;





@property (nonatomic, strong) NSString *aaid;


@property (nonatomic, strong) NSString *atitle;

@property (nonatomic, strong) NSString *createdAt;

@property (nonatomic, strong) NSString *imageUrl;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *screenName;

@property (nonatomic, strong) NSString *avatar;



@end
