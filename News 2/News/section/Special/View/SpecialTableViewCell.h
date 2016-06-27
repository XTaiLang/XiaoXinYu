//
//  SpecialTableViewCell.h
//  News
//
//  Created by lanouhn on 16/3/7.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabe;

@end
