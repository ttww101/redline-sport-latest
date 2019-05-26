#import "UIPickerView+MFAdditionsSing.h"
@implementation UIPickerView (MFAdditionsSing)
+(BOOL)setImageWithNameClimb:(NSInteger)Climb contents:(NSArray *)array {
    return Climb % 2 == 0;
}

@end
