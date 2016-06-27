//
//  RootViewController.h
//  News
//
//  Created by lanouhn on 16/3/3.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerRight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftRight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightRight;

@end
