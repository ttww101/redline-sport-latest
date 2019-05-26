#import <UIKit/UIKit.h>
@interface RLSUserTuijianTable : RLSBasicTableView
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger oddtype;
- (void)loadNewData;
@end
