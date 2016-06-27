//
//  NewsModel.m
//  News
//
//  Created by lanouhn on 16/3/8.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel


- (void)modelSetValueForDic:(NSDictionary *)dic
{
    if ([dic[@"type"] isEqualToString:@"article"]) {
        
        self.summary = dic[@"summary"];
        
        self.types = @"平常";
        
        self.aid = dic[@"id"];
        
        self.title = dic[@"title"];
        
        self.createdAt = dic[@"createdAt"];
        
        NSDictionary *dict = dic[@"img"];
        
        self.imageURL = dict[@"url"];
        
    }else if ([dic[@"type"] isEqualToString:@"external-article"]){
    
        self.summary = dic[@"summary"];
        
        self.types = @"哎";
        
        self.aid = dic[@"id"];
        
        self.title = dic[@"title"];
        
        self.createdAt = dic[@"createdAt"];
        
        NSDictionary *dict = dic[@"img"];
        
        self.imageURL = dict[@"url"];

        
    }else{
        
        self.types = @"专题";
        
        self.summary = dic[@"summary"];
        
        self.aid = dic[@"id"];
        
        self.title = dic[@"title"];
        
        self.createdAt = dic[@"createdAt"];
        
        NSDictionary *dict = dic[@"img"];
        
        self.imageURL = dict[@"url"];
        
        
        
        
        
    }
    
    
}






- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
