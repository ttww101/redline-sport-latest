//
//  Excellent.h
//  GQZhiBo
//
//  Created by genglei on 2018/11/28.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeaderInfoModel.h"
@class ExcellentInfo;

@interface Excellent : NSObject

@property (nonatomic, strong) NSMutableArray <HeaderInfoModel *> *excellent;
@property (nonatomic, strong) NSMutableArray <HeaderInfoModel *> *all;
@property (nonatomic, strong) NSMutableArray <HeaderInfoModel *> *top;

@end

@interface ExcellentInfo : NSObject

@property (nonatomic , copy) NSString *commentCount;
@property (nonatomic , copy) NSString *content;
@property (nonatomic , copy) NSString *cream;
@property (nonatomic , copy) NSString *hot;
@property (nonatomic , copy) NSString *image1;
@property (nonatomic , copy) NSString *image2;
@property (nonatomic , copy) NSString *image3;
@property (nonatomic , copy) NSString *nickname;
@property (nonatomic , copy) NSString *postId;
@property (nonatomic , copy) NSString *publishTime;
@property (nonatomic , copy) NSString *title;
@property (nonatomic , copy) NSString *top;
@property (nonatomic , copy) NSString *userId;
@property (nonatomic , copy) NSString *viewCount;

@end


