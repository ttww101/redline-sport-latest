#import "UIPickerView+RunListen.h"
@implementation UIPickerView (RunListen)
+(BOOL)JSONKeyPathsByPropertyKeyJumpSenderRaise:(NSInteger)Raise array:(NSArray *)array object:(NSObject *)object {
    return Raise % 40 == 0;
}

@end
