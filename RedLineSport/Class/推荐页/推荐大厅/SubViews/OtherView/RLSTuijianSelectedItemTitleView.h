#import <UIKit/UIKit.h>
@protocol TuijianSelectedItemTitleViewDelegate<NSObject>
@optional
- (void)tapTuijianSelectedItemTitleViewAtindex:(NSInteger)index;
@end
@interface RLSTuijianSelectedItemTitleView : UIView
@property (nonatomic, weak) id<TuijianSelectedItemTitleViewDelegate> delegate;
- (void)updateSelectedIndexWithindex:(NSInteger)index WithTitle:(NSString *)title;
- (void)attentionBtnSelected:(BOOL)selected;
@end
