//
//  UITableView+SDAutoTableViewCellHeight.h
//  TestDemo
//
//  Created by Marjoice on 18/09/2017.
//  Copyright © 2017 zhuliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDCellAutoHeightManager;

#define kSDModelCellTag 199206

@interface UITableView (SDAutoTableViewCellHeight)

@property (nonatomic, strong) SDCellAutoHeightManager *cellAutoHeightManager;


- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath model:(id)model keyPath:(NSString *)keyPath cellClass:(Class)cellClass contentViewWidth:(CGFloat)contentViewWidth;
- (void)startAutoCellHeightWithCellClass:(Class)cellClass contentViewWidth:(CGFloat)contentViewWidth NS_DEPRECATED(10_0, 10_4, 6_0, 6_0);
- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath model:(id)model keyPath:(NSString *)keyPath NS_DEPRECATED(10_0, 10_4, 6_0, 6_0);
- (void)startAutoCellHeightWithCellClasses:(NSArray *)cellClassArray contentViewWidth:(CGFloat)contentViewWidth NS_DEPRECATED(10_0, 10_4, 6_0, 6_0);
- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath model:(id)model keyPath:(NSString *)keyPath cellClass:(Class)cellClass NS_DEPRECATED(10_0, 10_4, 6_0, 6_0);

@end

@interface UITableViewController (SDTableViewControllerAutoCellHeight)
- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath cellContentViewWidth:(CGFloat)width;

@end

@interface NSObject (SDAnyObjectAutoCellHeight)
- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath cellContentViewWidth:(CGFloat)width tableView:(UITableView *)tableView;

@end




// ------------------------------- 以下为库内部使用无须了解 --------------------

@interface SDCellAutoHeightManager : NSObject

@property (nonatomic, assign) CGFloat contentViewWidth;

@property (nonatomic, assign) Class cellClass;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) UITableViewCell *modelCell;

- (void)clearHeightCache;

- (void)clearHeightCacheOfIndexPaths:(NSArray *)indexPaths;

- (NSNumber *)heightCacheForIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath model:(id)model keyPath:(NSString *)keyPath;

- (CGFloat)cellHeightForIndexPath:(NSIndexPath *)indexPath model:(id)model keyPath:(NSString *)keyPath cellClass:(Class)cellClass;

- (instancetype)initWithCellClass:(Class)cellClass;
+ (instancetype)managerWithCellClass:(Class)cellClass;
@end

