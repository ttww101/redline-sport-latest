//
//  Modules.h
//  GQZhiBo
//
//  Created by genglei on 2018/11/28.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ModulesInfo;

@interface Modules : NSObject

@property (nonatomic, copy) NSArray<ModulesInfo *> *modules;

@end


@interface ModulesInfo : NSObject

@property (nonatomic , copy) NSString *bgPic;
@property (nonatomic , copy) NSString *count;
@property (nonatomic , copy) NSString *icon;
@property (nonatomic , copy) NSString *moduleId;
@property (nonatomic , copy) NSString *name;
@property (nonatomic , copy) NSString *weight;

@end
