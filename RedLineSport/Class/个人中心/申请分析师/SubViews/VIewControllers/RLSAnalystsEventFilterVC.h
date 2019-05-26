@protocol AnalystsEventFilterVCDelegate <NSObject>
- (void)backStr:(NSString *)str;
@end
#import "RLSBasicViewController.h"
@interface RLSAnalystsEventFilterVC : RLSBasicViewController
@property (nonatomic, assign)id<AnalystsEventFilterVCDelegate> delegate;
@end
