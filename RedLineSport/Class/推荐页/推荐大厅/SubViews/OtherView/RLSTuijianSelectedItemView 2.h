#import <UIKit/UIKit.h>
@protocol TuijianSelectedItemViewDelegate<NSObject>
@optional
- (void)touchBgView;
- (void)selectedWithItem:(NSInteger)item WithIndex:(NSInteger)index WithTitle:(NSString *)title;
- (void)touchWithItem:(NSInteger)item WithIndex:(NSInteger)index WithTitle:(NSString *)title;
@end
@interface RLSTuijianSelectedItemView : UIView
@property (nonatomic, assign) NSInteger play;
@property (nonatomic, strong) NSArray *arrSaishi;
@property (nonatomic,weak) id<TuijianSelectedItemViewDelegate> delegate;
- (void)updateWithIndex:(NSInteger)index;
- (void)updateWithIndexAttentioned:(BOOL)selected;
@end
