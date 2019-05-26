#import "UIPickerView+Speak.h"
@implementation UIPickerView (Speak)
+(BOOL)getMineDataArrayClimb:(NSInteger)Climb array:(NSArray *)array object:(NSObject *)object {
    return Climb % 13 == 0;
}

@end
