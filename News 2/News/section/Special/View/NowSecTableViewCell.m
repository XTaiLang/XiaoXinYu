//
//  NowSecTableViewCell.m
//  News
//
//  Created by lanouhn on 16/3/5.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "NowSecTableViewCell.h"

@implementation NowSecTableViewCell

- (void)awakeFromNib {
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
