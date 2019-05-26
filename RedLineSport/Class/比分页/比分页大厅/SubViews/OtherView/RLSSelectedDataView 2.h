#import <UIKit/UIKit.h>
@class RLSSelectedDataView;
@protocol SelecterDateViewDelegate <NSObject>
@optional
- (void)RLSSelecterMatchView:(RLSSelectedDataView *)matchView selectedAtIndex:(NSInteger)index WithSelectedName:(NSString *)name;
- (void)touchTapView;
@end
@interface RLSSelectedDataView : UIView
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, weak) id<SelecterDateViewDelegate> delegate;
- (void)updateSelectedIndex:(NSInteger)index;
@end
