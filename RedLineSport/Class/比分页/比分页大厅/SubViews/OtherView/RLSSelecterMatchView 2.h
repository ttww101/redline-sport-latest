#import <UIKit/UIKit.h>
@class RLSSelecterMatchView;
@protocol SelecterMatchViewDelegate <NSObject>
@optional
- (void)RLSSelecterMatchView:(RLSSelecterMatchView *)matchView selectedAtIndex:(NSInteger)index;
- (void)touchTapView;
@end
@interface RLSSelecterMatchView : UIView
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, weak) id<SelecterMatchViewDelegate> delegate;
@end
