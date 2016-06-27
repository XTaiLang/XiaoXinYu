//
//  NewsHTableViewCell.h
//  News
//
//  Created by lanouhn on 16/3/8.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsHTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *textlabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
