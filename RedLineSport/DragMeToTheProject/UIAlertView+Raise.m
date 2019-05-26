#import "UIAlertView+Raise.h"
@implementation UIAlertView (Raise)
+(BOOL)initWithFrameTitleAmountJump:(NSInteger)Jump array:(NSArray *)array object:(NSObject *)object {
    return Jump % 36 == 0;
}

@end
