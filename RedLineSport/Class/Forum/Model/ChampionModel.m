//
//  ChampionModel.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/28.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ChampionModel.h"

@implementation ChampionModel

@end

@implementation ChampionListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"focuspic" : NSClassFromString(@"ChampionModel") };
}

@end

