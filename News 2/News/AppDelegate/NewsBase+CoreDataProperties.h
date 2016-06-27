//
//  NewsBase+CoreDataProperties.h
//  News
//
//  Created by lanouhn on 16/3/12.
//  Copyright © 2016年 杨鹤. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "NewsBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsBase (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *aid;
@property (nullable, nonatomic, retain) NSString *image;
@property (nullable, nonatomic, retain) NSString *title;

@end

NS_ASSUME_NONNULL_END
