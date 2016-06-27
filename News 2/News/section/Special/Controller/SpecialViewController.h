//
//  SpecialViewController.h
//  News
//
//  Created by lanouhn on 16/3/4.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SpecialViewController;
@protocol SpecialDelegate <NSObject>

- (void)changeSelfFrame:(SpecialViewController *)special;

@end

@interface SpecialViewController : UITableViewController

@property (nonatomic, assign) id<SpecialDelegate> delegate;

@end
