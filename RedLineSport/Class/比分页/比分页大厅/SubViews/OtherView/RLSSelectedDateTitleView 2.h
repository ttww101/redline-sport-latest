#import "RLSQiciModel.h"
#import <UIKit/UIKit.h>
@protocol SelectedDateTitleViewDelegate<NSObject>
@optional
- (void)selectedDateViewIndex:(NSInteger)index;
- (void)RLSSelectedDateTitleViewDidAction:(NSArray *)array;
@end
@interface RLSSelectedDateTitleView : UIView
@property (nonatomic, assign) BOOL isSaiguo;
@property (nonatomic, assign) BOOL isBeforeTwo; 
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, weak) id<SelectedDateTitleViewDelegate> delegate;
@end
