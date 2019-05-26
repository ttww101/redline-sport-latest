#import <UIKit/UIKit.h>
typedef void(^didSelectAction)(id selectAction);
@interface RLSLiveQuizAlertView : UIView
+ (instancetype)showPaymentInfo:(id)information
                     animations:(BOOL)animation
                   selectOption:(didSelectAction)selectAction;
@end
