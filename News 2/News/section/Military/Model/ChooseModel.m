//
//  ChooseModel.m
//  News
//
//  Created by lanouhn on 16/3/9.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import "ChooseModel.h"

@implementation ChooseModel

- (void)modelSetValueWithDictionary:(NSDictionary *)dic
{
    
    
    self.aid = dic[@"id"];
    
    self.title = dic[@"title"];
    
    if ([dic[@"picOne"] isEqualToString:@""]) {
        self.picOne = @"0";
    }else{
        
    self.picOne = dic[@"picOne"];
        
    }
    
    if ([dic[@"picTwo"] isEqualToString:@""]) {
        
        self.picTwo = @"1";
        
    }else{
        
        self.picTwo = dic[@"picTwo"];
        
    }
    if([dic[@"picThr"] isEqualToString:@""]){
        
    self.picThr = @"1";
        
    }else{

        self.picThr = dic[@"picThr"];
        
    }
    
    self.timeAgo = dic[@"timeAgo"];
}


@end
