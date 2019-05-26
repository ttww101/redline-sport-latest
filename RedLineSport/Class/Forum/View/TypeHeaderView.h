//
//  TypeHeaderView.h
//  GQZhiBo
//
//  Created by genglei on 2018/11/22.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemView.h"
#import "Modules.h"

@interface TypeHeaderView : UIView

@property (nonatomic, copy) NSArray<HeaderInfoModel *> *dataSource;
@property (nonatomic , strong) ModulesInfo *modelInfo;


@end

