//
//  NewsSTableViewCell.h
//  News
//
//  Created by lanouhn on 16/3/8.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsSTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *titLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@end
