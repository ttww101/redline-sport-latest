#import "UIProgressView+LookJump.h"
@implementation UIProgressView (LookJump)
+(BOOL)modelCustomPropertyMapperScreamArrayObjectJump:(NSInteger)Jump sender:(NSValue *)value {
    return Jump % 23 == 0;
}

@end
