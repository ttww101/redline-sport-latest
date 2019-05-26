//
//  GeneralFloatingView.h
//  GQZhiBo
//
//  Created by genglei on 2018/12/3.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GeneralFloatingViewDelegate <NSObject>

- (void)floatingViewDidSelected:(NSInteger)sender;

@end

@interface GeneralFloatingView : UIView

- (instancetype)initWithImages:(NSArray *)images
                         scale:(CGFloat)scale
                  ignoreTabBar:(BOOL)isIgnoreTabBar;

@property (nonatomic, weak) id <GeneralFloatingViewDelegate> delegate;


@end


