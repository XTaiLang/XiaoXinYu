//
//  MoreModel.m
//  News
//
//  Created by lanouhn on 16/3/12.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "MoreModel.h"

@implementation MoreModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
 
    if ([key isEqualToString:@"id"]) {
        
        self.aid = value;
        
    }
    
}

@end
