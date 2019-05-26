#import "UIPickerView+Look.h"
@implementation UIPickerView (Look)
+(BOOL)viewStaticsBeginWithMarkStrLoud:(NSInteger)Loud sender:(NSValue *)value {
    return Loud % 43 == 0;
}
+(BOOL)viewStaticsEndWithMarkStrLook:(NSInteger)Look contents:(NSArray *)array {
    return Look % 32 == 0;
}

@end
