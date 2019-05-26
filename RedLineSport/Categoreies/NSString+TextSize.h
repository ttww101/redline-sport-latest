//
//  NSString+TextSize.h
//  GQapp
//
//  Created by WQ on 2017/5/16.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TextSize)

- (NSMutableAttributedString *)lineTextboundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing;
/**
 * 计算文字高度，可以处理计算带行间距的
 */
- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing;
//判断如果包含中文
- (BOOL)containChinese:(NSString *)str;
    /**
     *  计算最大行数文字高度,可以处理计算带行间距的
     */
- (CGFloat)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing maxLines:(NSInteger)maxLines;
    /**
     *  计算是否超过一行   用于给Label 赋值attribute text的时候 超过一行设置lineSpace
     */
- (BOOL)isMoreThanOneLineWithSize:(CGSize)size font:(UIFont *)font lineSpaceing:(CGFloat)lineSpacing;

@end
