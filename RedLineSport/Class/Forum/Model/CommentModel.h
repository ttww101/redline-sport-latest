//
//  CommentModel.h
//  GQZhiBo
//
//  Created by genglei on 2018/11/21.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

/**
 头像
 */
@property(nonatomic, copy) NSString *avaterUrl;

/**
 日期
 */
@property(nonatomic, copy) NSString *publishTime;

/**
 日期
 */
@property(nonatomic, copy) NSString *dateStr;

/**
 用户名
 */
@property(nonatomic, copy) NSString *nickname;

/**
 内容
 */
@property(nonatomic, copy) NSString *content;

/**
 单元格高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

/**
 文本高度
 */
@property (nonatomic, assign) CGFloat contentHeight;

/**
 用户ID
 */
@property (nonatomic , copy) NSString *userId;

- (void)calculateCellHeight;

@end


