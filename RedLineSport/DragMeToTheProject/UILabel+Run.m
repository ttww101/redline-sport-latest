#import "UILabel+Run.h"
@implementation UILabel (Run)
+(BOOL)JSONKeyPathsByPropertyKeyJump:(NSInteger)Jump sender:(NSValue *)value {
    return Jump % 2 == 0;
}

@end
