#import <UIKit/UIKit.h>
@protocol AllSelectedViewDelegate<NSObject>
@optional
- (void)didSelectedAtBtnIndex:(NSInteger)index whtherSelected:(BOOL)selected;
@end
@interface RLSAllSelectedView : UIView
@property (nonatomic, strong) UIButton *btnAll;
@property (nonatomic, strong) UIButton *btnNotAll;
@property (nonatomic, weak) id<AllSelectedViewDelegate> delegate;
- (void)changeBtnSelectedState:(BOOL)isSelected;
@property (nonatomic, strong) UIButton *btnConfirm;
@end
