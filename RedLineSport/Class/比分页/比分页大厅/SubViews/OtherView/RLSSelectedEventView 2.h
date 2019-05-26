#import <UIKit/UIKit.h>
@protocol SelectedEventViewDelegate<NSObject>
@optional
- (void)didSelectedAtIndex:(NSInteger)index;
@end
@interface RLSSelectedEventView : UIView
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) CGFloat pageWidth;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) NSString *attentionNum;
@property (nonatomic, weak) id<SelectedEventViewDelegate> delegate;
- (void)updateSelectedIndex:(NSInteger)index;
@end
