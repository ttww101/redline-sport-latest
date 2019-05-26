#import <UIKit/UIKit.h>
@protocol TitleIndexViewDelegate<NSObject>
@optional
- (void)didSelectedAtIndex:(NSInteger)index;
@end
@interface RLSTitleIndexView : UIView
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) CGFloat pageWidth;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) UIColor *bottomLineColor;
@property (nonatomic, strong) UIColor *seletedColor;
@property (nonatomic, strong) UIColor *nalColor;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, weak) id<TitleIndexViewDelegate> delegate;
- (void)updateSelectedIndex:(NSInteger)index;
- (void)selectedEndNO:(NSInteger)index;
@end
