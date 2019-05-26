//
//  ArchiveFile.h
//  果动校园
//
//  Created by     songguolin on 15/11/25.
//  Copyright © 2015年 GDSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ArchiveFile : NSObject

/**
 *  获取沙盒Library的文件目录。
 */
+ (NSString *)LibraryDirectory;

/**
 *  获取沙盒Document的文件目录。
 */
+ (NSString *)DocumentDirectory;

/**
 *  获取沙盒Preference的文件目录。
 */
+ (NSString *)PreferencePanesDirectory;

/**
 *  获取沙盒Caches的文件目录。
 */
+ (NSString *)CachesDirectory;
/**
 *  创建文件路径
 *
 *  @param directoryName 文件夹
 *  @param fileName      文件
 *
 *  @return 路径
 */
+ (NSString *)getFilePathWithDirectoryName:(NSString *)directoryName fileName:(NSString *)fileName;

/**
 *  文件是否存在
 *
 *  @param path 路径
 *
 *  @return YES／NO
 */
+(BOOL)isHaveFileWithPath:(NSString *)path;


#pragma mark 数据归档
/**
 *  数组本地化
 *
 *  @param path    路径
 *  @param dataArr 数组
 */
+ (BOOL)saveDataWithPath:(NSString *)path data:(NSMutableArray *)dataArr;

/**
 *  获取数组数据
 *
 *  @param path 路径
 *
 *  @return 数组
 */
+ (NSMutableArray *)getDataWithPath:(NSString *)path;


/**
 *  返回path路径下文件的文件大小。
 */
+ (double)sizeWithFilePath:(NSString *)path;

/**
 *  删除path路径下的文件。
 */
+ (void)clearCachesWithFilePath:(NSString *)path;


/**
 保存购买凭证

 @param proof 购买凭证
 @return 是否成功
 */
+ (BOOL)savePurchaseProof:(id)proof;

/**
 移除购买凭证

 @param proof 购买凭证
 @return 是否成功
 */
+ (BOOL)removerPurchaseProof:(id)proof;

@end
