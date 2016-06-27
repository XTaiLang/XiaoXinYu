//
//  NowModel.m
//  News
//
//  Created by lanouhn on 16/3/4.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "NowModel.h"

@implementation NowModel


- (void)setValueFromeDictionary:(NSDictionary *)dic
{
 
    self.title = dic[@"title"];
    
    self.createdAt = dic[@"createdAt"];
    
    self.contentHtml = dic[@"contentHtml"];
    
    if ([dic[@"detailPost"] isEqual:[NSNull null]]) {
        
        self.detailPost = @"null";
        
        self.imageUrl = nil;
        
    }else{
        
        NSMutableDictionary *dict = dic[@"detailPost"];
        
        self.imageUrl = dict[@"imageUrl"];
        
    }
    
}

@end
