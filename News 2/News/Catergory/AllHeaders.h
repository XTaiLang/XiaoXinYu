//
//  AllHeaders.h
//  News
//
//  Created by lanouhn on 16/3/4.
//  Copyright © 2016年 杨鹤. All rights reserved.
//

#ifndef AllHeaders_h
#define AllHeaders_h

#pragma mark -----------------时讯-------------------
#define KnowNewsString @"http://api.wallstreetcn.com/v2/livenews?cid=&type=&importance=&_eva_t=1446886069&page=%ld&limit=20"

#pragma maek -----------------专题--------------------
#define kSpecialURL @"http://api.wallstreetcn.com/v2/posts/specials?_eva_t=1446885816&page=%ld&limit=10"

#pragma maek ---------------专题详情--------------------
#define kSpecialDetailURL @"http://api.wallstreetcn.com/v2/posts/special/%@?_eva_t=1446887184&page=%ld&limit=10"

#pragma mark --------------专题   信息-----------------
#define kSpecailS @"http://api.wallstreetcn.com/v2/posts/%@"


#pragma mark ---------------新闻主页--------------------
#define kNewsH @"http://api.wallstreetcn.com/v2/mobile-articles?channel=global&device=android&version=3&_eva_t=1446884783&page=%ld&%@"
#define kMoreH @"limit=20&%28null%29=%3CInforViewController%3A+0x14756d3b0%3E"


#pragma mark ---------------军事推荐------------------------

#define kMilitary @"http://api.wap.miercn.com/api/2.0.3/newlist.php?list=1&page=%ld&plat=android&proct=mierapp&versioncode=20150807&apiCode=4"

#pragma mark ----------------军事热点----------------------
#define kHot @"http://api.wap.miercn.com/api/2.0.3/newlist.php?list=2&page=%ld&plat=android&proct=mierapp&versioncode=20150807&apiCode=4"


#pragma mark ------------------军事历史------------
#define kHistory @"http://api.wap.miercn.com/api/2.0.3/newlist.php?list=4&page=%ld&plat=android&proct=mierapp&versioncode=20150807&apiCode=4"


#pragma mark ------------------军事环球--------
#define kworld @"http://api.wap.miercn.com/api/2.0.3/newlist.php?list=5&page=%ld&plat=android&proct=mierapp&versioncode=20150807&apiCode=4"


#pragma mark ------------------军事前沿-----------
#define kfront @"http://api.wap.miercn.com/api/2.0.3/newlist.php?list=3&page=%ld&plat=android&proct=mierapp&versioncode=20150807&apiCode=4"


#pragma mark ------------------军事详情-----------
#define kDetail @"http://api.wap.miercn.com/api/2.0.3/article_json.php?id=%@&plat=android&proct=mierapp&versioncode=20150807&apiCode=4"


#define kWigth [UIScreen mainScreen].bounds.size.width / 320
#define kHeight [UIScreen mainScreen].bounds.size.height / 468

#import <AFNetworking.h>
#import "NowModel.h"
#import "NowFirstViewCell.h"
#import "NowSecTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "SpecialModel.h"
#import "SpecialTableViewCell.h"
#import "SpecialDetailModel.h"
#import "SpecialDetailViewCell.h"
#import "NewsModel.h"
#import "NewsHTableViewCell.h"
#import "NewsSTableViewCell.h"
#import "UIImage+ImageEffects.h"
#import "ChooseModel.h"



#endif /* AllHeaders_h */
