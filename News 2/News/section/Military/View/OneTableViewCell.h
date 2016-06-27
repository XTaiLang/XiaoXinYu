//
//  OneTableViewCell.h
//  News
//
//  Created by lanouhn on 16/3/9.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstImage;
@property (weak, nonatomic) IBOutlet UIImageView *secImage;
@property (weak, nonatomic) IBOutlet UIImageView *thrImage;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;

@end
