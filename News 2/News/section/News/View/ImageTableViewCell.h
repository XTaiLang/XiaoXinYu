//
//  ImageTableViewCell.h
//  News
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end
