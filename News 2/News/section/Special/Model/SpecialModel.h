//
//  SpecialModel.h
//  News
//
//  Created by lanouhn on 16/3/7.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialModel : NSObject

@property (nonatomic, strong) NSString *aid;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *createdAt;

@property (nonatomic, strong) NSString *imageUrl;

@property (nonatomic, strong) NSString *summary;

// - (void)modelSetValueForDic:(NSDictionary *)dic;

@end
