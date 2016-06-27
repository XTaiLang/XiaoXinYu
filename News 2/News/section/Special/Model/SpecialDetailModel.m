//
//  SpecialDetailModel.m
//  News
//
//  Created by lanouhn on 16/3/7.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "SpecialDetailModel.h"

@implementation SpecialDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        self.aid = value;
    }
    
}

@end
