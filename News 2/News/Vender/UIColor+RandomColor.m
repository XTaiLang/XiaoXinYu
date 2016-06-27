//
//  UIColor+RandomColor.m
//  UILessonDesginModel-05
//
//  Created by lanouhn on 15/12/4.
//  Copyright (c) 2015年 yangcanghe. All rights reserved.
//

#import "UIColor+RandomColor.h"

#define kNum arc4random_uniform(256)/255.0
@implementation UIColor (RandomColor)

+ (UIColor *)randomcolor {

    return [UIColor colorWithRed:123 green:123 blue:123  alpha:0 ];

}


@end
