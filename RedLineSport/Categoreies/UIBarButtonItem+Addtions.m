//
//  UIBarButtonItem+Addtions.m
//  GQapp
//
//  Created by WQ on 2016/11/29.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "UIBarButtonItem+Addtions.h"

@implementation UIBarButtonItem (Addtions)
+(UIBarButtonItem *)itemWithNormalImage:(UIImage *)normalImage HighImage:(UIImage *)highImage target:(id)target action:(SEL)section
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];

    [btn sizeToFit];
    [btn addTarget:target action:section forControlEvents:UIControlEventTouchUpInside];
    UIView *constain = [[UIView alloc]initWithFrame:btn.bounds];
    [constain addSubview:btn];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:constain];
    
    return item;
}

@end
