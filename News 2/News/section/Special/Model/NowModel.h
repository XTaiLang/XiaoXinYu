//
//  NowModel.h
//  News
//
//  Created by lanouhn on 16/3/4.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NowModel : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *createdAt;

@property (nonatomic, strong) NSString *imageUrl;

@property (nonatomic, strong) NSString *detailPost;

@property (nonatomic, strong) NSString *contentHtml;

- (void)setValueFromeDictionary:(NSDictionary *)dic;

@end
