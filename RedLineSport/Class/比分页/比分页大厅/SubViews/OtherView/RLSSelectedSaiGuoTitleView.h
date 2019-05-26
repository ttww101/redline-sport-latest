#import "RLSQiciModel.h"
#import <UIKit/UIKit.h>
@protocol SelectedSaiGuoTitleViewDelegate<NSObject>
@optional
- (void)selectedSaiGuoViewIndex:(NSInteger)index;
@end
@interface RLSSelectedSaiGuoTitleView : UIView
@property (nonatomic, assign) BOOL isSaiguo;
@property (nonatomic, assign) BOOL isBeforeTwo; 
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, weak) id<SelectedSaiGuoTitleViewDelegate> delegate;
- (void)setDateIndex:(NSInteger)index;
@end
