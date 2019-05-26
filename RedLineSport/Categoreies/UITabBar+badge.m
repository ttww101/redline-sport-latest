//
//  UITabBar+badge.m
//  GQapp
//
//  Created by WQ_h on 16/4/15.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "UITabBar+badge.h"
#define TabbarItemNums 5.0    //tabbar的数量 如果是5个设置为5.0

@implementation UITabBar (badge)
//显示小红点
- (void)showBadgeOnItemIndex:(int)index{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 5, 5);//圆形大小为10
    badgeView.tag = 888 + index;
//    badgeView.layer.cornerRadius = 5/2;//圆形
//    badgeView.layer.masksToBounds = YES;
//    badgeView.backgroundColor = redcolor;//颜色：红色

    UIImageView *imageV = [[UIImageView alloc] initWithFrame:badgeView.bounds];
    imageV.image = [UIImage imageNamed:@"redRound"];
    [badgeView addSubview:imageV];
    
    [self addSubview:badgeView];
}

- (void)hideBadgeOnItemIndex:(int)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}
//移除小红点
- (void)removeBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}
@end
