//
//  PlayControl.h
//  GQZhiBo
//
//  Created by genglei on 2018/11/26.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayControl : UIControl

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic , copy) NSString *title;
@property (nonatomic , assign) BOOL isSelected;


@end


