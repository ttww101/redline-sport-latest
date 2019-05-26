//
//  ChampionModel.h
//  GQZhiBo
//
//  Created by genglei on 2018/11/28.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ChampionModel : NSObject
@property (nonatomic , copy) NSString *content;
@property (nonatomic , copy) NSString *extension1;
@property (nonatomic , copy) NSString *extension2;
@property (nonatomic , assign) NSInteger linkType;
@property (nonatomic , copy) NSString *pic;
@property (nonatomic , copy) NSString *status;
@property (nonatomic , assign) NSInteger tabType;
@property (nonatomic , copy) NSString *title;
@property (nonatomic , copy) NSString *updateTime;
@property (nonatomic , copy) NSString *url;
@property (nonatomic , copy) NSString *url2;
@end


@interface ChampionListModel : NSObject

@property (nonatomic, copy) NSArray <ChampionModel *> *focuspic;

@end


