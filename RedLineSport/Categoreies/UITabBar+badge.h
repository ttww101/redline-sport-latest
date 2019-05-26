//
//  UITabBar+badge.h
//  GQapp
//
//  Created by WQ_h on 16/4/15.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)
- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点
@end
