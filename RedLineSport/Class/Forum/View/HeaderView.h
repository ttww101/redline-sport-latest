//
//  HeaderView.h
//  GQZhiBo
//
//  Created by genglei on 2018/11/21.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChampionModel.h"
#import "Modules.h"

@interface HeaderView : UIView

@property (nonatomic , copy) NSArray<ChampionModel *> *champions;
@property (nonatomic , copy) NSArray<ModulesInfo *> *modules;

@end

