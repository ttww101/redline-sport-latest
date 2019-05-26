//
//  HeaderInfoModel.h
//  GQZhiBo
//
//  Created by genglei on 2018/11/20.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Layout.h"
#import <YYCategories/YYCategories.h>
#import "CommentModel.h"

@interface HeaderInfoModel : NSObject
/**
 // 图片大小 当前只显示三张图片展示固定高度 未来展示九宫格方便扩展
 */
@property (nonatomic, strong) Layout *picLayout;

/**
 Header View 高度
 */
@property (nonatomic, assign) CGFloat headerHeight;

/**
 用户名
 */
@property(nonatomic, copy) NSString *nickname;

/**
 内容
 */
@property(nonatomic, copy) NSString *content;

/**
 内容富文本
 */
@property(nonatomic, strong) NSMutableAttributedString *messageAtt;

/**
 内容富文本
 */
@property(nonatomic, assign) CGFloat messageAttHeight;

/**
 标题
 */
@property(nonatomic, copy) NSString *title;

/**
 头像
 */
@property(nonatomic, copy) NSString *avaterUrl;

/**
 日期
 */
@property(nonatomic, copy) NSString *dateStr;

/**
 评论数量
 */
@property(nonatomic, copy) NSString *commentCount;

/**
 查看次数
 */
@property(nonatomic, copy) NSString *seeCount;

/**
 图片数组
 */
@property(nonatomic, copy) NSArray *images;

/**
 是否加精
 */
@property (nonatomic , copy) NSString *cream;

/**
 热门帖子
 */
@property (nonatomic , copy) NSString *hot;

/**
 发布ID
 */
@property (nonatomic , copy) NSString *postId;

/**
 发布时间
 */
@property (nonatomic , copy) NSString *publishTime;

@property (nonatomic , copy) NSString *top;

/**
 用户ID
 */
@property (nonatomic , copy) NSString *userId;

/**
 查看数量
 */
@property (nonatomic , copy) NSString *viewCount;

/**
 精选评论
 */
@property (nonatomic , strong) CommentModel *comment;

/**
 精选评论
 */
@property (nonatomic , strong) NSString *navTitle;

- (void)setupInfo;

@end





