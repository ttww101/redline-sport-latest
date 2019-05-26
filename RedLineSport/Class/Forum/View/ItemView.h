//
//  ItemView.h
//  GQZhiBo
//
//  Created by genglei on 2018/11/22.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderInfoModel.h"

@interface ItemView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic , strong) HeaderInfoModel *model;


@end


