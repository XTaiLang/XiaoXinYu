//
//  ChooseModel.h
//  News
//
//  Created by lanouhn on 16/3/9.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChooseModel : NSObject

@property (nonatomic, copy) NSString *publishTime;

@property (nonatomic, copy) NSString *aid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *picOne;

@property (nonatomic, copy) NSString *picTwo;

@property (nonatomic, copy) NSString *picThr;

@property (nonatomic, copy) NSString *timeAgo;

@property (nonatomic, assign) NSInteger count;

- (void)modelSetValueWithDictionary:(NSDictionary *)dic;

@end
